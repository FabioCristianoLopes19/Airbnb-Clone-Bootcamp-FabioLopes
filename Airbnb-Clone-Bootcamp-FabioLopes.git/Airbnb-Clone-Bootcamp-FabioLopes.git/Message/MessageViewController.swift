//
//  MessageViewController.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 05/08/24.
//

import Foundation
import UIKit

class MessageViewController: UIViewController {

  var screen: MessageScreen?

  override func loadView() {
    screen = MessageScreen()
    view = screen
  }

  override func viewDidLoad() {
    super.viewDidLoad()

  }

}
