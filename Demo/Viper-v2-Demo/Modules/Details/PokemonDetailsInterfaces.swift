//
//  PokemonDetailsInterfaces.swift
//  Viper-v2-Demo
//
//  Created by Donik Vrsnak on 4/11/18.
//  Copyright (c) 2018 Infinum. All rights reserved.
//

import UIKit

enum PokemonDetailsNavigationOption {
}

protocol PokemonDetailsWireframeInterface: WireframeInterface {
    func navigate(to option: PokemonDetailsNavigationOption)
}

protocol PokemonDetailsViewInterface: ViewInterface {
    func setViewTitle(_ title: String?)
    func setHeaderImage(with url: URL?)
    func reloadData()
}

protocol PokemonDetailsPresenterInterface: PresenterInterface {
    var sections: [Section<PokemonDetailsItem>] { get }
}

protocol PokemonDetailsInteractorInterface: InteractorInterface {
}

// MARK: Table view items

enum PokemonDetailsItem {
    case description(PokemonDetailsDescriptionItemInterface)
    case characteristics(PokemonDetailsCharacteristicsItemInterface)
    case comment(PokemonDetailsCommentItemInterface)
}

protocol PokemonDetailsDescriptionItemInterface {
    var pokemonName: String? { get }
    var description: String? { get }
}

protocol PokemonDetailsCharacteristicsItemInterface {
    var height: Double? { get }
    var weight: Double? { get }
    var gender: String? { get }
}

protocol PokemonDetailsCommentItemInterface {
    var author: String? { get }
    var date: Date? { get }
    var text: String? { get }
}
