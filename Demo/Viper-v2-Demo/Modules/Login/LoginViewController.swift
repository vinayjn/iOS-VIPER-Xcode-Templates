//
//  LoginViewController.swift
//  VIper-v2-Demo
//
//  Created by Donik Vrsnak on 4/11/18.
//  Copyright (c) 2018 Infinum. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: LoginPresenterInterface!

    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var ballImageView: UIImageView!

    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!

    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var loginButtonBottomMargin: NSLayoutConstraint!
    @IBOutlet private weak var registerButton: UIButton!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        _registerForKeyboardNotifications()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Actions

    @IBAction private func _loginButtonActionHandler() {
        presenter.didSelectLoginAction(
            with: emailTextField.text,
            password: passwordTextField.text
        )
    }

    @IBAction private func _registerButtonActionHandler() {
        presenter.didSelectRegisterAction()
    }

    @IBAction private func _tapGestureRecognizerActionHandler() {
        view.endEditing(true)
    }

    // MARK: Private

    private func _registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(_keyboardWillShow(_:)),
            name: .UIKeyboardWillShow,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(_keyboardWillHide(_:)),
            name: .UIKeyboardWillHide,
            object: nil
        )
    }

    @objc private func _keyboardWillShow(_ notification: Notification) {
        let userInfo = notification.userInfo!
        let keyboardHeight = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue.height

        view.layoutIfNeeded()
        loginButtonBottomMargin.constant = keyboardHeight
        view.setNeedsUpdateConstraints()

        UIView.animate(withDuration: 0.3) {
            self.ballImageView.alpha = 0.0
            self.view.layoutIfNeeded()
        }
    }

    @objc private func _keyboardWillHide(_ notification: Notification) {
        view.layoutIfNeeded()
        loginButtonBottomMargin.constant = 0
        view.setNeedsUpdateConstraints()

        UIView.animate(withDuration: 0.3) {
            self.ballImageView.alpha = 1.0
            self.view.layoutIfNeeded()
        }
    }


}

// MARK: - Extensions -

extension LoginViewController: LoginViewInterface {
}

extension LoginViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
