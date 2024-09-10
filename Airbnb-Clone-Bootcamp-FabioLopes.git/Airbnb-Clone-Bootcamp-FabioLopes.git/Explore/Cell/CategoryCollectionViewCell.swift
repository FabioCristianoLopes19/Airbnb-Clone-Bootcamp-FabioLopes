//
//  CategoryCollectionViewCell.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 26/08/24.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell {

  static let identifier: String = String(describing: CategoryCollectionViewCell.self)
  static let height: CGFloat = 60
  static let titleFont = UIFont.systemFont(ofSize: 12, weight: .bold)

  lazy var categoryImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.image = UIImage(systemName: "trash")
    return imageView
  }()

  lazy var categoryLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .lightGray
    label.font = CategoryCollectionViewCell.titleFont
    label.textAlignment = .center
    label.text = "Teste"
    return label
  }()

  lazy var lineView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .black
    return view
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
    contentView.addSubview(categoryImageView)
    contentView.addSubview(categoryLabel)
    contentView.addSubview(lineView)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      categoryImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      categoryImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      categoryImageView.heightAnchor.constraint(equalToConstant: 24),
      categoryImageView.widthAnchor.constraint(equalToConstant: 24),

      categoryLabel.topAnchor.constraint(equalTo: categoryImageView.bottomAnchor, constant: 4),
      categoryLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      categoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),

      lineView.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
      lineView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      lineView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      lineView.heightAnchor.constraint(equalToConstant: 2),
      lineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }

  static func calculateSize(title: String) -> CGSize {
    let maxSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)
    let boundingBox = (title as NSString).boundingRect(with: maxSize, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: titleFont], context: nil)
    return CGSize(width: boundingBox.width + 20, height: height)
  }

  func setupCell(travelCategory: TravelCategory) {
    categoryImageView.image = UIImage(systemName: travelCategory.image)
    categoryImageView.tintColor = travelCategory.isSelected ? .black : .lightGray

    categoryLabel.text = travelCategory.category
    categoryLabel.textColor = travelCategory.isSelected ? .black : .lightGray

    lineView.isHidden = !travelCategory.isSelected
  }
}

