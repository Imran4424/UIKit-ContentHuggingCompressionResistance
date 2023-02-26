//
//  ViewController.swift
//  ContentHugCompressionRes
//
//  Created by Shah Md Imran Hossain on 26/2/23.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupViews()
    }

    func setupViews() {
        let nameLabel = makeLabel(withText: "Name")
        let nameTextField = makeTextField(withPlaceHolderText: "Enter name here")
        
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        
        // nameLabel
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8)
        ])
        
        // nameTextField, without the trailing anchor textfield grow dynamically
        NSLayoutConstraint.activate([
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 8),
            nameTextField.firstBaselineAnchor.constraint(equalTo: nameLabel.firstBaselineAnchor)
        ])
        
        
        // by setting trailing anchor we override intrinsic content size
        // but another issue happen, ambiguous size options
        // auto layout is confuse which component to stretch which to not
        view.trailingAnchor.constraint(equalTo: nameTextField.trailingAnchor, constant: 8).isActive = true
        
        // this issue is solved using content hugging priority
        // content hugging priority - hugging means shrinking here
        // content hugging priority of nameLabel is 251, nameTextField is 250
        // content hugging priority of nameLabel is bigger than nameTextField
        // so for stretching nameTextField wil have higher priority than nameLabel
        nameLabel.setContentHuggingPriority(UILayoutPriority(251), for: .horizontal)
        
        // content compression resistance
        // higher the resistance - view shrinking priority is less
        // lower the resistance - view shrinking priorit is high
        
        // content hugging priority
        // higer the priority - view stretching priority is less
        // lower the priority - view stretching priority is high
    }
}

// MARK: - Factory methods
extension ViewController {
    func makeLabel(withText text: String) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = text
        label.backgroundColor = .yellow
        
        return label
    }
    
    func makeTextField(withPlaceHolderText text: String) -> UITextField {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = text
        textField.backgroundColor = .lightGray
        
        return textField
    }
}
