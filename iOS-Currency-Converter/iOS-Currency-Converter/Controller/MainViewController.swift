//
//  ViewController.swift
//  iOS-Currency-Converter
//
//  Created by Prashuk Ajmera on 7/5/21.
//

import UIKit

class MainViewController: UIViewController {
    
    var service = APIService()

    @IBOutlet weak var amountTextField: UITextField!
    @IBOutlet weak var sourceTextField: UITextField!
    @IBOutlet weak var destinationTextField: UITextField!
    
    @IBOutlet weak var sourceLbl: UILabel!
    @IBOutlet weak var destinationLbl: UILabel!
    @IBOutlet weak var sourceAmtLbl: UILabel!
    @IBOutlet weak var destinationAmtLbl: UILabel!
    @IBOutlet weak var unitPriceLbl: UILabel!
    
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    @IBOutlet weak var showTrendBtn: UIButton!
    
    let sourcePicker = UIPickerView()
    let destinationPicker = UIPickerView()
    
    var sourceCurrencies = Constants.currencies
    var destinationCurrencies = Constants.currencies
    var unitAmount = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func setup() {
        amountTextField.text = "1.00"
        sourceTextField.text = "USD"
        destinationTextField.text = "INR"
        
        sourceLbl.text = ""
        sourceAmtLbl.text = ""
        destinationLbl.text = ""
        destinationAmtLbl.text = ""
        unitPriceLbl.text = ""
        
        showTrendBtn.isHidden = true
        
        loading.style = .large
        loading.stop()
        
        amountTextField.delegate = self
        sourceTextField.delegate = self
        destinationTextField.delegate = self
        sourcePicker.delegate = self
        sourcePicker.dataSource = self
        destinationPicker.delegate = self
        destinationPicker.dataSource = self
    }
    
    @IBAction func convertTapped(_ sender: UIButton) {
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
        
        service.convertCurrency(from: source, to: destination, for: amount) { [weak self] price in
            guard let self = self else { return }

            DispatchQueue.main.async {
                let convertedAmount = price.rates[destination]
                self.unitAmount = (convertedAmount!/amount.toDouble()).roundToTwo()

                self.sourceLbl.text = "\(Constants.currencies.filter{ $0.key == source.lowercased() }.first?.value ?? "") (\(source))"
                self.sourceAmtLbl.text = price.amount.toString()
                self.destinationLbl.text = "\(Constants.currencies.filter{ $0.key == destination.lowercased() }.first?.value ?? "") (\(destination))"
                self.destinationAmtLbl.text = price.rates[destination]?.toString()

                self.unitPriceLbl.text = "1 \(source) = \(self.unitAmount) \(destination)"
                
                self.showTrendBtn.isHidden = false

                self.loading.stop()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let showTrendVC = segue.destination as! ShowTrendViewController
        showTrendVC.trendBetween = (from: sourceTextField.text!, to: destinationTextField.text!, todayPrice: unitAmount)
    }
    
}

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
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
            destinationCurrencies = Constants.currencies.filter{ $0.key != sourceCurrencies[row].key }
        }
        if pickerView == destinationPicker {
            self.destinationTextField.text = destinationCurrencies[row].key.uppercased()
            sourceCurrencies = Constants.currencies.filter{ $0.key != destinationCurrencies[row].key }
        }
    }
}

extension MainViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == sourceTextField {
            textField.inputView = sourcePicker
        }
        if textField == destinationTextField {
            textField.inputView = destinationPicker
        }
    }
}
