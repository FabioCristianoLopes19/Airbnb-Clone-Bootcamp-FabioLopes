//
//  FavoriteViewController.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 05/08/24.
//

import Foundation
import UIKit

class FavoriteViewController: UIViewController {

  var screen: FavoriteScreen?
  var viewModel: FavoriteViewModel = FavoriteViewModel()

  override func loadView() {
    screen = FavoriteScreen()
    view = screen
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    screen?.configTableViewProtocols(delegate: self, dataSource: self)
    viewModel.delegate(delegate: self)
    viewModel.fetchFavorites()
  }
}

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsInSection
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: DestinationTableViewCell.identifier, for: indexPath) as? DestinationTableViewCell
    cell?.setupCell(data: viewModel.loadCurrentFavorite(at: indexPath))
    return cell ?? UITableViewCell()
  }
}

extension FavoriteViewController: FavoriteViewModelProtocol {
  func updateListFavorites() {
    screen?.tableView.reloadData()
  }
}
