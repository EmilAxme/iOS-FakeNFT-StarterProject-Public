//
//  PaymentCollectionViewCell.swift
//  FakeNFT
//
//  Created by Emil on 13.10.2025.
//

import UIKit
import Kingfisher

final class PaymentCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PaymentCollectionViewCell"
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        return label
    }()
    
    private lazy var tickerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.textColor = UIColor(resource: .greenYP)
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let labelsStack = UIStackView(arrangedSubviews: [nameLabel, tickerLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 2
        return labelsStack
    }()
    
    private lazy var mainStackView: UIStackView = {
        let mainStack = UIStackView(arrangedSubviews: [iconImageView, labelsStackView])
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.spacing = 12
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        return mainStack
    }()
    
    override var isSelected: Bool {
        didSet {
            contentView.layer.borderColor = isSelected ? UIColor.black.cgColor : UIColor.clear.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.clear.cgColor
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStackView)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with model: CurrencyModel) {
        nameLabel.text = model.title
        tickerLabel.text = model.name
        
        if let url = URL(string: model.image) {
            iconImageView.kf.setImage(with: url, placeholder: UIImage(resource: .nft1))
        } else {
            iconImageView.image = UIImage(resource: .nft1)
        }
    }
}
