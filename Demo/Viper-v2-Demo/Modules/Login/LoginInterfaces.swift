//
//  LoginInterfaces.swift
//  VIper-v2-Demo
//
//  Created by Donik Vrsnak on 4/11/18.
//  Copyright (c) 2018 Infinum. All rights reserved.
//

import UIKit
import Alamofire

enum LoginNavigationOption {
    case home
    case register
}

protocol LoginWireframeInterface: WireframeInterface {
    func navigate(to option: LoginNavigationOption)
}

protocol LoginViewInterface: ViewInterface {
}

protocol LoginPresenterInterface: PresenterInterface {
    func didSelectLoginAction(with email: String?, password: String?)
    func didSelectRegisterAction()
}

protocol LoginInteractorInterface: InteractorInterface {

    @discardableResult
    func loginUser(with email: String, password: String, completion: @escaping LoginCompletionBlock) -> DataRequest
}
