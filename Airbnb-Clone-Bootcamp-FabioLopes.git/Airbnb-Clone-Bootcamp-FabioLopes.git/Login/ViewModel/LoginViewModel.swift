//
//  LoginViewModel.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 24/09/24.
//

import Foundation
import FirebaseAuth
import GoogleSignIn
import FirebaseCore
import FacebookLogin

protocol LoginViewModelProtocol: AnyObject {
  func successLogin()
  func failureLogin()
}

class LoginViewModel {

  private weak var delegate: LoginViewModelProtocol?

  public func delegate(delegate: LoginViewModelProtocol?) {
    self.delegate = delegate
  }

  func createUserWithEmailAndPassword(email: String, password: String) {
    FirestoreManager.shared.createUserWithEmailAndPassword(email: email, password: password, name: "Caio") { result in
      switch result {
        case .success:
        FirestoreManager.shared.saveJsonDataOnFirebase()
      case .failure(let error):
        print(error.localizedDescription)
      }
    }
  }

  func signInWithEmailAndPassword(email: String, password: String) {
    Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
      guard let self, error == nil else {
        print(error?.localizedDescription ?? "")
        self?.delegate?.failureLogin()
        return
      }
      delegate?.successLogin()
    }
  }

  func signInWithGoogle(viewController: UIViewController) {
    guard let clientID = FirebaseApp.app()?.options.clientID else { return }
    let config = GIDConfiguration(clientID: clientID)
    GIDSignIn.sharedInstance.configuration = config
    GIDSignIn.sharedInstance.signIn(withPresenting: viewController) { result, error in
      if let error {
        print("error GIDSignIn: \(error.localizedDescription)")
      }

      guard let user = result?.user,
            let idToken = user.idToken?.tokenString else {
        print("error proprieties not contain value")
        return
      }

      let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
      self.authCredential(credential: credential)
    }
  }

  func signInWithFacebook(viewController: UIViewController) {
    let loginManager = LoginManager()
    loginManager.logIn(permissions: ["public_profile", "email"], from: viewController) { result, error in
      if let error {
        print("error GIDSignIn: \(error.localizedDescription)")
      }

      guard let accessToken = AccessToken.current else {
        print("Token de acesso não encontrado")
        return
      }

      let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
      self.authCredential(credential: credential)
    }
  }


  private func authCredential(credential: AuthCredential) {
    Auth.auth().signIn(with: credential) { result, error in
      guard error == nil else {
        print(error?.localizedDescription ?? "")
        return
      }

      print("ID User-> \(result?.user.uid ?? "")")
      print("sucesso!!")
    }
  }

}
