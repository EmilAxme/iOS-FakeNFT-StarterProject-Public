//
//  PaymentViewController.swift
//  FakeNFT
//
//  Created by Emil on 13.10.2025.
//

import UIKit

protocol PaymentViewProtocol: AnyObject {
    func reloadData()
}

final class PaymentViewController: UIViewController {
    
    var presenter: PaymentPresenterProtocol?
    
    private lazy var CoinsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 7   
        layout.minimumLineSpacing = 7
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemBackground
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(PaymentCollectionViewCell.self, forCellWithReuseIdentifier: PaymentCollectionViewCell.reuseIdentifier)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupUI()
        presenter?.viewDidLoad()
    }
    
    private func setupUI() {
        view.addSubview(CoinsCollectionView)
        
        CoinsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            CoinsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            CoinsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            CoinsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            CoinsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
        ])
    }
    
    private func setupNavigationBar() {
        title = "Выберите способ оплаты"
        navigationController?.navigationBar.prefersLargeTitles = false
        
        let backImage = UIImage(resource: .backward)
        let backButton = UIBarButtonItem(
            image: backImage,
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
}

extension PaymentViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        presenter?.currencies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PaymentCollectionViewCell.reuseIdentifier, for: indexPath) as? PaymentCollectionViewCell,
            let currency = presenter?.currencies[indexPath.item]
        else { return UICollectionViewCell() }
        
        cell.configure(with: currency)
        return cell
    }
}

extension PaymentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 2
        let spacing: CGFloat = 7
        let totalInterItemSpacing = spacing * (columns - 1)
        let cellWidth = (collectionView.bounds.width - totalInterItemSpacing) / columns
        return CGSize(width: cellWidth, height: 60)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { 7 }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat { 7 }
}

extension PaymentViewController: PaymentViewProtocol {
    func reloadData() {
        CoinsCollectionView.reloadData()
    }
}
