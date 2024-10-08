//
//  FavoriteViewModel.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 07/10/24.
//

import FirebaseFirestore

protocol FavoriteViewModelProtocol: AnyObject {
  func updateListFavorites()
}

class FavoriteViewModel {
  private weak var delegate: FavoriteViewModelProtocol?
  private var userListener: ListenerRegistration?
  private var listFavorites: [PropertyDataModel] = []

  public func delegate(delegate: FavoriteViewModelProtocol?) {
    self.delegate = delegate
  }

  func fetchFavorites() {
    userListener = FirestoreManager.shared.listenToFavoriteProprieties { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let favorites):
        listFavorites = favorites
        delegate?.updateListFavorites()
      case .failure:
        break
      }
    }
  }

  var numberOfRowsInSection: Int {
    return listFavorites.count
  }

  func loadCurrentFavorite(at indexPath: IndexPath) -> PropertyDataModel {
    return listFavorites[indexPath.row]
  }

  func removeListener() {
    userListener?.remove()
  }
}

