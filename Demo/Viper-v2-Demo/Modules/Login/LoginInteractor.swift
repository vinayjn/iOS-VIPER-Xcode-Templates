//
//  LoginInteractor.swift
//  VIper-v2-Demo
//
//  Created by Donik Vrsnak on 4/11/18.
//  Copyright (c) 2018 Infinum. All rights reserved.
//

import Foundation
import Alamofire

final class LoginInteractor {

    private var _userService = UserService()
}

// MARK: - Extensions -

extension LoginInteractor: LoginInteractorInterface {

    @discardableResult
    func loginUser(with email: String, password: String, completion: @escaping LoginCompletionBlock) -> DataRequest {
        return _userService.loginUser(with: email, password: password, completion: completion)
    }

}
