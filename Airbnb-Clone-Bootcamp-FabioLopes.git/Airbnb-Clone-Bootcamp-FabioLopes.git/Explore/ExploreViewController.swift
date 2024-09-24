//
//  ExploreViewController.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 26/08/24.
//

import Foundation
import UIKit

class ExploreViewController: UIViewController {

  var screen: ExploreScreen?
  var viewModel = ExploreViewModel()

  override func loadView() {
    screen = ExploreScreen()
    view = screen
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel.delegate = self
    viewModel.fetchAllRequest()
  }
}

extension ExploreViewController: ExploreViewModelProtocol {
  func success() {
    screen?.configCollectionViewProtocols(delegate: self, dataSource: self)
    screen?.configTableViewProtocols(delegate: self, dataSource: self)
  }
  
  func failure(errorMessage: String) {
    print(errorMessage)
  }
}

extension ExploreViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.numberOfItems
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell
    cell?.setupCell(travelCategory: viewModel.loadCurrentTravelCategory(indexPath: indexPath))
    return cell ?? UICollectionViewCell()
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CategoryCollectionViewCell.calculateSize(title: viewModel.getCategory(indexPath: indexPath))
  }

  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    // Verificando se é o mesmo item já selecionado!
    guard viewModel.getSelectedCategoryIndex != indexPath.row else { return }
    // Se passou da validação -> é item diferente do selecionado!

    // Item antigo selecionado
    let oldIndexPath = IndexPath(row: viewModel.getSelectedCategoryIndex, section: 0)

    // Mudando o item selecionado de acordo como indexPath(posição que o usuário clicou para selecionar)
    viewModel.setSelectedCategory(indexPath: indexPath)

    // Atualizando a posição ANTIGA e ATUALIZANDO a posição que o usuário selecionou
    collectionView.reloadItems(at: [oldIndexPath, indexPath])
    collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    screen?.tableView.reloadData()
  }
}

extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.numberOfRowsPropertyData
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: DestinationTableViewCell.identifier, for: indexPath) as? DestinationTableViewCell else { return UITableViewCell() }
    cell.setupCell(data: viewModel.loadCurrentPropertyData(indexPath: indexPath))
    return cell
  }
}

