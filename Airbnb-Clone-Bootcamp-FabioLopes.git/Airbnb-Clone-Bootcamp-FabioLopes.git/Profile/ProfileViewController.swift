//
//  ProfileViewController.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 05/08/24.
//

import Foundation
import UIKit

class ProfileViewController: UIViewController {

  var screen: ProfileScreen?

  override func loadView() {
    screen = ProfileScreen()
    view = screen
  }

  override func viewDidLoad() {
    super.viewDidLoad()

  }

}

