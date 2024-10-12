//
//  RegistrationViewController.swift
//  Test-AuthKIt
//
//  Created by Александр Богачев on 11.10.24.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    private let phoneLabel = UILabel()
    private let codeFrame = UIView()
    private let phoneFrame = UIView()
    private let codeButton = UIButton()
    private let codeTableView = UITableView()
    private let phoneTextField = UITextField()
    private let countryCodes = ["+3", "+5", "+7"]
    private var selectedCode: String?
    private let triangleButton = UIButton()
    private let triangleImage = UIImage(named: "subtract")
    private let infoLabel = UILabel()
    private let getCodeButton = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundApp
        setupNavBarTitle("Войти", textColor: .white)
        setupCustomBackButton()
        setupLayout()
    }
    
    private func setupLayout() {
        setupphoneLabel()
        setupFrames()
        setupCodeButton()
        setupTableView()
        setupTextFields()
        setupInfoLabel()
        setupGetCodeButton()
    }
    
    private func setupphoneLabel() {
        view.addSubview(phoneLabel)
        phoneLabel.translatesAutoresizingMaskIntoConstraints = false
        phoneLabel.text = "Номер телефона"
        phoneLabel.font = UIFont(name: "Urbanist-Regular", size: 13)
        phoneLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            phoneLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 135),
            phoneLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
        ])
    }
    
    private func setupFrames() {
        view.addSubview(codeFrame)
        view.addSubview(phoneFrame)
        codeFrame.translatesAutoresizingMaskIntoConstraints = false
        phoneFrame.translatesAutoresizingMaskIntoConstraints = false
        
        codeFrame.backgroundColor = .clear
        codeFrame.layer.borderWidth = 0.6
        codeFrame.layer.borderColor = UIColor.blue.cgColor
        codeFrame.layer.cornerRadius = 10
        
        phoneFrame.backgroundColor = .clear
        phoneFrame.layer.borderWidth = 0.6
        phoneFrame.layer.borderColor = UIColor.blue.cgColor
        phoneFrame.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            codeFrame.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 34),
            codeFrame.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor, constant: 15),
            codeFrame.widthAnchor.constraint(equalToConstant: 70),
            codeFrame.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        NSLayoutConstraint.activate([
            phoneFrame.topAnchor.constraint(equalTo: phoneLabel.bottomAnchor,constant: 15),
            phoneFrame.leadingAnchor.constraint(equalTo: codeFrame.trailingAnchor, constant: 13),
            phoneFrame.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            phoneFrame.heightAnchor.constraint(equalTo: codeFrame.heightAnchor),
        ])
    }
    
    private func setupCodeButton() {
        codeButton.setTitle("+7", for: .normal)
        codeButton.setTitleColor(.white, for: .normal)
        codeButton.backgroundColor = .black
        codeButton.addTarget(self, action: #selector(codeButtonTapped), for: .touchUpInside)
        
        codeFrame.addSubview(codeButton)
        codeButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            codeButton.leadingAnchor.constraint(equalTo: codeFrame.leadingAnchor, constant: 10),
            codeButton.trailingAnchor.constraint(equalTo: codeFrame.trailingAnchor, constant: -30),
            codeButton.centerYAnchor.constraint(equalTo: codeFrame.centerYAnchor),
            codeButton.heightAnchor.constraint(equalTo: codeFrame.heightAnchor)
        ])
       
        triangleButton.setImage(triangleImage, for: .normal)
        triangleButton.setTitleColor(.white, for: .normal)
        triangleButton.addTarget(self, action: #selector(codeButtonTapped), for: .primaryActionTriggered)
        
        codeFrame.addSubview(triangleButton)
        triangleButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            triangleButton.trailingAnchor.constraint(equalTo: codeFrame.trailingAnchor, constant: -13),
            triangleButton.centerYAnchor.constraint(equalTo: codeFrame.centerYAnchor),
            triangleButton.heightAnchor.constraint(equalToConstant: 6)
        ])
    }
    
    private func setupTableView() {
        codeTableView.delegate = self
        codeTableView.dataSource = self
        codeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        codeTableView.frame = CGRect(x: 20, y: 150, width: 90, height: 200)
        codeTableView.isHidden = true
        view.addSubview(codeTableView)
        codeTableView.backgroundColor = .black
    }
    
    @objc private func codeButtonTapped() {
        codeTableView.isHidden.toggle()
    }
    
    private func setupTextFields() {
        phoneFrame.addSubview(phoneTextField)
        phoneTextField.translatesAutoresizingMaskIntoConstraints = false
        
        phoneTextField.placeholder = "Ваш телефон"
        phoneTextField.textColor = .white
        phoneTextField.borderStyle = .none
        phoneTextField.keyboardType = .numberPad
        phoneTextField.keyboardAppearance = .dark
        
        NSLayoutConstraint.activate([
            phoneTextField.leadingAnchor.constraint(equalTo: phoneFrame.leadingAnchor, constant: 34),
            phoneTextField.trailingAnchor.constraint(equalTo: phoneFrame.trailingAnchor),
            phoneTextField.topAnchor.constraint(equalTo: phoneFrame.topAnchor, constant: -11),
            phoneTextField.bottomAnchor.constraint(equalTo: phoneFrame.bottomAnchor)
        ])
    }
    
    private func setupInfoLabel() {
        view.addSubview(infoLabel)
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.text = "Код придет на ваш номер телефона"
        infoLabel.font = UIFont(name: "Urbanist-Light", size: 14)
        infoLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: codeFrame.bottomAnchor, constant: 22),
            infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupGetCodeButton() {
        view.addSubview(getCodeButton)
        getCodeButton.translatesAutoresizingMaskIntoConstraints = false
        
        getCodeButton.configure(with: "Получить код", gradientColors: GradientColors.gradient1)
        getCodeButton.addTarget(self, action: #selector(getCodeButtonTupped), for: .primaryActionTriggered)
        
        NSLayoutConstraint.activate([
            getCodeButton.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 53),
            getCodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            getCodeButton.widthAnchor.constraint(equalToConstant: 319),
            getCodeButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    
    @objc
    private func getCodeButtonTupped() {
        let secondVC = VerFirstViewController()
        navigationController?.pushViewController(secondVC, animated: true)
    }
}

extension RegistrationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryCodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = countryCodes[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCode = countryCodes[indexPath.row]
        codeButton.setTitle(selectedCode, for: .normal)
        codeTableView.isHidden = true
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return 50
       }
}
