//
//  StartViewController.swift
//  Test-AuthKIt
//
//  Created by Александр Богачев on 11.10.24.
//

import UIKit

class StartViewController: UIViewController {
    
    private let logoImage = UIImageView()
    private let logoLabel = UILabel()
    private let logoDescriptionLabel = UILabel()
    private let loginButton = UIButton()
    private let stackView = UIStackView()
    private let downLable = UILabel()
    private let createButton = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupLayout()
    }
    
    private func setupLayout() {
        setupLogoImage()
        setuplogoLabel()
        setuplogoDescriptionLabel()
        setuploginButton()
        setupstackView()
    }
    
    private func setupLogoImage() {
        view.addSubview(logoImage)
        logoImage.translatesAutoresizingMaskIntoConstraints = false
        
        logoImage.image = .mainLogo
        logoImage.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 265),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 79),
            logoImage.heightAnchor.constraint(equalToConstant: 79),
        ])
    }
    
    private func setuplogoLabel() {
        view.addSubview(logoLabel)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.text = "SIS"
        logoLabel.font = UIFont.systemFont(ofSize: 34)
        logoLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 32),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setuplogoDescriptionLabel() {
        view.addSubview(logoDescriptionLabel)
        logoDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        logoDescriptionLabel.text = "Выбери свою безопасность"
        logoDescriptionLabel.font = UIFont.systemFont(ofSize: 17)
        logoDescriptionLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            logoDescriptionLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 18),
            logoDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setuploginButton() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.setTitle("Войти по номеру телефона", for: .normal)
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.cornerRadius = 56 / 2
        
        NSLayoutConstraint.activate([
            
            loginButton.topAnchor.constraint(equalTo: logoDescriptionLabel.bottomAnchor, constant: 100),
            loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loginButton.widthAnchor.constraint(equalToConstant: 319),
            loginButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    private func setupstackView() {
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        
        downLable.text = "У вас нет аккаунта?"
        downLable.textColor = .white
        downLable.font = .systemFont(ofSize: 14)
        downLable.textAlignment = .center
        
        createButton.text = " Зарегистрируйтесь сейчас"
        createButton.textColor = .systemBlue
        createButton.font = .systemFont(ofSize: 14)
        createButton.textAlignment = .center
        
        stackView.addArrangedSubview(downLable)
        stackView.addArrangedSubview(createButton)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 100),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.widthAnchor.constraint(equalToConstant: 190),
            stackView.heightAnchor.constraint(equalToConstant: 40),
        ])
    }
}


