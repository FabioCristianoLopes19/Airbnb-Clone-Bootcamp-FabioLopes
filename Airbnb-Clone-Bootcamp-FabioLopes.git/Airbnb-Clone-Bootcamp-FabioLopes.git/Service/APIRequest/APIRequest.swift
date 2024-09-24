//
//  APIRequest.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 24/09/24.
//

import Foundation

struct APIRequest {
  let url: String
  let method: HTTPMethod
  let headers: [String: String]?
  let parameters: Parameters?

  init(url: String, method: HTTPMethod = .get, headers: [String : String]? = nil, parameters: Parameters? = nil) {
    self.url = url
    self.method = method
    self.headers = headers
    self.parameters = parameters
  }
}
