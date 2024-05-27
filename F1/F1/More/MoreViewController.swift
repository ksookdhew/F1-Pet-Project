//
//  MoreViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/27.
//

import UIKit

class MoreViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.logOutSegue {
            self.hidesBottomBarWhenPushed = true
        }
    }
    @IBAction func logOut(_ sender: Any) {
        navigate(identifier: Identifiers.logOutSegue, sender: self)
    }

}
