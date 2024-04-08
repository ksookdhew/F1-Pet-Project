//
//  ResultsViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/03.
//

import UIKit

class ResultsViewController: UIViewController {
    @IBOutlet weak var allResultsTableView: UITableView!

    private lazy var viewModel = ResultsViewModel(repository: ResultsRepository(),
                                                      delegate: self)
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchResults()
    }

    private func setupTableView() {
        allResultsTableView.delegate = self
        allResultsTableView.dataSource = self
        allResultsTableView.register(AllResultsTableViewCell.nib(), forCellReuseIdentifier: AllResultsTableViewCell.identifier)
    }

    // MARK: - Navigation


}

// MARK: - TableView Delegate

 extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allResultsCount
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = allResultsTableView.dequeueReusableCell(withIdentifier: AllResultsTableViewCell.identifier)
                as? AllResultsTableViewCell
        else { return UITableViewCell() }
        guard let result = viewModel.allResult(atIndex: indexPath.item) else { return UITableViewCell() }
        cell.populateWith(race: result)
        return cell
    }
 }

extension  ResultsViewController: ViewModelDelegate {

    func reloadView() {
        allResultsTableView.reloadData()
    }

    func show(error: String) {
        // displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
}
