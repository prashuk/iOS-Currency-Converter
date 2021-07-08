//
//  String.swift
//  iOS-Currency-Converter
//
//  Created by Prashuk Ajmera on 7/5/21.
//

import Foundation

extension String {
    func toDouble() -> Double {
        return Double(self) ?? 0.0
    }
    
    func isValidDouble() -> Bool {
        return Double(self) != nil ? true : false
    }
}
