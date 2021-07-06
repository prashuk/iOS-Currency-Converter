//
//  Currency.swift
//  iOS-Currency-Converter
//
//  Created by Prashuk Ajmera on 7/5/21.
//

import Foundation

struct Currency {
    let key: String
    let value: String
    let symbol: String?
    
    init(key: String, value: String, symbol: String? = nil) {
        self.key = key
        self.value = value
        self.symbol = symbol
    }
}
