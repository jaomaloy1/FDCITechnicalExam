//
//  ViewController.swift
//  FDCITechnicalExam
//
//  Created by Shammah Torregosa on 5/5/25.
//

import UIKit

class ViewController: UIViewController {

    let nameField = UITextField()
    let regionField = UITextField()
    let countryField = UITextField()
    
    let nameLabel = UILabel()
    let regionLabel = UILabel()
    let countryLabel = UILabel()
    
    let submitButton = UIButton()
    let clearButton = UIButton()

    let regions = ["Asia", "Europe", "North America"]
    let countriesByRegion: [String: [String]] = [
        "Asia": ["Philippines", "Japan", "India"],
        "Europe": ["Germany", "France", "Italy"],
        "North America": ["USA", "Canada", "Mexico"]
    ]

    var selectedRegion: String = "" {
        didSet {
            countries = countriesByRegion[selectedRegion] ?? []
            selectedCountry = countries.first ?? ""
            countryField.text = selectedCountry
            countryPicker.reloadAllComponents()
        }
    }

    var selectedCountry: String = ""
    var countries: [String] = []

    let regionPicker = UIPickerView()
    let countryPicker = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white

        countries = countriesByRegion[selectedRegion] ?? []
        selectedCountry = countries.first ?? ""

        setupTextFields()
        setupPickers()
//        setupButtons()
    }

    func setupTextFields() {
        nameLabel.text = "Name"
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        nameField.placeholder = "Name"
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.borderStyle = .roundedRect
        
        regionLabel.text = "Region"
        regionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        regionField.placeholder = "Select region"
        regionField.translatesAutoresizingMaskIntoConstraints = false
        regionField.borderStyle = .roundedRect
        
        countryLabel.text = "Country"
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
        
        countryField.placeholder = "Search"
        countryField.translatesAutoresizingMaskIntoConstraints = false
        countryField.borderStyle = .roundedRect
        
        
        view.addSubview(nameLabel)
        view.addSubview(nameField)
        view.addSubview(regionLabel)
        view.addSubview(regionField)
        view.addSubview(countryLabel)
        view.addSubview(countryField)

        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            nameField.topAnchor.constraint(equalTo: nameLabel.safeAreaLayoutGuide.topAnchor, constant: 40),
            nameField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 0),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameField.heightAnchor.constraint(equalToConstant: 55),
            
            regionLabel.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 20),
            regionLabel.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            regionLabel.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),

            regionField.topAnchor.constraint(equalTo: regionLabel.bottomAnchor, constant: 20),
            regionField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            regionField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            regionField.heightAnchor.constraint(equalToConstant: 55),

            countryLabel.topAnchor.constraint(equalTo: regionField.bottomAnchor, constant: 20),
            countryLabel.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            countryLabel.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),

            countryField.topAnchor.constraint(equalTo: countryLabel.bottomAnchor, constant: 20),
            countryField.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            countryField.trailingAnchor.constraint(equalTo: nameField.trailingAnchor),
            countryField.heightAnchor.constraint(equalToConstant: 55),

        ])
    }

    func setupPickers() {
        regionPicker.delegate = self
        regionPicker.dataSource = self
        countryPicker.delegate = self
        countryPicker.dataSource = self

        regionField.inputView = regionPicker
        countryField.inputView = countryPicker

        regionField.inputAccessoryView = createToolbar(selector: #selector(doneRegionPicker))
        countryField.inputAccessoryView = createToolbar(selector: #selector(doneCountryPicker))

        regionField.text = selectedRegion
        countryField.text = selectedCountry
    }
    
    func setupButtons() {
        submitButton.setTitle("Submit", for: .normal)
        clearButton.setTitle("Clear", for: .normal)
        
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(submitButton)
        view.addSubview(clearButton)
        
        submitButton.addTarget(self, action: #selector(handleSubmit), for: .touchUpInside)
        clearButton.addTarget(self, action: #selector(handleClear), for: .touchUpInside)
        

        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: countryField.bottomAnchor, constant: 50),
            submitButton.leadingAnchor.constraint(equalTo: nameField.leadingAnchor),
            submitButton.heightAnchor.constraint(equalToConstant: 55),
            
            clearButton.topAnchor.constraint(equalTo: submitButton.topAnchor),
            clearButton.leadingAnchor.constraint(equalTo: submitButton.trailingAnchor, constant: 10),
            clearButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            clearButton.heightAnchor.constraint(equalToConstant: 55),
        ])
    }

    func createToolbar(selector: Selector) -> UIToolbar {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: selector)
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolbar.setItems([space, doneButton], animated: false)
        return toolbar
    }
    
    @objc func handleSubmit() {
        guard
            let name = nameField.text, !name.isEmpty,
            let region = regionField.text, !region.isEmpty,
            let country = countryField.text, !country.isEmpty
        else {
            return
        }
        
    }
    
    @objc func handleClear() {
        nameField.text = ""
        regionField.text = ""
        countryField.text = ""
    }

    @objc func doneRegionPicker() {
        let row = regionPicker.selectedRow(inComponent: 0)
        selectedRegion = regions[row]
        regionField.text = selectedRegion
        regionField.resignFirstResponder()
    }

    @objc func doneCountryPicker() {
        let row = countryPicker.selectedRow(inComponent: 0)
        selectedCountry = countries[row]
        countryField.text = selectedCountry
        countryField.resignFirstResponder()
    }
}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
   
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == regionPicker {
            return regions.count
        } else {
            return countries.count
        }
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == regionPicker {
            return regions[row]
        } else {
            return countries[row]
        }
    }
}

