//
//  CategoryImageCollectionViewCell.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 28/08/24.
//

import UIKit

class CategoryImageCollectionViewCell: UICollectionViewCell {

  static let identifier: String = String(describing: CategoryImageCollectionViewCell.self)

  lazy var imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleToFill
    return imageView
  }()

  override init(frame: CGRect) {
    super.init(frame: frame)
    addElements()
    configConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func addElements() {
    contentView.addSubview(imageView)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
    ])
  }

  func setupCell(image: String) {
    imageView.image = UIImage(named: image)
  }
}

