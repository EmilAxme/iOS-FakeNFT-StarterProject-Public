//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Emil on 08.10.2025.
//

import UIKit

protocol CartViewProtocol: AnyObject {
    func reloadData()
    func updateSummary(countText: String, totalText: String)
    func showSortOptions()
    func showEmptyCart()
    func hideEmptyCart()
}

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
        button.addTarget(self, action: #selector(inPayButtonTapped), for: .touchUpInside)
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
    
    private lazy var stubLabel: UILabel = {
        let label = UILabel()
        label.text = "Корзина пуста"
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
        setupNavigationBar()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.addSubview(nftCollectionView)
        view.addSubview(paymentZoneStackView)
        view.addSubview(stubLabel)
        nftCollectionView.translatesAutoresizingMaskIntoConstraints = false
        paymentZoneStackView.translatesAutoresizingMaskIntoConstraints = false
        stubLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stubLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stubLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            inPayButton.heightAnchor.constraint(equalToConstant: 44),

            paymentZoneStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            paymentZoneStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            paymentZoneStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            nftCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            nftCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            nftCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nftCollectionView.bottomAnchor.constraint(equalTo: paymentZoneStackView.topAnchor, constant: -20)
        ])
    }
    
    private func setupNavigationBar() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.prefersLargeTitles = false

        let sortImage = UIImage(resource: .sort)
        let sortButton = UIBarButtonItem(
            image: sortImage,
            style: .plain,
            target: self,
            action: #selector(sortButtonTapped)
        )
        navigationItem.rightBarButtonItem = sortButton
    }
    
    private func showDeleteDialog(for nft: NFTMock) {
        let alertVC = DeleteNFTAlertViewController()
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        alertVC.nftImage = nft.image
        alertVC.onDelete = { [weak self] in
            self?.presenter?.deleteNFT(nft)
        }
        present(alertVC, animated: true)
    }
    
    func showSortOptions() {
        let alert = UIAlertController(title: "Сортировка", message: nil, preferredStyle: .actionSheet)
        
        let priceAction = UIAlertAction(title: "По цене", style: .default) { [weak self] _ in
            self?.presenter?.didSelectSortOption(.price)
        }
        
        let ratingAction = UIAlertAction(title: "По рейтингу", style: .default) { [weak self] _ in
            self?.presenter?.didSelectSortOption(.rating)
        }
        
        let nameAction = UIAlertAction(title: "По названию", style: .default) { [weak self] _ in
            self?.presenter?.didSelectSortOption(.name)
        }
        
        let cancelAction = UIAlertAction(title: "Закрыть", style: .cancel)
        
        [priceAction, ratingAction, nameAction, cancelAction].forEach { alert.addAction($0) }
        present(alert, animated: true)
    }
    
    @objc private func inPayButtonTapped() {
        presenter?.didTapPayButton()
    }
    
    @objc private func sortButtonTapped() {
        presenter?.didTapSortButton()
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
        
        cell.onDeleteTapped = { [weak self] in
            guard let self else { return }
            if let nft = self.presenter?.nfts[indexPath.item] {
                self.showDeleteDialog(for: nft)
            }
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
    func showEmptyCart() {
        nftCollectionView.isHidden = true
        paymentZoneStackView.isHidden = true
        stubLabel.isHidden = false
    }

    func hideEmptyCart() {
        nftCollectionView.isHidden = false
        paymentZoneStackView.isHidden = false
        stubLabel.isHidden = true
    }
    
    func reloadData() {
        nftCollectionView.reloadData()
    }
    
    func updateSummary(countText: String, totalText: String) {
        nftCountLabel.text = countText
        totalPriceLabel.text = totalText
    }
}
