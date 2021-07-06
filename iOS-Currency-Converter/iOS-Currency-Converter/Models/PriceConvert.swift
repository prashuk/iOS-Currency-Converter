//
//  File.swift
//  iOS-Currency-Converter
//
//  Created by Prashuk Ajmera on 7/5/21.
//

import Foundation

struct PriceConvert: Codable {
    let amount: Double
    let base: String
    let rates: Rates
}

struct Rates: Codable {
    let aud: Double?
    let bgn: Double?
    let brl: Double?
    let cad: Double?
    let chf: Double?
    let cny: Double?
    let czk: Double?
    let dkk: Double?
    let eur: Double?
    let gbp: Double?
    let hkd: Double?
    let hrk: Double?
    let huf: Double?
    let idr: Double?
    let ils: Double?
    let inr: Double?
    let isk: Double?
    let jpy: Double?
    let krw: Double?
    let mxn: Double?
    let myr: Double?
    let nok: Double?
    let nzd: Double?
    let php: Double?
    let pln: Double?
    let ron: Double?
    let rub: Double?
    let sek: Double?
    let sgd: Double?
    let thb: Double?
    let usd: Double?
    let zar: Double?

    enum CodingKeys: String, CodingKey, CaseIterable {
        case aud = "AUD"
        case bgn = "BGN"
        case brl = "BRL"
        case cad = "CAD"
        case chf = "CHF"
        case cny = "CNY"
        case czk = "CZK"
        case dkk = "DKK"
        case eur = "EUR"
        case gbp = "GBP"
        case hkd = "HKD"
        case hrk = "HRK"
        case huf = "HUF"
        case idr = "IDR"
        case ils = "ILS"
        case inr = "INR"
        case isk = "ISK"
        case jpy = "JPY"
        case krw = "KRW"
        case mxn = "MXN"
        case myr = "MYR"
        case nok = "NOK"
        case nzd = "NZD"
        case php = "PHP"
        case pln = "PLN"
        case ron = "RON"
        case rub = "RUB"
        case sek = "SEK"
        case sgd = "SGD"
        case thb = "THB"
        case usd = "USD"
        case zar = "ZAR"
    }
}
