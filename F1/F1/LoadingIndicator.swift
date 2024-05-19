//
//  LoadingIndicatorView.swift
//  F1
//
//  Created by Kaitlyn Sookdhew on 2024/05/18.
//
import UIKit

//MARK: Viewcontroller
class LoadingIndicatorViewController: UIViewController {

    private let loadingIndicator = LoadingIndicatorView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLoadingIndicator()
        showLoadingIndicator()
    }

    private func setupLoadingIndicator() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(loadingIndicator)
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loadingIndicator.widthAnchor.constraint(equalToConstant: 100),
            loadingIndicator.heightAnchor.constraint(equalToConstant: 100)
        ])
        loadingIndicator.isHidden = true
    }

    func showLoadingIndicator() {
        loadingIndicator.startLoading()
    }

    func hideLoadingIndicator() {
        loadingIndicator.stopLoading()
    }
}

//MARK: View
class LoadingIndicatorView: UIView {

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.color = .white
        return indicator
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    private func setupView() {
        addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        backgroundColor = UIColor(white: 0, alpha: 0.7)
        layer.cornerRadius = 10
    }

    func startLoading() {
        activityIndicator.startAnimating()
        isHidden = false
    }

    func stopLoading() {
        activityIndicator.stopAnimating()
        isHidden = true
    }
}
