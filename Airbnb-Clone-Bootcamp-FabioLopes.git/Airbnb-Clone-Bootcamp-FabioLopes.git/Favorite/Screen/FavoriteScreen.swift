//
//  FavoriteScreen.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 05/08/24.
//

import Foundation
import UIKit

class FavoriteScreen: UIView {

  lazy var searchBarView: SearchBarView = {
    let view = SearchBarView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .white
    view.layer.cornerRadius = 30
    // sombra
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 0.1
    view.layer.shadowOffset = CGSize(width: 0, height: 2)
    view.layer.shadowRadius = 8
    return view
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
    addSubview(searchBarView)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      searchBarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
      searchBarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      searchBarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      searchBarView.heightAnchor.constraint(equalToConstant: 60),
    ])
  }

}
