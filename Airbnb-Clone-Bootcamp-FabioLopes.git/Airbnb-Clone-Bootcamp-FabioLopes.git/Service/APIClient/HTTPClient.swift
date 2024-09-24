//
//  HTTPClient.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 24/09/24.
//

import Foundation

protocol HTTPClient {
  // Forma generica
  func request<T: Decodable>(request: APIRequest, decodeType: T.Type, completion: @escaping (Result<T, NetworkError>) -> Void)

  // Tipagem fixa
  // func request(request: APIRequest, decodeType: User.self, completion: @escaping (Result<User, NetworkError>) -> Void)
}
