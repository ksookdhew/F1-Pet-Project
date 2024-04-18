//
//  ConstructorViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import UIKit

class ConstructorViewController: UIViewController {
    private lazy var viewModel = ConstructorViewModel(repository: ConstructorRepository(),
                                                      delegate: self)
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var constructorImg: UIImageView!
    @IBOutlet weak private var constructorName: UILabel!
    @IBOutlet weak private var constructorNationality: UILabel!
    @IBOutlet weak private var constructorDriver: UILabel!
    @IBOutlet weak private var currentWins: UILabel!
    @IBOutlet weak private var currentPoints: UILabel!
    @IBOutlet weak private var currentPosition: UILabel!
    var constructor: ConstructorStanding?
    var driver: [Driver]?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchConstructor(constructorName: constructor?.constructor.constructorID ?? "")
        constructorImg.image = UIImage(named: viewModel.imageName(constructorId: constructor?.constructor.constructorID ?? ""))
        constructorName.text = constructor?.constructor.name
        constructorNationality.text = constructor?.constructor.nationality
        currentPosition.text = constructor?.position
        currentPoints.text = constructor?.points
        currentWins.text = constructor?.wins
        constructorDriver.text = ""
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ConstructorTableViewCell.nib(),
                           forCellReuseIdentifier: ConstructorTableViewCell.identifier)
        tableView.register(UINib(nibName: "ConstructorResultHeader", bundle: nil),
                           forHeaderFooterViewReuseIdentifier: "ConstructorResultHeader")
    }
    
}
extension ConstructorViewController: ViewModelDelegate {

    func reloadView() {
        tableView.reloadData()
        constructorDriver.text = viewModel.drivers
    }

    func show(error: String) {
        
    }
}

// MARK: - UITableViewDelegate and UITableViewDataSource
extension ConstructorViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.resultsCount
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84.0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ConstructorTableViewCell.identifier)
                as? ConstructorTableViewCell
        else { return UITableViewCell() }
        guard let result = viewModel.result(atIndex: indexPath.item) else { return UITableViewCell() }
        cell.populateWith(result: result)
        return cell
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                            "ConstructorResultHeader") as? ConstructorResultHeader
        else { return UITableViewHeaderFooterView() }
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
}
