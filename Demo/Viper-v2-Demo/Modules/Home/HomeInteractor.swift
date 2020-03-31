//
//  HomeInteractor.swift
//  Viper-v2-Demo
//
//  Created by Donik Vrsnak on 4/11/18.
//  Copyright (c) 2018 Infinum. All rights reserved.
//

import Foundation
import Alamofire

final class HomeInteractor {

    fileprivate let _pokemonService = PokemonService()

}

// MARK: - Extensions -

extension HomeInteractor: HomeInteractorInterface {

    @discardableResult
    func getPokemons(_ completion: @escaping PokemonListCompletionBlock) -> DataRequest {
        return _pokemonService.getPokemons(completion)
    }

}
