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

  override func loadView() {
    screen = FavoriteScreen()
    view = screen
  }

  override func viewDidLoad() {
    super.viewDidLoad()

  }

}

