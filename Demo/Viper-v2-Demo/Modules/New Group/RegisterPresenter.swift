//
//  RegisterPresenter.swift
//  Viper-v2-Demo
//
//  Created by Donik Vrsnak on 5/30/18.
//  Copyright (c) 2018 Infinum. All rights reserved.
//

import UIKit
import Alamofire

final class RegisterPresenter {

    // MARK: - Private properties -

    static private let minimumPasswordLenght: UInt = 6

    private unowned var _view: RegisterViewInterface
    private var _interactor: RegisterInteractorInterface
    private var _wireframe: RegisterWireframeInterface

    private let _authorizationManager : AuthorizationAdapter
    private let _emailValidator: StringValidator
    private let _passwordValidator: StringValidator

    // MARK: - Lifecycle -

    init(wireframe: RegisterWireframeInterface, view: RegisterViewInterface, interactor: RegisterInteractorInterface, authorizationManager : AuthorizationAdapter = AuthorizationAdapter.shared) {
        _wireframe = wireframe
        _view = view
        _interactor = interactor
        _authorizationManager = authorizationManager

        _emailValidator = EmailValidator()
        _passwordValidator = PasswordValidator(minLength: RegisterPresenter.minimumPasswordLenght)
    }
}

// MARK: - Extensions -

extension RegisterPresenter: RegisterPresenterInterface {
    func didSelectCloseAction() {
        _wireframe.dismiss(animated: true)
    }

    func didSelectRegisterAction(with username: String?, email: String?, password: String?, confirmedPassword: String?) {
        guard let _email = email, let _password = password, let _username = username, let _confirmedPassword = confirmedPassword else {
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
        _interactor.registerUser(with: _username, email: _email, password: _password, confirmedPassword: _confirmedPassword) { [weak self] (response) -> (Void) in
            self?._view.hideProgressHUD()
            self?._handleRegisterResult(response.result)
        }
    }

    private func _handleRegisterResult(_ result: Result<User>) {
        switch result {
        case .success(let jsonObject):
            _authorizationManager.authorizationHeader = jsonObject.authorizationHeader
            _wireframe.navigate(to: .home)

        case .failure(let error):
            _wireframe.showErrorAlert(with: error.message)
        }
    }

    private func _showLoginValidationError() {
        _wireframe.showAlert(with: "Error", message: "Please fill all fields")
    }

    private func _showEmailValidationError() {
        _wireframe.showAlert(with: "Error", message: "Please enter valid email")
    }

    private func _showPasswordValidationError() {
        _wireframe.showAlert(with: "Error", message: "Password should be at least 6 characters long")
    }
}
