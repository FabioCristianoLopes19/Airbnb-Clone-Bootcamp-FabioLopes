//
//  RegisterButtonView.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 24/09/24.
//

import UIKit

class RegisterButtonView: UIView {

  var text: String
  var image: String

  lazy var containerView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.layer.borderColor = UIColor.black.cgColor
    view.layer.borderWidth = 0.5
    view.layer.cornerRadius = 8
    return view
  }()

  lazy var iconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: image)
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()

  lazy var textLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .lightGray
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.text = text
    return label
  }()

  init(text: String, image: String) {
    self.text = text
    self.image = image
    super.init(frame: .zero)
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = .white
    addElements()
    configConstraints()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func addElements() {
    addSubview(containerView)
    containerView.addSubview(iconImageView)
    containerView.addSubview(textLabel)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      containerView.topAnchor.constraint(equalTo: topAnchor),
      containerView.leadingAnchor.constraint(equalTo: leadingAnchor),
      containerView.trailingAnchor.constraint(equalTo: trailingAnchor),
      containerView.bottomAnchor.constraint(equalTo: bottomAnchor),

      iconImageView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      iconImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 10),
      iconImageView.heightAnchor.constraint(equalToConstant: 24),
      iconImageView.widthAnchor.constraint(equalToConstant: 24),

      textLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
      textLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
    ])
  }
}
