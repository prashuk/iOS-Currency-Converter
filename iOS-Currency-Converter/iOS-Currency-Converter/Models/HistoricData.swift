//
//  HistoricData.swift
//  iOS-Currency-Converter
//
//  Created by Prashuk Ajmera on 7/6/21.
//

import Foundation

struct HistoricData: Codable {
    let amount: Int
    let base, startDate, endDate: String
    let rates: [String: [String: Double]]

    enum CodingKeys: String, CodingKey {
        case amount, base
        case startDate = "start_date"
        case endDate = "end_date"
        case rates
    }
}
