//
//  NavBar-EXT.swift
//  Test-AuthKIt
//
//  Created by Александр Богачев on 11.10.24.
//

import UIKit

extension UIViewController {
    
    func setupNavBarTitle(_ title: String, textColor: UIColor = .white) {
        self.title = title
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: textColor]
    }
    
    func setupCustomBackButton(imageName: String = "arrow-left", tintColor: UIColor = .white) {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        navigationItem.backBarButtonItem = backButton
        
        if let customImage = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate) {
            let customBackButton = UIBarButtonItem(image: customImage, style: .plain, target: self, action: #selector(backAction))
            customBackButton.tintColor = tintColor
            navigationItem.leftBarButtonItem = customBackButton
        }
    }
    
    @objc func backAction() {
        self.navigationController?.popViewController(animated: true)
    }
}
