//
//  LoginViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/10.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak private var username: UITextField!
    @IBOutlet weak private var password: UITextField!
    @IBOutlet weak private var errorMessage: UILabel!

    // MARK: Variables
    private lazy var viewModel = LoginViewModel(navigationDelegate: self)

    // MARK: Function
    override func viewDidLoad() {
        errorMessage.isHidden = true
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 150
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    // MARK: IBAction
    @IBAction func loginAction(_ sender: Any) {
        if viewModel.validDetails(givenUsername: username.text, givenPassword: password.text) {
            errorMessage.isHidden = true
            viewModel.performSegue()
        } else {
            errorMessage.isHidden = false
        }
    }
}

// MARK: Navigation Delegate
protocol LoginNavigationDelegate: AnyObject {
    func navigate()
}

extension LoginViewController: LoginNavigationDelegate {

    func navigate() {
        performSegue(withIdentifier: Identifiers.showTabSegue, sender: self)
    }
}
