//
//  User.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 07/10/24.
//

import Foundation

struct User: Codable {
  var id: String
  var email: String
  var name: String
  var userImage: String
  var favorite: [Int]
}
