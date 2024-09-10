//
//  MainTabBarController.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 05/08/24.
//

import UIKit

class MainTabBarController: UITabBarController {

  override func viewDidLoad() {
    super.viewDidLoad()
    let exploreViewController = createNavController(vc: ExploreViewController(), title: "Explorar", imageName: "magnifyingglass")
    let favoriteViewController = createNavController(vc: FavoriteViewController(), title: "Favoritos", imageName: "heart")
    let travelViewController = createNavController(vc: TravelViewController(), title: "Viagens", imageName: "star")
    let messageViewController = createNavController(vc: MessageViewController(), title: "Mensagens", imageName: "message")
    let profileViewController = createNavController(vc: ProfileViewController(), title: "Perfil", imageName: "person.crop.circle")

    viewControllers = [exploreViewController, favoriteViewController, travelViewController, messageViewController, profileViewController]

    customizeTabBarAppearance()
  }

  private func createNavController(vc: UIViewController, title: String, imageName: String) -> UINavigationController {
    let navController = UINavigationController(rootViewController: vc)
    navController.tabBarItem.title = title
    navController.tabBarItem.image = UIImage(systemName: imageName)
    navController.isNavigationBarHidden = true
    return navController
  }

  private func customizeTabBarAppearance() {
    tabBar.tintColor = .red
    tabBar.unselectedItemTintColor = .lightGray
    tabBar.layer.borderWidth = 0.5
    tabBar.layer.borderColor = UIColor.lightGray.cgColor
    tabBar.backgroundColor = .white
    tabBar.isTranslucent = false
  }
}
