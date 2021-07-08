//
//  Double.swift
//  iOS-Currency-Converter
//
//  Created by Prashuk Ajmera on 7/5/21.
//

import Foundation
import UIKit

extension Double {
    func toString() -> String {
        return String(self)
    }
    
    func roundToTwo() -> Double {
        let str = String(format: "%.2f", self)
        return Double(str)!
    }
}
