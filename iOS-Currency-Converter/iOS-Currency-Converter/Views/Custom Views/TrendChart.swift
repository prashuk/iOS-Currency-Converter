//
//  TrendChart.swift
//  iOS-Currency-Converter
//
//  Created by Prashuk Ajmera on 7/6/21.
//

import Foundation
import UIKit
import Charts

class TrendChart: LineChartView {
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
        initChart()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initChart() {
        self.backgroundColor = .clear
        
        self.rightAxis.enabled = false
        self.leftAxis.enabled = false
        
        let xAxis = self.xAxis
        xAxis.labelFont = .boldSystemFont(ofSize: 8)
        xAxis.setLabelCount(6, force: false)
        xAxis.labelTextColor = .white
        xAxis.axisLineColor = .white
        xAxis.labelPosition = .bottom
        xAxis.drawAxisLineEnabled = true
        xAxis.drawGridLinesEnabled = false
        xAxis.drawLimitLinesBehindDataEnabled = true
        xAxis.avoidFirstLastClippingEnabled = false
        xAxis.granularity = 1.0
        xAxis.spaceMin = xAxis.granularity / 5
        xAxis.spaceMax = xAxis.granularity / 5
        xAxis.labelRotationAngle = -60.0
        xAxis.valueFormatter = XValueFormatter(startDate: Date(), intervalInDays: 1)
        
        self.animate(xAxisDuration: 2)
    }
}

class XValueFormatter : IAxisValueFormatter {
    
    var dateFormatter : DateFormatter
    var startDate: Date
    var intervalInDays: Int
    
    public init(startDate: Date, intervalInDays: Int) {
        self.startDate = startDate
        self.intervalInDays = intervalInDays
        self.dateFormatter = DateFormatter()
        self.dateFormatter.dateFormat = "MMM d, yyyy"
    }
    
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date15Ago = Calendar.current.date(byAdding: .day, value: -10, to: Date())
        let date2 = Calendar.current.date(byAdding: .day, value: Int(value) * intervalInDays, to: date15Ago!)!
//        let date2 = Date(timeIntervalSince1970: (value * Double(intervalInDays) ) + startDate)
        return dateFormatter.string(from: date2)
    }
}
