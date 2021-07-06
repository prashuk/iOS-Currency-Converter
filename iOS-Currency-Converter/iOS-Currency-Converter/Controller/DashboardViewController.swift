//
//  ViewController.swift
//  iOS-Currency-Converter
//
//  Created by Prashuk Ajmera on 7/5/21.
//

import UIKit

class DashboardViewController: UIViewController {
    
    var service: APIService!
    var convertedPrice: PriceConvert!

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var sourceTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var destinationLbl: UILabel!
    @IBOutlet weak var sourceAmtLbl: UILabel!
    @IBOutlet weak var destinationAmtLbl: UILabel!
    @IBOutlet weak var unitPriceLbl: UILabel!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    let sourcePicker = UIPickerView()
    let destinationPicker = UIPickerView()
    
    var sourceCurrencies = currencies
    var destinationCurrencies = currencies
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service = APIService()
        
        amountTextField.delegate = self
        sourceTextField.delegate = self
        destinationTextField.delegate = self
        
        setup()
    }
    
    func setup() {
        sourceLbl.text = ""
        sourceAmtLbl.text = ""
        destinationLbl.text = ""
        destinationAmtLbl.text = ""
        unitPriceLbl.text = ""
        
        loading.style = .large
        loading.stop()
        
        sourcePicker.delegate = self
        sourcePicker.dataSource = self
        destinationPicker.delegate = self
        destinationPicker.dataSource = self
    }
    
    @IBAction func convert(_ sender: UIButton) {
        self.amountTextField.resignFirstResponder()
        self.sourceTextField.resignFirstResponder()
        self.destinationTextField.resignFirstResponder()
                
        self.getConvertCurrency(from: sourceTextField.text!, to: destinationTextField.text!, for: amountTextField.text!)
    }
    
    func getConvertCurrency(from source: String, to destination: String, for amount: String) {
        
        if source.isEmpty || destination.isEmpty {
            Alert.basicAlert(title: "Field Required", message: "Please fill all the required fields.", dismissButton: "Ok", vc: self)
            return
        }
        
        if !amount.isValidDouble() {
            Alert.basicAlert(title: "Invalid Amount", message: "Please enter a valid number.", dismissButton: "Ok", vc: self)
            return
        }
        
        self.loading.start()
        
        service.convertCurrency(from: source, to: destination, for: amount.toDouble()) { [weak self] convertedAmount in

            guard let self = self else { return }

            self.convertedPrice = convertedAmount

            DispatchQueue.main.async {
                self.sourceLbl.text = "\(currencies.filter{ $0.key == source.lowercased() }.first?.value ?? "") (\(source))"
                self.sourceAmtLbl.text = amount
                self.destinationLbl.text = "\(currencies.filter{ $0.key == destination.lowercased() }.first?.value ?? "") (\(destination))"
                
                let convertedAmount = self.mappedCurrency(for: destination)
                self.destinationAmtLbl.text = convertedAmount
                
                self.unitPriceLbl.text = "1 \(source) = \(convertedAmount.toDouble()/amount.toDouble()) \(destination)"

                self.loading.stop()
            }
        }
    }
    
    func mappedCurrency(for currency: String) -> String {
        switch currency {
            case "AUD":
                return convertedPrice.rates.aud!.toString()
            case "BGN":
                return convertedPrice.rates.bgn!.toString()
            case "BRL":
                return convertedPrice.rates.brl!.toString()
            case "CAD":
                return convertedPrice.rates.cad!.toString()
            case "CHF":
                return convertedPrice.rates.chf!.toString()
            case "CNY":
                return convertedPrice.rates.cny!.toString()
            case "CZK":
                return convertedPrice.rates.czk!.toString()
            case "DKK":
                return convertedPrice.rates.dkk!.toString()
            case "EUR":
                return convertedPrice.rates.eur!.toString()
            case "GBP":
                return convertedPrice.rates.gbp!.toString()
            case "HKD":
                return convertedPrice.rates.hkd!.toString()
            case "HRK":
                return convertedPrice.rates.hrk!.toString()
            case "HUF":
                return convertedPrice.rates.huf!.toString()
            case "IDR":
                return convertedPrice.rates.idr!.toString()
            case "ILS":
                return convertedPrice.rates.ils!.toString()
            case "INR":
                return convertedPrice.rates.inr!.toString()
            case "ISK":
                return convertedPrice.rates.isk!.toString()
            case "JPY":
                return convertedPrice.rates.jpy!.toString()
            case "KRW":
                return convertedPrice.rates.krw!.toString()
            case "MXN":
                return convertedPrice.rates.mxn!.toString()
            case "MYR":
                return convertedPrice.rates.myr!.toString()
            case "NOK":
                return convertedPrice.rates.nok!.toString()
            case "NZD":
                return convertedPrice.rates.nzd!.toString()
            case "PHP":
                return convertedPrice.rates.php!.toString()
            case "PLN":
                return convertedPrice.rates.pln!.toString()
            case "RON":
                return convertedPrice.rates.ron!.toString()
            case "RUB":
                return convertedPrice.rates.rub!.toString()
            case "SEK":
                return convertedPrice.rates.sek!.toString()
            case "SGD":
                return convertedPrice.rates.sgd!.toString()
            case "THB":
                return convertedPrice.rates.thb!.toString()
            case "USD":
                return convertedPrice.rates.usd!.toString()
            case "ZAR":
                return convertedPrice.rates.zar!.toString()
            default:
                return "0.0"
        }
    }
}

extension DashboardViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == sourcePicker {
            return sourceCurrencies.count
        }
        if pickerView == destinationPicker {
            return destinationCurrencies.count
        }
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == sourcePicker {
            return sourceCurrencies[row].value
        }
        if pickerView == destinationPicker {
            return destinationCurrencies[row].value
        }
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == sourcePicker {
            self.sourceTextField.text = sourceCurrencies[row].key.uppercased()
            destinationCurrencies = currencies.filter{ $0.key != sourceCurrencies[row].key }
        }
        if pickerView == destinationPicker {
            self.destinationTextField.text = destinationCurrencies[row].key.uppercased()
            sourceCurrencies = currencies.filter{ $0.key != destinationCurrencies[row].key }
        }
    }
}

extension DashboardViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == sourceTextField {
            textField.inputView = sourcePicker
        }
        if textField == destinationTextField {
            textField.inputView = destinationPicker
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("\(textField.text!)\(string)")
        return true
    }
}


