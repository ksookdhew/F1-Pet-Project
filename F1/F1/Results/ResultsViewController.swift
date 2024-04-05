//
//  ResultsViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import UIKit

class ResultsViewController: UIViewController {
    private lazy var viewModel = ResultsViewModel(repository: ResultsRepository(),
                                                      delegate: self)
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchRoundResults(round:"2")

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

extension  ResultsViewController: ViewModelDelegate {
    
    func reloadView() {
        //tableView.reloadData()
    }
    
    func show(error: String) {
        //displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
}
