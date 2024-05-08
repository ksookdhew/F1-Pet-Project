//
//  ConstructorViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import UIKit

class ConstructorViewController: UIViewController {

    // MARK: IBOutlets
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var constructorImage: UIImageView!
    @IBOutlet weak private var constructorName: UILabel!
    @IBOutlet weak private var constructorNationality: UILabel!
    @IBOutlet weak private var constructorDriver: UILabel!
    @IBOutlet weak private var currentWins: UILabel!
    @IBOutlet weak private var currentPoints: UILabel!
    @IBOutlet weak private var currentPosition: UILabel!

    // MARK: Variables
    var constructor: ConstructorStanding?
    var driver: [Driver]?
    private lazy var viewModel = ConstructorViewModel(repository: ConstructorRepository(), delegate: self)

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
        tableView.register(UINib(nibName: Identifiers.constructorResultsIdentifier, bundle: nil),
                           forHeaderFooterViewReuseIdentifier: Identifiers.constructorResultsIdentifier)
    }

    private func setupView() {
        viewModel.setConstructor(constructor: constructor ?? nil)
        constructorImage.image = UIImage(named: viewModel.constructorImageName)
        constructorName.text = viewModel.constructorName
        constructorNationality.text = viewModel.constructorNationality
        currentPosition.text = viewModel.currentPosition
        currentPoints.text = viewModel.currentPoints
        currentWins.text = viewModel.currentWins
        constructorDriver.text = viewModel.constructorDrivers
    }
}

extension ConstructorViewController: ViewModelDelegate {

    func reloadView() {
        tableView.reloadData()
        constructorDriver.text = viewModel.drivers
    }

    func show(error: String) {
        showAlert(alertTitle: "Error", alertMessage: "Oops, an error occurred")
    }

    func showAlert(alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension ConstructorViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.resultsCount
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        84.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView
            .dequeueReusableCell(withIdentifier: Identifiers.constructorTableViewCell) as? ConstructorTableViewCell else {
            return UITableViewCell()
        }
        guard let result = viewModel.result(atIndex: indexPath.item) else { return UITableViewCell() }
        cell.populateWith(result: result)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView
            .dequeueReusableHeaderFooterView(withIdentifier:Identifiers.constructorResultsIdentifier) as? ConstructorResultHeader else { return UITableViewHeaderFooterView()
        }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        45
    }
}
