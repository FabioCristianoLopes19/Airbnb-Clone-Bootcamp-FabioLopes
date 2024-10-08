//
//  ExploreScreen.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 05/08/24.
//

import Foundation
import UIKit

class ExploreScreen: UIView {

  lazy var searchBarView: UIView = {
    let view = UIView()
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

  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = .white
    collectionView.register(CategoryCollectionViewCell.self, forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
    return collectionView
  }()

  lazy var lineView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .lightGray
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

  func configCollectionViewProtocols(delegate: UICollectionViewDelegate, dataSource: UICollectionViewDataSource) {
    collectionView.delegate = delegate
    collectionView.dataSource = dataSource
    collectionView.reloadData()
  }

  func addElements() {
    addSubview(searchBarView)
    searchBarView.addSubview(searchIconImageView)
    searchBarView.addSubview(searchLabel)
    searchBarView.addSubview(searchDetailLabel)
    addSubview(collectionView)
    addSubview(lineView)
    addSubview(tableView)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      searchBarView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 16),
      searchBarView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      searchBarView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      searchBarView.heightAnchor.constraint(equalToConstant: 60),

      searchIconImageView.leadingAnchor.constraint(equalTo: searchBarView.leadingAnchor, constant: 12),
      searchIconImageView.centerYAnchor.constraint(equalTo: searchBarView.centerYAnchor),
      searchIconImageView.heightAnchor.constraint(equalToConstant: 24),
      searchIconImageView.widthAnchor.constraint(equalToConstant: 24),

      searchLabel.leadingAnchor.constraint(equalTo: searchIconImageView.trailingAnchor, constant: 8),
      searchLabel.topAnchor.constraint(equalTo: searchBarView.topAnchor, constant: 12),

      searchDetailLabel.leadingAnchor.constraint(equalTo: searchLabel.leadingAnchor),
      searchDetailLabel.topAnchor.constraint(equalTo: searchLabel.bottomAnchor, constant: 2),
      searchDetailLabel.trailingAnchor.constraint(equalTo: searchBarView.trailingAnchor, constant: -2),

      collectionView.topAnchor.constraint(equalTo: searchBarView.bottomAnchor, constant: 16),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.heightAnchor.constraint(equalToConstant: CategoryCollectionViewCell.height),

      lineView.topAnchor.constraint(equalTo: collectionView.bottomAnchor),
      lineView.leadingAnchor.constraint(equalTo: leadingAnchor),
      lineView.trailingAnchor.constraint(equalTo: trailingAnchor),
      lineView.heightAnchor.constraint(equalToConstant: 0.3),

      tableView.topAnchor.constraint(equalTo: lineView.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
      tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
      tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
    ])
  }

  func configTableViewProtocols(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
    tableView.delegate = delegate
    tableView.dataSource = dataSource
    tableView.reloadData()
  }
}
