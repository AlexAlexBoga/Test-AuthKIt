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
    private let loginButton = CustomButton()
    private let stackView = UIStackView()
    private let downLable = UILabel()
    private let createButton = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundApp
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
        logoImage.contentMode = .scaleAspectFill
        
        NSLayoutConstraint.activate([
            
            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 265),
            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImage.widthAnchor.constraint(equalToConstant: 100),
            logoImage.heightAnchor.constraint(equalToConstant: 100),
        ])
    }
    
    private func setuplogoLabel() {
        view.addSubview(logoLabel)
        logoLabel.translatesAutoresizingMaskIntoConstraints = false
        logoLabel.text = "SIS"
        logoLabel.font = UIFont(name: "SFProDisplay-Medium", size: 34)
        logoLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            logoLabel.topAnchor.constraint(equalTo: logoImage.bottomAnchor, constant: 31),
            logoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setuplogoDescriptionLabel() {
        view.addSubview(logoDescriptionLabel)
        logoDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        logoDescriptionLabel.text = "Выбери свою безопасность"
        logoDescriptionLabel.font = UIFont(name: "SFProDisplay-Regular", size: 17)
        logoDescriptionLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            logoDescriptionLabel.topAnchor.constraint(equalTo: logoLabel.bottomAnchor, constant: 18),
            logoDescriptionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setuploginButton() {
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        
        loginButton.configure(with: "Войти по номеру телефона", gradientColors: GradientColors.gradient1)
        loginButton.addTarget(self, action: #selector(loginButtonTupped), for: .primaryActionTriggered)
        
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
        downLable.font = UIFont(name: "Urbanist-Light", size: 14)
        downLable.textAlignment = .center
        
        createButton.text = " Зарегистрируйтесь сейчас"
        createButton.textColor = .textBlue
        createButton.font = UIFont(name: "Urbanist-Light", size: 14)
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
    
    @objc
    private func loginButtonTupped() {
        let secondVC = RegistrationViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
}


