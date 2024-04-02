//
//  ConstructorStandingsViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew
//


import UIKit

class ConstructorStandingsViewController: UIViewController {

    private lazy var viewModel = ConstructorStandingsViewModel(repository: F1Repository(),
                                                      delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchConstructorStandings()
        // Do any additional setup after loading the view.
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


// MARK: - ViewModel Delegate

extension ConstructorStandingsViewController: ViewModelDelegate {
    
    func reloadView() {
        //tableView.reloadData()
    }
    
    func show(error: String) {
        //displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
}

