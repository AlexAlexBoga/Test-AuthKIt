//
//  PasswordInputView.swift
//  Test-AuthKIt
//
//  Created by Александр Богачев on 11.10.24.
//

import UIKit

protocol PasswordInputViewDelegate: AnyObject {
    func didCompletePasswordInput()
}

class PasswordInputView: UIView {
    
    private let stackView = UIStackView()
    private let textFields: [UITextField]
    weak var delegate: PasswordInputViewDelegate?
    
    init() {
        textFields = (0..<6).map { _ in
            let textField = UITextField()
            textField.keyboardType = .numberPad
            textField.keyboardAppearance = .dark
            textField.borderStyle = .roundedRect
            textField.textAlignment = .center
            textField.font = UIFont.systemFont(ofSize: 22)
            textField.textColor = .white
            textField.backgroundColor = .black
            textField.layer.borderColor = UIColor.blue.cgColor
            textField.layer.borderWidth = 0.9
            textField.layer.cornerRadius = 3.7
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            return textField
        }
        
        super.init(frame: .zero)
        setupView()
        setupTextFields()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        for textField in textFields {
            stackView.addArrangedSubview(textField)
        }
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: 46),
        ])
    }
    
    private func setupTextFields() {
        for (index, textField) in textFields.enumerated() {
            textField.delegate = self
            
            textField.tag = index
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            
            textField.widthAnchor.constraint(equalTo: textField.heightAnchor).isActive = true
        }
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        if let text = textField.text, text.count == 1 {
            let nextTag = textField.tag + 1
            if nextTag < textFields.count {
                textFields[nextTag].becomeFirstResponder()
            } else {
                textField.resignFirstResponder()
                if allTextFieldsFilled() {
                    delegate?.didCompletePasswordInput()
                }
            }
        } else
        if textField.text?.isEmpty == true {
            let previousTag = textField.tag - 1
            if previousTag >= 0 {
                textFields[previousTag].becomeFirstResponder()
            }
        }
    }
    
    private func allTextFieldsFilled() -> Bool {
        return textFields.allSatisfy { $0.text?.count == 1 }
    }
}

extension PasswordInputView: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return string.count <= 1
    }
}
