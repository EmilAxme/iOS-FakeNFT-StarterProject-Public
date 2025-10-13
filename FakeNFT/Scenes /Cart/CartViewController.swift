//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Emil on 08.10.2025.
//

import UIKit

final class CartViewController: UIViewController {
    
    enum Constants {
        static let inPayLabel = "In Pay"
    }
    
    var presenter: CartPresenterProtocol?
    
    private lazy var nftCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.sectionInset = .zero
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(NFTCollectionViewCell.self, forCellWithReuseIdentifier: NFTCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    private lazy var sortButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(resource: .sort), for: .normal)
        button.tintColor = .label
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var nftCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        return label
    }()
    
    private lazy var totalPriceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor(resource: .greenYP)
        return label
    }()
    
    private lazy var inPayButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("К оплате", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.backgroundColor = .label
        button.tintColor = .systemBackground
        button.layer.cornerRadius = 12
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 24, bottom: 10, right: 24)
        return button
    }()
    
    private lazy var paymentZoneLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [nftCountLabel, totalPriceLabel])
        stackView.axis = .vertical
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var paymentZoneStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [paymentZoneLabelsStackView, inPayButton])
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 24
        stackView.backgroundColor = UIColor.secondarySystemBackground
        stackView.layer.cornerRadius = 16
        stackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.addSubview(nftCollectionView)
        view.addSubview(sortButton)
        view.addSubview(paymentZoneStackView)
        nftCollectionView.translatesAutoresizingMaskIntoConstraints = false
        sortButton.translatesAutoresizingMaskIntoConstraints = false
        paymentZoneStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            sortButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 2),
            sortButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -9),
            sortButton.heightAnchor.constraint(equalToConstant: 42),
            sortButton.widthAnchor.constraint(equalToConstant: 42),
            
            inPayButton.heightAnchor.constraint(equalToConstant: 44),
            
            paymentZoneStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            paymentZoneStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paymentZoneStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                        
            nftCollectionView.topAnchor.constraint(equalTo: sortButton.bottomAnchor, constant: 20),
            nftCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nftCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nftCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension CartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.nfts.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NFTCollectionViewCell.reuseIdentifier, for: indexPath) as? NFTCollectionViewCell,
            let nft = presenter?.nfts[indexPath.item]
        else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: nft)
        return cell
    }
}

extension CartViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        return CGSize(width: width, height: 140)
    }
}

extension CartViewController: CartViewProtocol {
    func reloadData() {
        nftCollectionView.reloadData()
    }
    
    func updateSummary(countText: String, totalText: String) {
        nftCountLabel.text = countText
        totalPriceLabel.text = totalText
    }
}
