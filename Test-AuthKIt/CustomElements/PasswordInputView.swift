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
    
    private var gradientLayer: CAGradientLayer!
    
    private let stackView = UIStackView()
    private let textFieldContainers: [UIView]
    private let textFields: [UITextField]
    weak var delegate: PasswordInputViewDelegate?
    
    private let textFieldHeight: CGFloat = 46
    
    var didCompleteInput: ((String) -> Void)?
    
    init() {
        textFieldContainers = (0..<6).map { _ in UIView() }
        textFields = (0..<6).map { _ in
            let textField = UITextField()
            textField.keyboardType = .numberPad
            textField.keyboardAppearance = .dark
            textField.borderStyle = .roundedRect
            textField.textAlignment = .center
            textField.font = UIFont.systemFont(ofSize: 22)
            textField.textColor = .white
            textField.backgroundColor = .backgroundApp
            textField.translatesAutoresizingMaskIntoConstraints = false
            
            return textField
        }
        
        super.init(frame: .zero)
        setupView()
        setupContainers()
        setupTextFields()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addSubview(stackView)
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.heightAnchor.constraint(equalToConstant: textFieldHeight)
        ])
    }
    
    private func setupContainers() {
        for containerView in textFieldContainers {
            stackView.addArrangedSubview(containerView)
            containerView.translatesAutoresizingMaskIntoConstraints = false
            containerView.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
            
            containerView.layer.cornerRadius = 3.7
            containerView.layer.masksToBounds = true
            
            gradientLayer = CAGradientLayer()
            gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
            gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            layer.insertSublayer(gradientLayer, at: 0)
            
            containerView.layer.insertSublayer(gradientLayer, at: 0)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for containerView in textFieldContainers {
            if let gradientLayer = containerView.layer.sublayers?.first as? CAGradientLayer {
                gradientLayer.frame = bounds
            }
        }
    }

    func configure(gradientColors: [CGColor]) {
        for containerView in textFieldContainers {
            if let gradientLayer = containerView.layer.sublayers?.first as? CAGradientLayer {
                gradientLayer.colors = gradientColors
            }
        }
    }
    
    private func setupTextFields() {
        for (index, containerView) in textFieldContainers.enumerated() {
            containerView.addSubview(textFields[index])
            
            NSLayoutConstraint.activate([
                textFields[index].leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 1),
                textFields[index].trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -1),
                textFields[index].topAnchor.constraint(equalTo: containerView.topAnchor, constant: 1),
                textFields[index].bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -1)
            ])
            
            textFields[index].addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
            textFields[index].tag = index
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
