//
//  DriverViewController.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/04/02.
//

import UIKit

class DriverViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var driver: DriverStanding?
    private lazy var viewModel = DriverViewModel(repository: DriverRepository(), delegate: self)

    @IBOutlet weak var driverImg: UIImageView!
    @IBOutlet weak var driverName: UILabel!
    @IBOutlet weak var driverNationality: UILabel!
    @IBOutlet weak var driverConstructor: UILabel!
    @IBOutlet weak var driverSurname: UILabel!

    @IBOutlet weak var currentWins: UILabel!
    @IBOutlet weak var currentPoints: UILabel!
    @IBOutlet weak var currentPos: UILabel!


    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        viewModel.fetchDriver(driverName: driver?.driver.driverID ?? "")

        driverImg.image = UIImage(named: "\(driver?.driver.code ?? "").png")
        driverName.text = driver?.driver.givenName
        driverSurname.text = driver?.driver.familyName
        driverConstructor.text = "\(driver?.driver.permanentNumber ?? "") | \(driver?.constructors[0].name ?? "") "
        driverNationality.text = driver?.driver.nationality
        currentPos.text = driver?.position
        currentPoints.text = driver?.points
        currentWins.text = driver?.wins
    }

    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(DriverTableViewCell.nib(),
           forCellReuseIdentifier: DriverTableViewCell.identifier)
        tableView.register(UINib(nibName: "DriverResultHeader", bundle: nil),
           forHeaderFooterViewReuseIdentifier: "DriverResultHeader")
    }

}


extension DriverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.resultsCount
    }
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 42.0
      }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DriverTableViewCell.identifier)
                as? DriverTableViewCell
        else { return UITableViewCell() }
        guard let result = viewModel.result(atIndex: indexPath.item) else { return UITableViewCell() }
        let laptime = viewModel.laptime(index: indexPath.item)
        cell.populateWith(result: result, lapTime: laptime)
        return cell
    }

     func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
         guard let headerView = tableView.dequeueReusableHeaderFooterView(withIdentifier:
            "DriverResultHeader") as? DriverResultHeader
         else { return UITableViewHeaderFooterView() }
     return headerView
     }

     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
     return 45
     }
}

extension  DriverViewController: ViewModelDelegate {

    func reloadView() {
        tableView.reloadData()
    }

    func show(error: String) {
        // displayAlert(title: "Error", message: error, buttonTitle: "Ok")
    }
}
