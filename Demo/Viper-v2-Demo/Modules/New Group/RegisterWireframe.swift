//
//  RegisterWireframe.swift
//  Viper-v2-Demo
//
//  Created by Donik Vrsnak on 5/30/18.
//  Copyright (c) 2018 Infinum. All rights reserved.
//

import UIKit

final class RegisterWireframe: BaseWireframe {

    // MARK: - Private properties -

    private let _storyboard = UIStoryboard(name: "Register", bundle: nil)

    // MARK: - Module setup -

    init() {
        let moduleViewController = _storyboard.instantiateViewController(ofType: RegisterViewController.self)
        super.init(viewController: moduleViewController)

        let interactor = RegisterInteractor()
        let presenter = RegisterPresenter(wireframe: self, view: moduleViewController, interactor: interactor)
        moduleViewController.presenter = presenter
    }

}

// MARK: - Extensions -

extension RegisterWireframe: RegisterWireframeInterface {

    func navigate(to option: RegisterNavigationOption) {
        switch option {
        case .home:
            _openHome()
        }
    }

    private func _openHome() {
        let wireframe = HomeWireframe()
        let presentingViewController = navigationController?.presentingViewController as? UINavigationController

        navigationController?.presentingViewController?.dismiss(animated: true) {
            presentingViewController?.pushWireframe(wireframe)
        }
    }
}
