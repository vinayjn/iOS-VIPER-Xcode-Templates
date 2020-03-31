//
//  PokemonDetailsPresenter.swift
//  Viper-v2-Demo
//
//  Created by Donik Vrsnak on 4/11/18.
//  Copyright (c) 2018 Infinum. All rights reserved.
//

import UIKit

final class PokemonDetailsPresenter {

    // MARK: - Private properties -

    private unowned var _view: PokemonDetailsViewInterface
    private var _interactor: PokemonDetailsInteractorInterface
    private var _wireframe: PokemonDetailsWireframeInterface

    private let _pokemon: Pokemon
    var sections: [Section<PokemonDetailsItem>] = [] {
        didSet {
            _view.reloadData()
        }
    }

    // MARK: - Lifecycle -

    init(wireframe: PokemonDetailsWireframeInterface, view: PokemonDetailsViewInterface, interactor: PokemonDetailsInteractorInterface, pokemon: Pokemon) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
        _pokemon = pokemon
    }
}

// MARK: - Extensions -

extension PokemonDetailsPresenter: PokemonDetailsPresenterInterface {

    private var descriptionSection: Section<PokemonDetailsItem> {
        return Section(
            items: [PokemonDetailsItem.description(_pokemon)]
        )
    }

    private var characteristicsSection: Section<PokemonDetailsItem> {
        return Section(
            items: [PokemonDetailsItem.characteristics(_pokemon)]
        )
    }

    func viewDidLoad() {
        _view.setViewTitle(_pokemon.name)
        _view.setHeaderImage(with: _pokemon.imageURL)

        sections = [
            descriptionSection,
        ]
        _view.reloadData()
    }
}
