//
//  VerFirstViewController.swift
//  Test-AuthKIt
//
//  Created by Александр Богачев on 11.10.24.
//

import UIKit

class VerFirstViewController: UIViewController {

    private var customView: CustomView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customView = createCustomView()
        setupNavBarTitle("Войти", textColor: .white)
        setupCustomBackButton()
        setupLayout()
      }

    private func setupLayout() {
        setupCustomView()
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
    
    private func createCustomView() -> CustomView {
        return CustomView(
            firstText: "Верификация",
            secondText: "Введите код из смс, \n что мы отправили вам",
            thirdText: "Запросить код можно \n через 05:00"
        )
    }
}
