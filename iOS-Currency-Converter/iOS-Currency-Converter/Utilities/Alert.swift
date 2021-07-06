//
//  Alert.swift
//  iOS-Currency-Converter
//
//  Created by Prashuk Ajmera on 7/5/21.
//

import Foundation
import UIKit

class Alert {
    class func basicAlert(title: String, message: String, dismissButton: String, vc: UIViewController) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: dismissButton, style: .default, handler: nil))
        vc.present(alert, animated: true, completion: nil)
    }
}
