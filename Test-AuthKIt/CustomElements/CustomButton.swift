//
//  CustomButton.swift
//  Test-AuthKIt
//
//  Created by Александр Богачев on 11.10.24.
//

import UIKit

class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        setTitleColor(.white, for: .normal)
        backgroundColor = .systemBlue
        layer.cornerRadius = 56 / 2
        titleLabel?.font = .systemFont(ofSize: 16)
    }
    
    func configure(with title: String, backgroundColor: UIColor? = nil) {
        setTitle(title, for: .normal)
        
        if let bgColor = backgroundColor {
            self.backgroundColor = bgColor
        }
    }
}
