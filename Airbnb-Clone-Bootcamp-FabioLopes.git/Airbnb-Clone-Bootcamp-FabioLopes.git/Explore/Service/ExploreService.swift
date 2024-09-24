//
//  ExploreService.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 24/09/24.
//

import Foundation

class ExploreService {

  static func fetchCategoryList(completion: @escaping (Result<[TravelCategory], NetworkError>) -> Void) {
    let request = APIRequest(url: "https://run.mocky.io/v3/6aa6d605-9606-4b59-ae34-e48a8c912fc5")

    // Nesse caso podemos fazer de 2 formas

    // 1 -> mais simples o entendimento, porem retornando o mesmo que o outro completion
    //    APIClient.shared.request(request: request, decodeType: [TravelCategory].self) { result in
    //      switch result {
    //      case .success(let success):
    //        completion(.success(success))
    //      case .failure(let failure):
    //        completion(.failure(failure))
    //      }
    //    }

    // 2 -> bem mais difícil o entendimento, porem economizando bastante linhas desnecessárias!
    APIClient.shared.request(request: request, decodeType: [TravelCategory].self, completion: completion)
  }

  static func fetchPropertyDataModelList(completion: @escaping (Result<[PropertyDataModel], NetworkError>) -> Void) {
    let request = APIRequest(url: "https://run.mocky.io/v3/159cab80-eb7e-4596-8793-fc75e1baa445")
    APIClient.shared.request(request: request, decodeType: [PropertyDataModel].self, completion: completion)
  }
}

