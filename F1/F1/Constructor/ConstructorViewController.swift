//
//  ConstructorViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import UIKit

class ConstructorViewController: LoadingIndicatorViewController {

    // MARK: IBOutlets
    @IBOutlet weak private var tableView: UITableView!

    // MARK: Variables
    var constructor: ConstructorStanding?
    var driver: [Driver]?
    private lazy var viewModel = ConstructorViewModel(repository: ConstructorRepository(coreDataManager: CoreDataManager()), delegate: self)

    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchConstructor(constructorName: constructor?.constructor.constructorID ?? "")
        setupView()
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ConstructorTableViewCell.nib(),
                           forCellReuseIdentifier: Identifiers.constructorTableViewCell)
        tableView.register(ConstructorInfoTableViewCell.nib(),
                           forCellReuseIdentifier: Identifiers.constructorInfoTableViewCell)
        tableView.register(UINib(nibName: Identifiers.constructorResultsIdentifier, bundle: nil),
                           forHeaderFooterViewReuseIdentifier: Identifiers.constructorResultsIdentifier)
    }

    private func setupView() {
        viewModel.setConstructor(constructor: constructor ?? nil)
        tableView.isHidden = true
    }
}

extension ConstructorViewController: ViewModelDelegate {

    func reloadView() {
        tableView.reloadData()
        hideLoadingIndicator()
        tableView.isHidden = false
    }

    func show(error: String) {
        showAlert(alertTitle: "Error", alertMessage: "Oops, an error occurred")
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension ConstructorViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let numberOfRows = [1, viewModel.resultsCount]
        return numberOfRows[section]
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let heights = [360.0, 84.0]
        return heights[indexPath.section]
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: Identifiers.constructorInfoTableViewCell) as? ConstructorInfoTableViewCell else {
                return UITableViewCell()
            }
            guard let result = constructor else {
                return UITableViewCell()
            }
            cell.populateWith(constructor: result, drivers: viewModel.drivers)
            return cell

        default:
            guard let cell = tableView
                .dequeueReusableCell(withIdentifier: Identifiers.constructorTableViewCell) as? ConstructorTableViewCell else {
                return UITableViewCell()
            }
            guard let result = viewModel.result(atIndex: indexPath.item) else { return UITableViewCell() }
            cell.populateWith(result: result)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView
            .dequeueReusableHeaderFooterView(withIdentifier: Identifiers.constructorResultsIdentifier) as? ConstructorResultHeader else { return UITableViewHeaderFooterView()
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let headerHeights = [0.0, 45.0]
        return headerHeights[section]
    }
}
