//
//  DriverViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import UIKit

class DriverViewController: UIViewController{
 
    

    private lazy var viewModel = DriverViewModel(repository: DriverRepository(),
                                                      delegate: self)
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchDriver(driverName:"Hamilton")
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


extension DriverViewController: ViewModelDelegate {
    
    func reloadView() {
        //tableView.reloadData()
    }
    
    func show(error: String) {
        //displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
}
