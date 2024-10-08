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

  lazy var tableView: UITableView = {
    let tableView = UITableView()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    tableView.register(DestinationTableViewCell.self, forCellReuseIdentifier: DestinationTableViewCell.identifier)
    tableView.backgroundColor = .white
    tableView.separatorStyle = .none
    return tableView
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
    addSubview(tableView)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      searchBarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
      searchBarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      searchBarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      searchBarView.heightAnchor.constraint(equalToConstant: 60),

      tableView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 5),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }

  func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
    tableView.delegate = delegate
    tableView.dataSource = dataSource
  }

}
