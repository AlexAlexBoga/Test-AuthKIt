//
//  VerFirstViewController.swift
//  Test-AuthKIt
//
//  Created by Александр Богачев on 11.10.24.
//
import UIKit

class VerFirstViewController: UIViewController {
    
    private var customView: CustomView?
    private let passwordInputView = PasswordInputView()
    private let regButton = CustomButton()
    private let wrongLabel = UILabel()
    private let underlineView = UIView()
    
    //    private let authService = AuthService()
    private let authService: AuthServiceProtocol = MockAuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundApp
        customView = createCustomView()
        setupNavBarTitle("Войти", textColor: .white)
        setupCustomBackButton()
        keyBoardSetings()
        setupLayout()
        passwordInputView.delegate = self
    }
    
    private func setupLayout() {
        setupCustomView()
        setupPasswordInputView()
        setupRegButton()
        setupwrongLabel()
        setupUnderlineView()
    }
    
    private func keyBoardSetings() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func setupCustomView() {
        guard let customView = customView else { return }
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            customView.topAnchor.constraint(equalTo: view.topAnchor, constant: 168),
            customView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            customView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
        ])
    }
    
    private func setupPasswordInputView() {
        view.addSubview(passwordInputView)
        passwordInputView.translatesAutoresizingMaskIntoConstraints = false
        passwordInputView.configure(gradientColors: GradientColors.gradient1)
        
        NSLayoutConstraint.activate([
            passwordInputView.topAnchor.constraint(equalTo: customView!.bottomAnchor, constant: 30),
            passwordInputView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 37),
            passwordInputView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -37),
            passwordInputView.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        passwordInputView.didCompleteInput = { [weak self] code in
            self?.regButton.configure(with: "Зарегистироваться", gradientColors: GradientColors.gradient1)
            self?.wrongLabel.isHidden = true
            self?.underlineView.isHidden = true
            self?.view.endEditing(true)
        }
    }
    
    private func setupRegButton() {
        view.addSubview(regButton)
        regButton.translatesAutoresizingMaskIntoConstraints = false
        
        regButton.configure(with: "Зарегистироваться", gradientColors: GradientColors.gradient2)
        regButton.addTarget(self, action: #selector(regButtonTupped), for: .primaryActionTriggered)
        
        NSLayoutConstraint.activate([
            regButton.topAnchor.constraint(equalTo: passwordInputView.bottomAnchor, constant: 28),
            regButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            regButton.widthAnchor.constraint(equalToConstant: 319),
            regButton.heightAnchor.constraint(equalToConstant: 56),
        ])
    }
    
    private func setupwrongLabel() {
        view.addSubview(wrongLabel)
        wrongLabel.translatesAutoresizingMaskIntoConstraints = false
        wrongLabel.text = "Я не получил код!"
        wrongLabel.font = UIFont.systemFont(ofSize: 14)
        wrongLabel.textColor = .white
        
        NSLayoutConstraint.activate([
            wrongLabel.topAnchor.constraint(equalTo: regButton.bottomAnchor, constant: 28),
            wrongLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    private func setupUnderlineView() {
        view.addSubview(underlineView)
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.backgroundColor = .white
        
        NSLayoutConstraint.activate([
            underlineView.topAnchor.constraint(equalTo: wrongLabel.bottomAnchor, constant: 1),
            underlineView.centerXAnchor.constraint(equalTo: wrongLabel.centerXAnchor),
            underlineView.widthAnchor.constraint(equalTo: wrongLabel.widthAnchor),
            underlineView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
    
    @objc
    private func regButtonTupped() {
        let enteredCode = passwordInputView.getCode()
        
        authService.login(with: enteredCode) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self?.navigateToMainApp()
                case .failure(let error):
                    print("Ошибка авторизации: \(error.localizedDescription)")
                }
            }
        }
        
        print("regButtonTupped pressed")
    }
    
    private func navigateToMainApp() {
        print("navigateToMainApp")
    }
    
    private func createCustomView() -> CustomView {
        return CustomView(
            firstText: "Верификация",
            secondText: "Введите код из смс, \n что мы отправили вам",
            thirdText: "Запросить код можно \n через 05:00"
        )
    }
    
    @objc
    private func keyboardWillShow(notification: NSNotification) {
        wrongLabel.isHidden = true
        underlineView.isHidden = true
    }
    
    @objc
    private func keyboardWillHide(notification: NSNotification) {
        wrongLabel.isHidden = true
        underlineView.isHidden = true
    }
}

extension VerFirstViewController: PasswordInputViewDelegate {
    
    func didCompletePasswordInput() {
        view.endEditing(true)
        
        regButton.configure(with: "Зарегистироваться", gradientColors: GradientColors.gradient1)
        
        wrongLabel.isHidden = true
        underlineView.isHidden = true
    }
}

