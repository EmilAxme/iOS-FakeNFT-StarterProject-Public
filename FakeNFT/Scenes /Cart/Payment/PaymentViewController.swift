//
//  PaymentViewController.swift
//  FakeNFT
//
//  Created by Emil on 13.10.2025.
//

import UIKit

protocol PaymentViewProtocol: AnyObject {
    func reloadData()
    func showPaymentErrorAlert()
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
    
    private lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.text = "Совершая покупку, вы соглашаетесь с условиями"
        label.font = .systemFont(ofSize: 13)
        label.textAlignment = .left
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var agreementButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Пользовательского соглашения", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        button.tintColor = .systemBlue
        return button
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Оплатить", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.setTitleColor(UIColor(resource: .whiteYP), for: .normal)
        button.addTarget(self, action: #selector(payButtonTapped), for: .touchUpInside)
        button.backgroundColor = .label
        button.layer.cornerRadius = 16
        return button
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [termsLabel, agreementButton])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 0
        return stack
    }()
    
    private lazy var bottomStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [labelsStackView, payButton])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .leading
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: 16, left: 16, bottom: 24, right: 16)
        stack.backgroundColor = .secondarySystemBackground
        return stack
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
        view.addSubview(bottomStackView)
        
        CoinsCollectionView.translatesAutoresizingMaskIntoConstraints = false
        bottomStackView.translatesAutoresizingMaskIntoConstraints = false
        payButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            CoinsCollectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            CoinsCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            CoinsCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            CoinsCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            
            payButton.widthAnchor.constraint(equalTo: bottomStackView.widthAnchor, constant: -32),
            payButton.heightAnchor.constraint(equalToConstant: 56),
            
            bottomStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
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
    
    @objc private func payButtonTapped() {
        presenter?.didTapPayButton()
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
    
    //показывается при первом нажатии на кнопку оплаты
    func showPaymentErrorAlert() {
        let alert = UIAlertController(
            title: "Упс",
            message: "Не удалось произвести оплату",
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel)
        let retryAction = UIAlertAction(title: "Повторить", style: .default) { [weak self] _ in
            self?.presenter?.didTapPayButton()
        }
        
        alert.addAction(cancelAction)
        alert.addAction(retryAction)
        present(alert, animated: true)
    }
}
