//
//  LoginViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/10.
//

import UIKit

class LoginViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMessage: UILabel!

    // MARK: Variables
    private lazy var viewModel = LoginViewModel()

    // MARK: Function
    override func viewDidLoad() {
        errorMessage.isHidden = true
        super.viewDidLoad()
    }

    // MARK: IBAction
    @IBAction func loginAction(_ sender: Any) {
        if viewModel.validDetails(givenUsername: username.text, givenPassword: password.text) {
            errorMessage.isHidden = true
            performSegue(withIdentifier: Identifiers.showTabSegue, sender: self)
        } else {
            errorMessage.isHidden = false
        }
    }
}
