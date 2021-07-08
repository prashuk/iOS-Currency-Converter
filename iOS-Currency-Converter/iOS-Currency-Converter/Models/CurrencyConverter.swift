//
//  File.swift
//  iOS-Currency-Converter
//
//  Created by Prashuk Ajmera on 7/5/21.
//

import Foundation

struct CurrencyConverter: Codable {
    let amount: Double
    let base, date: String
    let rates: [String: Double]
}
