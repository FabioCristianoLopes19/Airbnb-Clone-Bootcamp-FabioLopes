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

class LoginViewModel {
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            guard error == nil else {
                print(error?.localizedDescription ?? "")
                return
            }
            
            print("sucesso!!")
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
