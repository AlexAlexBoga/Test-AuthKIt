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
    
    private let textFieldHeight: CGFloat = 46
    
    var didCompleteInput: ((String) -> Void)?
    
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
            textField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        }
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: textFieldHeight),
        ])
    }
    
    private func setupTextFields() {
        for (index, textField) in textFields.enumerated() {
            
            textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            textField.tag = index
        }
    }
    
    @objc
    private func textFieldDidChange(_ textField: UITextField) {
        let tag = textField.tag
        
        if let text = textField.text, text.count == 1, tag < textFields.count - 1 {
            textFields[tag + 1].becomeFirstResponder()
        }
        
        if textFields.allSatisfy({ $0.text?.isEmpty == false }) {
            let code = getCode()
            didCompleteInput?(code)
        }
        
    }
    func getCode() -> String {
        return textFields.compactMap { $0.text }.joined()
    }
}
