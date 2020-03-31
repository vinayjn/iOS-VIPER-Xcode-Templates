//
//  LoginPresenter.swift
//  VIper-v2-Demo
//
//  Created by Donik Vrsnak on 4/11/18.
//  Copyright (c) 2018 Infinum. All rights reserved.
//

import UIKit
import Alamofire

final class LoginPresenter {

    // MARK: - Private properties -

    static private let minimumPasswordLenght: UInt = 6

    private unowned var _view: LoginViewInterface
    private var _interactor: LoginInteractorInterface
    private var _wireframe: LoginWireframeInterface

    private let _emailValidator: StringValidator
    private let _passwordValidator: StringValidator
    private let _authorizationManager: AuthorizationAdapter


    // MARK: - Lifecycle -

    init(wireframe: LoginWireframeInterface, view: LoginViewInterface, interactor: LoginInteractorInterface, authorizationManager: AuthorizationAdapter = AuthorizationAdapter.shared) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
        _authorizationManager = authorizationManager

        _emailValidator = EmailValidator()
        _passwordValidator = PasswordValidator(minLength: LoginPresenter.minimumPasswordLenght)
    }
}

// MARK: - Extensions -

extension LoginPresenter: LoginPresenterInterface {

    func didSelectLoginAction(with email: String?, password: String?) {
        guard let _email = email, let _password = password else {
            _showLoginValidationError()
            return
        }
        guard _emailValidator.isValid(_email) else {
            _showEmailValidationError()
            return
        }
        guard _passwordValidator.isValid(_password) else {
            _showPasswordValidationError()
            return
        }

        _view.showProgressHUD()
        _interactor.loginUser(with: _email, password: _password) { [weak self] (response) -> (Void) in
            self?._view.hideProgressHUD()
            self?._handleLoginResult(response.result)
        }
    }

    func didSelectRegisterAction() {
        _wireframe.navigate(to: .register)
    }

    private func _handleLoginResult(_ result: Result<User>) {
        switch result {
        case .success(let jsonObject):
            _authorizationManager.authorizationHeader = jsonObject.authorizationHeader
            _wireframe.navigate(to: .home)

        case .failure(let error):
            _wireframe.showErrorAlert(with: error.message)
        }
    }

    private func _showLoginValidationError() {
        _wireframe.showAlert(with: "Error", message: "Please enter email and password")
    }

    private func _showEmailValidationError() {
        _wireframe.showAlert(with: "Error", message: "Please enter valid email")
    }

    private func _showPasswordValidationError() {
        _wireframe.showAlert(with: "Error", message: "Password should be at least 6 characters long")
    }
}
