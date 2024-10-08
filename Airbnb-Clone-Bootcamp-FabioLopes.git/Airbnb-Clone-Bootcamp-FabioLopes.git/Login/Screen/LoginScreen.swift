//
//  LoginScreen.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 24/09/24.
//

import UIKit

protocol LoginScreenProtocol: AnyObject {
  func tappedSignIn()
  func tappedCreateAccount()
  func tappedGoogle()
  func tappedFacebook()
}

class LoginScreen: UIView {

  weak var delegate: LoginScreenProtocol?

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Entre ou Cadastre-se"
    label.textColor = .black
    label.font = UIFont.boldSystemFont(ofSize: 18)
    return label
  }()

  lazy var emailTextField: UITextField = {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.placeholder = "E-mail"
    tf.borderStyle = .roundedRect
    tf.keyboardType = .emailAddress
    tf.layer.borderColor = UIColor.black.cgColor
    tf.layer.borderWidth = 0.5
    tf.layer.cornerRadius = 8
    tf.text = "teste@teste.com"
    return tf
  }()

  lazy var passwordTextField: UITextField = {
    let tf = UITextField()
    tf.translatesAutoresizingMaskIntoConstraints = false
    tf.placeholder = "Senha:"
    tf.borderStyle = .roundedRect
    tf.layer.borderColor = UIColor.black.cgColor
    tf.layer.borderWidth = 0.5
    tf.layer.cornerRadius = 8
    tf.isSecureTextEntry = true
    tf.text = "123456"
    return tf
  }()

  lazy var loginButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle("Entrar", for: .normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .regular)
    button.setTitleColor(.white, for: .normal)
    button.backgroundColor = .systemPink
    button.clipsToBounds = true
    button.layer.cornerRadius = 8
    button.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
    return button
  }()

  @objc func tappedLoginButton() {
    delegate?.tappedSignIn()
  }

  lazy var orLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .lightGray
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.text = "ou"
    return label
  }()

  lazy var createButton: RegisterButtonView = {
    let cb = RegisterButtonView(text: "Criar conta", image: "create-logo")
    let tap = UITapGestureRecognizer(target: self, action: #selector(tappedCreateButton))
    cb.addGestureRecognizer(tap)
    cb.isUserInteractionEnabled = true
    return cb
  }()

  @objc func tappedCreateButton() {
    delegate?.tappedCreateAccount()
  }

  lazy var googleButton: RegisterButtonView = {
    let cb = RegisterButtonView(text: "Continuar com Google", image: "google-logo")
    let tap = UITapGestureRecognizer(target: self, action: #selector(tappedGoogleButton))
    cb.addGestureRecognizer(tap)
    cb.isUserInteractionEnabled = true
    return cb
  }()

  @objc func tappedGoogleButton() {
    delegate?.tappedGoogle()
  }

  lazy var facebookButton: RegisterButtonView = {
    let cb = RegisterButtonView(text: "Continuar com Facebook", image: "facebook-novo")
    let tap = UITapGestureRecognizer(target: self, action: #selector(tappedFacebookButton))
    cb.addGestureRecognizer(tap)
    cb.isUserInteractionEnabled = true
    return cb
  }()

  @objc func tappedFacebookButton() {
    delegate?.tappedFacebook()
  }

  init() {
    super.init(frame: .zero)
    backgroundColor = .white
    addElements()
    configConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func addElements() {
    addSubview(titleLabel)
    addSubview(emailTextField)
    addSubview(passwordTextField)
    addSubview(loginButton)
    addSubview(orLabel)
    addSubview(createButton)
    addSubview(googleButton)
    addSubview(facebookButton)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 15),
      titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

      emailTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
      emailTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      emailTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
      emailTextField.heightAnchor.constraint(equalToConstant: 44),

      passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 12),
      passwordTextField.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
      passwordTextField.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
      passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),

      loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
      loginButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
      loginButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
      loginButton.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),

      orLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 16),
      orLabel.centerXAnchor.constraint(equalTo: centerXAnchor),

      createButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 20),
      createButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
      createButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
      createButton.heightAnchor.constraint(equalToConstant: 50),

      googleButton.topAnchor.constraint(equalTo: createButton.bottomAnchor, constant: 15),
      googleButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
      googleButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
      googleButton.heightAnchor.constraint(equalToConstant: 50),

      facebookButton.topAnchor.constraint(equalTo: googleButton.bottomAnchor, constant: 15),
      facebookButton.leadingAnchor.constraint(equalTo: emailTextField.leadingAnchor),
      facebookButton.trailingAnchor.constraint(equalTo: emailTextField.trailingAnchor),
      facebookButton.heightAnchor.constraint(equalToConstant: 50),

    ])
  }

}
