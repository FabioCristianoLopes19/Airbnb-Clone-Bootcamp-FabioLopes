//
//  SearchBarView.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 08/08/24.
//

import Foundation
import UIKit

class SearchBarView: UIView {

  lazy var searchIconImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(systemName: "magnifyingglass")
    imageView.tintColor = .black
    return imageView
  }()

  lazy var searchLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 17)
    label.text = "Para onde?"
    return label
  }()

  lazy var searchDetailLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .lightGray
    label.font = UIFont.systemFont(ofSize: 12)
    label.text = "Qualquer lugar · Qualquer semana · Hóspedes?"
    return label
  }()

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
    addSubview(searchIconImageView)
    addSubview(searchLabel)
    addSubview(searchDetailLabel)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      searchIconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
      searchIconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
      searchIconImageView.heightAnchor.constraint(equalToConstant: 24),
      searchIconImageView.widthAnchor.constraint(equalToConstant: 24),

      searchLabel.leadingAnchor.constraint(equalTo: searchIconImageView.trailingAnchor, constant: 8),
      searchLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),

      searchDetailLabel.leadingAnchor.constraint(equalTo: searchLabel.leadingAnchor),
      searchDetailLabel.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 2),
      searchDetailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -2)
    ])
  }

}


