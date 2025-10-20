//
//  NFTCollectionViewCell.swift
//  FakeNFT
//
//  Created by Emil on 09.10.2025.
//

import UIKit

final class NFTCollectionViewCell: UICollectionViewCell {
    
    private enum Strings {
        static let pricePrefix = "NFT.pricePrefix".localized
        static let currencyFormat = "NFT.currencyFormat".localized
    }
    
    static let reuseIdentifier = "NFTCollectionViewCell"
    
    var onDeleteTapped: (() -> Void)?
    
    private lazy var nftImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var nftNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.pricePrefix
        label.font = .systemFont(ofSize: 13, weight: .medium)
        return label
    }()
    
    private lazy var nftPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        return label
    }()
    
    private lazy var starsStackView: UIStackView = {
         let stackView = UIStackView()
         stackView.axis = .horizontal
         stackView.spacing = 2
         stackView.distribution = .fillEqually
         return stackView
     }()
    
    private lazy var delButton: UIButton = {
        let button = UIButton(type: .system)
        let buttonImage = UIImage(resource: .basket)
        button.setImage(buttonImage, for: .normal)
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nftNameLabel, starsStackView])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var priceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [priceLabel, nftPriceLabel])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var labelsAndPriceStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [labelsStackView, priceStackView])
        stackView.axis = .vertical
        stackView.spacing = 12
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        [nftImageView, labelsAndPriceStackView, delButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            nftImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            nftImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            nftImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            nftImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            delButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            delButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            delButton.widthAnchor.constraint(equalToConstant: 40),
            delButton.heightAnchor.constraint(equalToConstant: 40),
            
            labelsAndPriceStackView.leadingAnchor.constraint(equalTo: nftImageView.trailingAnchor, constant: 20),
            labelsAndPriceStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            labelsAndPriceStackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func configure(with nft: NFTMock) {
        nftImageView.image = nft.image
        nftNameLabel.text = nft.name
        nftPriceLabel.text = String(format: Strings.currencyFormat, nft.price)
        updateStars(rating: nft.rating)
    }
    
    private func updateStars(rating: Int) {
        starsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let totalStars = 5
        for index in 0..<totalStars {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = index < rating
            ? UIImage(resource: .starsActive)
            : UIImage(resource: .starsInActive)
            imageView.tintColor = .systemYellow
            starsStackView.addArrangedSubview(imageView)
        }
    }
    
    @objc private func deleteButtonTapped() {
        onDeleteTapped?()
    }
}
