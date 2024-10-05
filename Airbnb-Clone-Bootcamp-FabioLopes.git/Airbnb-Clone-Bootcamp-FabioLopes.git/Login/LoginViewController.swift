//
//  LoginViewController.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 24/09/24.
//

import UIKit

class LoginViewController: UIViewController {

  var screen: LoginScreen?
  var viewModel = LoginViewModel()

  override func viewWillAppear(_ animated: Bool) {
    navigationController?.isNavigationBarHidden = true
  }

  override func loadView() {
    screen = LoginScreen()
    view = screen
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    screen?.delegate = self
  }

}

extension LoginViewController: LoginScreenProtocol {
  func tappedSignIn() {
      viewModel.signIn(email: screen?.emailTextField.text ?? "", password: screen?.passwordTextField.text ?? "")
//      viewModel.signInWithEmailAndPassword(email: screen?.emailTextField.text ?? "", password: screen?.passwordTextField.text ?? "")
      //    viewModel.createUserWithEmailAndPassword(email: screen?.emailTextField.text ?? "", password: screen?.passwordTextField.text ?? "")
  }

  func tappedCreateAccount() {
    print(#function)
  }

  func tappedGoogle() {
      viewModel.signInWithGoogle(viewController: self)
  }

  func tappedFacebook() {
      viewModel.signInWithFacebook(viewController: self)
  }
}

