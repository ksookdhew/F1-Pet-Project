//
//  ViewController+Extension.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/09.
//

import UIKit

extension UIViewController {
    
    func showAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
