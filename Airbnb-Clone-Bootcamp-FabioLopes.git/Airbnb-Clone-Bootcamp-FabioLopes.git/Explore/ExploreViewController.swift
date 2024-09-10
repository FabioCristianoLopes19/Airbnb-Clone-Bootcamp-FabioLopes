//
//  ExploreViewController.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 26/08/24.
//

import Foundation

protocol ExploreViewModelProtocol: AnyObject {
  func success()
  func failure(errorMessage: String)
}

class ExploreViewModel {

  weak var delegate: ExploreViewModelProtocol?

  private var properties: [PropertyDataModel] = [
    PropertyDataModel(
      id: 1,
      title: "Chalé da Bárbara, Brasil",
      subtitle: "Essa é a descrição",
      price: "R$ 1.560,00 por noite",
      rating: "4,99",
      images: ["chale1", "chale2", "chale3", "chale4", "chale5"],
      date: "5 noites -> 29 de ago - 3 de set",
      isFavorite: false,
      status: "Preferido dos hóspedes",
      category: "Chalés"
    ),
    PropertyDataModel(
      id: 2,
      title: "Cabana do Sol, Brasil",
      subtitle: "Vista deslumbrante da natureza",
      price: "R$ 1.850,00 por noite",
      rating: "4,85",
      images: ["praia1", "praia2", "praia3"],
      date: "3 noites -> 20 de set - 23 de set",
      isFavorite: true,
      status: "Superhost",
      category: "Em frente à praia"
    ),
    PropertyDataModel(
      id: 3,
      title: "Pousada Recanto, Brasil",
      subtitle: "Tranquilidade e conforto",
      price: "R$ 980,00 por noite",
      rating: "4,78",
      images: ["vista1", "vista2", "vista3"],
      date: "4 noites -> 10 de out - 14 de out",
      isFavorite: false,
      status: "Melhor custo-benefício",
      category: "Vistas incríveis"
    ),
    PropertyDataModel(
      id: 4,
      title: "Santa Marta de Portuzelo, Portugal",
      subtitle: "Construído no século 12",
      price: "R$ 2.300,00 por noite",
      rating: "4,92",
      images: ["castelo1", "castelo2", "castelo3"],
      date: "7 noites -> 1 de nov - 8 de nov",
      isFavorite: true,
      status: "Popular",
      category: "Castelos"
    ),
    PropertyDataModel(
      id: 5,
      title: "Balian Beach, Indonésia",
      subtitle: "Visualizado 10.809 vezes na semana passada",
      price: "R$ 600 por noite",
      rating: "4,88",
      images: ["alta1", "alta2", "alta3"],
      date: "6 noites -> 12 de dez - 18 de dez",
      isFavorite: false,
      status: "Novo",
      category: "Em alta"
    ),
    PropertyDataModel(
      id: 6,
      title: "Angra dos Reis, Brasil",
      subtitle: "2.000 metros quadrados",
      price: "R$ 26.016 por noite",
      rating: "4,75",
      images: ["ilha1", "ilha2", "ilha3"],
      date: "3 noites -> 20 de jan - 23 de jan",
      isFavorite: true,
      status: "Excelente localização",
      category: "Ilhas"
    ),
    PropertyDataModel(
      id: 7,
      title: "Amparo, Brasil",
      subtitle: "Perto de: Lago do Gurupiá",
      price: "R$ 449 por noite",
      rating: "4,80",
      images: ["lago1", "lago2", "lago3"],
      date: "4 noites -> 10 de fev - 14 de fev",
      isFavorite: false,
      status: "Favorito dos hóspedes",
      category: "Lago"
    ),
    PropertyDataModel(
      id: 8,
      title: "Paraty, Brasil",
      subtitle: "198 km de distância",
      price: "R$ 35.376 por noite",
      rating: "4,90",
      images: ["barco1", "barco2", "barco3"],
      date: "5 noites -> 15 de mar - 20 de mar",
      isFavorite: true,
      status: "Recomendado",
      category: "Barcos"
    ),
    PropertyDataModel(
      id: 9,
      title: "Kittilä, Finlândia",
      subtitle: "11.679 km de distância",
      price: "R$ 663 por noite",
      rating: "4,95",
      images: ["artico1", "artico2", "artico3"],
      date: "6 noites -> 5 de abr - 11 de abr",
      isFavorite: false,
      status: "Destaque",
      category: "Ártico"
    ),
    PropertyDataModel(
      id: 10,
      title: "Hella, Islândia",
      subtitle: "9.981 km de distância",
      price: "R$ 4.983 por noite",
      rating: "4,82",
      images: ["artico4", "artico5", "artico6"],
      date: "4 noites -> 15 de mai - 19 de mai",
      isFavorite: true,
      status: "Aconchegante",
      category: "Ártico"
    )
  ]

  private var categoryList: [TravelCategory] = []

  func fetchCategoryListMock() {
    ServiceMock.loadJSON(fileName: "category", type: [TravelCategory].self) { [weak self] result in
      guard let self else { return }
      switch result {
      case .success(let success):
        categoryList = success
        delegate?.success()
      case .failure(let failure):
        delegate?.failure(errorMessage: failure.localizedDescription)
      }
    }
  }

  var getSelectedCategoryIndex: Int {
    return categoryList.firstIndex(where: { $0.isSelected }) ?? 0
  }

  var numberOfItems: Int {
    return categoryList.count
  }

  func loadCurrentTravelCategory(indexPath: IndexPath) -> TravelCategory {
    return categoryList[indexPath.row]
  }

  func getCategory(indexPath: IndexPath) -> String {
    return loadCurrentTravelCategory(indexPath: indexPath).category
  }

  func setSelectedCategory(indexPath: IndexPath) {
    let selectedPosition = indexPath.row
    categoryList.indices.forEach { index in
      categoryList[index].isSelected = index == selectedPosition
    }
  }

  var numberOfRowsPropertyData: Int {
    return properties.count
  }

  func loadCurrentPropertyData(indexPath: IndexPath) -> PropertyDataModel {
    return properties[indexPath.row]
  }
}

