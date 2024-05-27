//
//  MoreViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/27.
//

import UIKit

class MoreViewController: UIViewController {

    // MARK: Logout Function
    @IBAction func logOut(_ sender: Any) {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate {
            let storyboard = UIStoryboard(name: Identifiers.login, bundle: nil)
            let loginViewController = storyboard.instantiateViewController(withIdentifier: Identifiers.login)
            let navigationController = UINavigationController(rootViewController: loginViewController)
            navigationController.navigationBar.isHidden = true
            sceneDelegate.window?.rootViewController = navigationController
        }
    }
}
