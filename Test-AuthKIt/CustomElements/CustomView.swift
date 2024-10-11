//
//  CustomView.swift
//  Test-AuthKIt
//
//  Created by Александр Богачев on 11.10.24.
//

import UIKit

class CustomView: UIView {
    
    private let firstLabel = UILabel()
    private let secondLabel = UILabel()
    private let thirdLabel = UILabel()
    
    init(firstText: String, secondText: String, thirdText: String) {
            super.init(frame: .zero)
            setupView(firstText: firstText, secondText: secondText, thirdText: thirdText)
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView(firstText: String, secondText: String, thirdText: String) {
        
        firstLabel.text = firstText
        firstLabel.textColor = .white
        firstLabel.textAlignment = .center
        
        secondLabel.text = secondText
        secondLabel.textColor = .lightGray
        secondLabel.textAlignment = .center
        secondLabel.numberOfLines = 0
        secondLabel.lineBreakMode = .byWordWrapping
        
        thirdLabel.text = thirdText
        thirdLabel.textColor = .white
        thirdLabel.textAlignment = .center
        
        addSubview(firstLabel)
        addSubview(secondLabel)
        addSubview(thirdLabel)
        
        firstLabel.translatesAutoresizingMaskIntoConstraints = false
        secondLabel.translatesAutoresizingMaskIntoConstraints = false
        thirdLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            firstLabel.topAnchor.constraint(equalTo: topAnchor),
            firstLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            firstLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            secondLabel.topAnchor.constraint(equalTo: firstLabel.bottomAnchor, constant: 18),
            secondLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            secondLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            thirdLabel.topAnchor.constraint(equalTo: secondLabel.bottomAnchor, constant: 35),
            thirdLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            thirdLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            thirdLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
