//
//  APIService.swift
//  iOS-Currency-Converter
//
//  Created by Prashuk Ajmera on 7/5/21.
//

import Foundation

struct APIService {
    
    let host = "api.frankfurter.app"
    
    func convertCurrency(from source: String, to destination: String, for price: String, completionHandler: @escaping (CurrencyConverter) -> ()) {
        
        let urlString = "https://\(host)/latest?amount=\(price)&from=\(source)&to=\(destination)"
        let url = URL(string: urlString)
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let responseData = data {
                let data = try! JSONDecoder().decode(CurrencyConverter.self, from: responseData)
                completionHandler(data)
            }
        }
        
        task.resume()
    }
    
    func getHistoricData(for source: String, to destination: String, fromDate startDate: String, toDate endDate: String, completionHandler: @escaping (HistoricData) -> ()) {
        
        let urlString = "https://\(host)/\(startDate)..?from=\(source)&to=\(destination)"
        let url = URL(string: urlString)
        
        let task = URLSession.shared.dataTask(with: url!) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let responseData = data {
                let data = try! JSONDecoder().decode(HistoricData.self, from: responseData)
                completionHandler(data)
            }
        }
        
        task.resume()
    }
}
