//
//  HomeInterfaces.swift
//  Viper-v2-Demo
//
//  Created by Donik Vrsnak on 4/11/18.
//  Copyright (c) 2018 Infinum. All rights reserved.
//

import UIKit
import Alamofire

enum HomeNavigationOption {
    case login
    case details(Pokemon)
    case add
}

protocol HomeWireframeInterface: WireframeInterface {
    func navigate(to option: HomeNavigationOption)
}

protocol HomeViewInterface: ViewInterface {
    func reloadData()
    func setEmptyPlaceholderHidden(_ hidden: Bool)
    func setLoadingVisible(_ visible: Bool)
}

protocol HomePresenterInterface: PresenterInterface {
    func didSelectLogoutAction()
    func didSelectAddAction()

    func numberOfSections() -> Int
    func numberOrItems(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> HomeViewItemInterface
    func didSelectItem(at indexPath: IndexPath)
}

protocol HomeInteractorInterface: InteractorInterface {
    @discardableResult
    func getPokemons(_ completion: @escaping PokemonListCompletionBlock) -> DataRequest
}

protocol HomeViewItemInterface {
    var title: String? { get }
    var imageURL: URL? { get }
}
