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
        self.backgroundColor = .systemBlue
        
        self.rightAxis.enabled = false
        self.leftAxis.enabled = false
        
        let xAxis = self.xAxis
        xAxis.labelFont = .boldSystemFont(ofSize: 12)
        xAxis.setLabelCount(6, force: false)
        xAxis.labelTextColor = .white
        xAxis.axisLineColor = .white
        xAxis.labelPosition = .bottom
        
        self.animate(xAxisDuration: 2.5)
    }
}
