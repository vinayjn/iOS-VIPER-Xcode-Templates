//
//  RegisterViewController.swift
//  Viper-v2-Demo
//
//  Created by Donik Vrsnak on 5/30/18.
//  Copyright (c) 2018 Infinum. All rights reserved.
//

import UIKit

final class RegisterViewController: UIViewController {

    // MARK: - Public properties -

    var presenter: RegisterPresenterInterface!

    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var ballImageView: UIImageView!

    @IBOutlet private weak var usernameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var confirmPasswordTextField: UITextField!

    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet private weak var registerButtonBottomMargin: NSLayoutConstraint!

    // MARK: - Lifecycle -

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.setNavigationBarHidden(false, animated: animated)
        _registerForKeyboardNotifications()
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Actions

    @IBAction private func _registerButtonActionHandler() {
        presenter.didSelectRegisterAction(with: usernameTextField.text, email: emailTextField.text, password: passwordTextField.text, confirmedPassword: confirmPasswordTextField.text)
    }

    @IBAction private func _tapGestureRecognizerActionHandler() {
        view.endEditing(true)
    }

    @IBAction private func _closeButtonActionHandler() {
        presenter.didSelectCloseAction()
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
        registerButtonBottomMargin.constant = -keyboardHeight
        view.setNeedsUpdateConstraints()

        UIView.animate(withDuration: 0.3) {
            self.ballImageView.alpha = 0.0
            self.logoImageView.alpha = 0.0
            self.view.layoutIfNeeded()
        }
    }

    @objc private func _keyboardWillHide(_ notification: Notification) {
        view.layoutIfNeeded()
        registerButtonBottomMargin.constant = 0
        view.setNeedsUpdateConstraints()

        UIView.animate(withDuration: 0.3) {
            self.ballImageView.alpha = 1.0
            self.logoImageView.alpha = 1.0
            self.view.layoutIfNeeded()
        }
    }


}

// MARK: - Extensions -

extension RegisterViewController : RegisterViewInterface {
}

extension RegisterViewController: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameTextField {
            emailTextField.becomeFirstResponder()
        } else if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            confirmPasswordTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}
