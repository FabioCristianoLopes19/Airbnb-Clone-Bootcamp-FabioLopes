//
//  DestinationTableViewCell.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 28/08/24.
//

import UIKit

class DestinationTableViewCell: UITableViewCell {

  static let identifier: String = String(describing: DestinationTableViewCell.self)
  var images: [String] = []
  var id: Int = 0
  var isFavorite: Bool = false

  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    layout.minimumLineSpacing = 0
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.showsHorizontalScrollIndicator = false
    collectionView.backgroundColor = .lightGray
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.layer.cornerRadius = 8
    collectionView.isPagingEnabled = true
    collectionView.register(CategoryImageCollectionViewCell.self, forCellWithReuseIdentifier: CategoryImageCollectionViewCell.identifier)
    return collectionView
  }()

  lazy var pageControl: UIPageControl = {
   let pageControl = UIPageControl()
    pageControl.translatesAutoresizingMaskIntoConstraints = false
    pageControl.numberOfPages = 3
    pageControl.isEnabled = false
    return pageControl
  }()

  lazy var statusLabel: PaddedLabel = {
    let label = PaddedLabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .black
    label.backgroundColor = .white
    label.layer.cornerRadius = 10
    label.layer.masksToBounds = true
    label.text = "Superhost"
    label.textInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
    return label
  }()

  lazy var titleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
    label.text = "Cabana do Sol, Brasil"
    return label
  }()

  lazy var subTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.text = "Vista Deslumbrante da natureza"
    return label
  }()

  lazy var dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .gray
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.text = "3 noites - 20 de set - 23 set"
    return label
  }()

  lazy var priceLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.text = "R$ 1.850,00 por noite"
    return label
  }()

  lazy var ratingLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = .black
    label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
    label.text = "4,85"
    return label
  }()

  lazy var starImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(systemName: "star.fill")
    imageView.tintColor = .black
    return imageView
  }()

  lazy var heartButton: UIButton = {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.tintColor = .white
    button.setImage(UIImage(systemName: "heart"), for: .normal)
    button.addTarget(self, action: #selector(tappedHeartButton), for: .touchUpInside)
    return button
  }()

  @objc func tappedHeartButton() {
    isFavorite.toggle()
    heartButton.setImage(isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
    FirestoreManager.shared.toggleFavoriteProperty(id: id, completion: { _ in })
  }

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    selectionStyle = .none
    addElements()
    configConstraints()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func addElements() {
    contentView.addSubview(collectionView)
    contentView.addSubview(pageControl)
    contentView.addSubview(statusLabel)
    contentView.addSubview(titleLabel)
    contentView.addSubview(subTitleLabel)
    contentView.addSubview(dateLabel)
    contentView.addSubview(priceLabel)
    contentView.addSubview(ratingLabel)
    contentView.addSubview(starImageView)
    contentView.addSubview(heartButton)
  }

  func configConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      collectionView.heightAnchor.constraint(equalToConstant: 300),

      pageControl.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
      pageControl.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),

      statusLabel.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 12),
      statusLabel.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor, constant: 12),

      titleLabel.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 10),
      titleLabel.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),

      subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
      subTitleLabel.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),

      dateLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 5),
      dateLabel.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),

      priceLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 5),
      priceLabel.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
      priceLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),

      ratingLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
      ratingLabel.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),

      starImageView.heightAnchor.constraint(equalToConstant: 12),
      starImageView.widthAnchor.constraint(equalToConstant: 12),
      starImageView.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
      starImageView.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -4),

      heartButton.topAnchor.constraint(equalTo: collectionView.topAnchor, constant: 12),
      heartButton.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor, constant: -12),
      heartButton.heightAnchor.constraint(equalToConstant: 34),
      heartButton.widthAnchor.constraint(equalToConstant: 34),
    ])
  }

  func setupCell(data: PropertyDataModel) {
    id = data.id
    images = data.images
    titleLabel.text = data.title
    subTitleLabel.text = data.subtitle
    priceLabel.text = data.price
    ratingLabel.text = data.rating
    dateLabel.text = data.date
    pageControl.numberOfPages = data.images.count
    pageControl.isHidden = data.images.count == 1
    statusLabel.text = data.status
    statusLabel.isHidden = data.status.isEmpty
    collectionView.reloadData()

    FirestoreManager.shared.isPropertyFavorite(id: id) { [weak self] isFavorite in
      guard let self else { return }
      self.isFavorite = isFavorite
      heartButton.setImage(isFavorite ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart"), for: .normal)
    }
  }


}


extension DestinationTableViewCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return images.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryImageCollectionViewCell.identifier, for: indexPath) as? CategoryImageCollectionViewCell else { return UICollectionViewCell() }
    cell.setupCell(image: images[indexPath.row])
    return cell
  }

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
  }

  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.width)
    pageControl.currentPage = Int(pageNumber)
  }


}


















class PaddedLabel: UILabel {

  var textInsets = UIEdgeInsets.zero {
    didSet {
        invalidateIntrinsicContentSize()
    }
  }

  override func drawText(in rect: CGRect) {
    super.drawText(in: rect.inset(by: textInsets))
  }

  override var intrinsicContentSize: CGSize {
    var size = super.intrinsicContentSize
    size.height += textInsets.top + textInsets.bottom
    size.width += textInsets.left + textInsets.right
    return size
  }
}
