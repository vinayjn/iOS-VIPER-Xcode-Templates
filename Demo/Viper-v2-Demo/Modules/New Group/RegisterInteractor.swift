//
//  RegisterInteractor.swift
//  Viper-v2-Demo
//
//  Created by Donik Vrsnak on 5/30/18.
//  Copyright (c) 2018 Infinum. All rights reserved.
//

import Foundation
import Alamofire

final class RegisterInteractor {

    private var _userService = UserService()
}

// MARK: - Extensions -

extension RegisterInteractor: RegisterInteractorInterface {

    @discardableResult
    func registerUser(with username: String, email: String, password: String, confirmedPassword: String, completion: @escaping LoginCompletionBlock) -> DataRequest {
        return _userService.registerUser(with: username, email: email, password: password, confirmedPassword: confirmedPassword, completion: completion)
    }
}
