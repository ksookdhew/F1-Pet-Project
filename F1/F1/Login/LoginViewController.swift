//
//  LoginViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/10.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var errorMsg: UILabel!
    private lazy var viewModel = LoginViewModel()

    override func viewDidLoad() {
        errorMsg.isHidden = true
        super.viewDidLoad()
    }

    @IBAction func loginAction(_ sender: Any) {
        if viewModel.validDetails(givenUsername: username.text ?? "", givenPassword: password.text ?? "") {
            errorMsg.isHidden = true
            performSegue(withIdentifier: "showTabSegue", sender: self)
        } else {
            errorMsg.isHidden = false
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
