//
//  ShowTrendViewController.swift
//  iOS-Currency-Converter
//
//  Created by Prashuk Ajmera on 7/6/21.
//

import UIKit
import Charts
import TinyConstraints

class ShowTrendViewController: UIViewController {
    
    let service = APIService()
    let lineChartView = TrendChart()
    
    var trendBetween: (from: String, to: String, todayPrice: Double)!

    @IBOutlet weak var currentPriceLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setChart()
        setdata()
    }
    
    func setChart() {
        currentPriceLbl.text = "1 \(trendBetween.from) = \(trendBetween.todayPrice) \(trendBetween.to)"
        
        lineChartView.delegate = self
        
        view.addSubview(lineChartView)
        lineChartView.centerXToSuperview()
        lineChartView.top(to: view, offset: 100)
        lineChartView.horizontalToSuperview(insets: .left(20) + .right(20))
        lineChartView.width(view.frame.width - 40)
        lineChartView.height(view.frame.width * 0.80)
    }
    
    func setdata() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let today = Date()
        let todayString = dateFormatter.string(from: today)
        
        let date15Ago = Calendar.current.date(byAdding: .day, value: -15, to: Date())
        let date15AgoString = dateFormatter.string(from: date15Ago!)
        
        service.getHistoricData(for: trendBetween.from, to: trendBetween.to, fromDate: date15AgoString, toDate: todayString) { [self] priceData in
            var yValues: [ChartDataEntry] = []
            
            let sortedArray = priceData.rates.sorted { dateFormatter.date(from: $0.key)! < dateFormatter.date(from: $1.key)! }
            var xValue = 0.0
            for (_, v) in sortedArray {
                yValues.append(ChartDataEntry(x: xValue, y: v[trendBetween.to]!))
                xValue += 1.0
            }
            
            DispatchQueue.main.async {
                let set = LineChartDataSet(entries: yValues, label: trendBetween.to)
                
                set.mode = .cubicBezier
                set.drawCirclesEnabled = false
                set.lineWidth = 3
                set.setColor(.white)
                set.fill = Fill(color: .white)
                set.drawFilledEnabled = true
                
                let data = LineChartData(dataSet: set)
                lineChartView.data = data
            }
        }
    }
}

extension ShowTrendViewController: ChartViewDelegate {
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        currentPriceLbl.text = "1 \(trendBetween.from) = \(entry.y.toString()) \(trendBetween.to)"
    }
}
