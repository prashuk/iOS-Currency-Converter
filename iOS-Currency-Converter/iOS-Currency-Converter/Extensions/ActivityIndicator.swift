//
//  ActivityIndicator.swift
//  iOS-Currency-Converter
//
//  Created by Prashuk Ajmera on 7/5/21.
//

import UIKit

extension UIActivityIndicatorView {
    func start() {
        self.isHidden = false
        self.startAnimating()
    }
    
    func stop() {
        self.stopAnimating()
        self.isHidden = true
    }
}
