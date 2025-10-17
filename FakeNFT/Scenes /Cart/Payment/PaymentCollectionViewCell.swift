//
//  PaymentCollectionViewCell.swift
//  FakeNFT
//
//  Created by Emil on 13.10.2025.
//

import UIKit

final class PaymentCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "PaymentCollectionViewCell"
    
    private let iconImageView = UIImageView()
    private let nameLabel = UILabel()
    private let tickerLabel = UILabel()
    
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
        
        iconImageView.contentMode = .scaleAspectFit
        iconImageView.layer.cornerRadius = 8
        iconImageView.clipsToBounds = true
        
        nameLabel.font = .systemFont(ofSize: 15, weight: .semibold)
        tickerLabel.font = .systemFont(ofSize: 13, weight: .medium)
        tickerLabel.textColor = UIColor(resource: .greenYP)
        
        let labelsStack = UIStackView(arrangedSubviews: [nameLabel, tickerLabel])
        labelsStack.axis = .vertical
        labelsStack.spacing = 2
        
        let mainStack = UIStackView(arrangedSubviews: [iconImageView, labelsStack])
        mainStack.axis = .horizontal
        mainStack.alignment = .center
        mainStack.spacing = 12
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(mainStack)
        
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconImageView.widthAnchor.constraint(equalToConstant: 40),
            iconImageView.heightAnchor.constraint(equalToConstant: 40),
            
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    func configure(with model: CurrencyModel) {
        iconImageView.image = model.icon
        nameLabel.text = model.name
        tickerLabel.text = model.ticker
    }
}
