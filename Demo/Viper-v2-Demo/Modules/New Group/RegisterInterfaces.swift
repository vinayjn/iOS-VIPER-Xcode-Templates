//
//  RegisterInterfaces.swift
//  Viper-v2-Demo
//
//  Created by Donik Vrsnak on 5/30/18.
//  Copyright (c) 2018 Infinum. All rights reserved.
//

import UIKit
import Alamofire

enum RegisterNavigationOption {
    case home
}

protocol RegisterWireframeInterface: WireframeInterface {
    func navigate(to option: RegisterNavigationOption)
}

protocol RegisterViewInterface: ViewInterface {
}

protocol RegisterPresenterInterface: PresenterInterface {
    func didSelectCloseAction()
    func didSelectRegisterAction(with username: String?, email: String?, password: String?, confirmedPassword: String?)
}

protocol RegisterInteractorInterface: InteractorInterface {

    @discardableResult
    func registerUser(with username: String, email: String, password: String, confirmedPassword: String, completion: @escaping LoginCompletionBlock) -> DataRequest
}
