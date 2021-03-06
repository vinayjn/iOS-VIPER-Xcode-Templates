//
//  PokemonDetailsViewController.swift
//  Viper-v2-Demo
//
//  Created by Donik Vrsnak on 4/11/18.
//  Copyright (c) 2018 Infinum. All rights reserved.
//

import UIKit

final class PokemonDetailsViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: PokemonDetailsPresenterInterface!

    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            _setupTableView()
        }
    }
    @IBOutlet private weak var headerImageView: UIImageView!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }

    private func _setupTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

}

// MARK: - Extensions -

extension PokemonDetailsViewController: PokemonDetailsViewInterface {

    func setViewTitle(_ title: String?) {
        navigationItem.title = title
    }

    func setHeaderImage(with url: URL?) {
        guard let _url = url else {
            headerImageView.image = #imageLiteral(resourceName: "image-placeholder")
            return
        }

        headerImageView.af_setImage(
            withURL: _url,
            placeholderImage: #imageLiteral(resourceName: "image-placeholder")
        )
    }

    func reloadData() {
        tableView.reloadData()
    }

}

extension PokemonDetailsViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.sections[section].items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = presenter.sections[indexPath.section]
        let item = section.items[indexPath.row]
        switch item {
        case .description(let descriptionItem):
            let cell = tableView.dequeueReusableCell(ofType: PokemonDetailsDescriptionTableViewCell.self, for: indexPath)
            cell.configure(with: descriptionItem)
            return cell

        case .characteristics(let characteristicsItem):
            let cell = tableView.dequeueReusableCell(ofType: PokemonDetailsCharacteristicsTableViewCell.self, for: indexPath)
            cell.configure(with: characteristicsItem)
            return cell

        case .comment(let commentItem):
            let cell = tableView.dequeueReusableCell(ofType: PokemonDetailsCommentTableViewCell.self, for: indexPath)
            cell.configure(with: commentItem)
            return cell
        }
    }

}
