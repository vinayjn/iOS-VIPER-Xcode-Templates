//
//  HomeViewController.swift
//  Viper-v2-Demo
//
//  Created by Donik Vrsnak on 4/11/18.
//  Copyright (c) 2018 Infinum. All rights reserved.
//

import UIKit

final class HomeViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: HomePresenterInterface!

    @IBOutlet private weak var emptyPlaceholderLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var activityIndicator: UIActivityIndicatorView!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()

        _setupView()
        presenter.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }

    private func _setupView() {
        emptyPlaceholderLabel.isHidden = true
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    @IBAction private func logoutButtonActionHandler() {
        presenter.didSelectLogoutAction()
    }

    @IBAction private func addButtonActionHandler() {
        presenter.didSelectAddAction()
    }
}

// MARK: - Extensions -

extension HomeViewController: HomeViewInterface {

    func reloadData() {
        tableView.reloadData()
    }

    func setLoadingVisible(_ visible: Bool) {
        if visible {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }

    func setEmptyPlaceholderHidden(_ hidden: Bool) {
        emptyPlaceholderLabel.isHidden = hidden
    }

}

extension HomeViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOrItems(in: section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        let item = presenter.item(at: indexPath)
        cell.configure(with: item)
        return cell
    }

}

extension HomeViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        presenter.didSelectItem(at: indexPath)
    }
}
