//
//  PaymentSuccess .swift
//  FakeNFT
//
//  Created by Emil on 14.10.2025.
//

import UIKit

final class PaymentSuccessViewController: UIViewController {
    
    private enum Strings {
        static let successMessage = "PaymentSuccess.message".localized
        static let backButtonTitle = "PaymentSuccess.backButton".localized
    }
    
    private lazy var successImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(resource: .successNFT))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var successLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.successMessage
        label.font = .systemFont(ofSize: 22, weight: .bold)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }()
    
    private lazy var successStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [successImageView, successLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 20
        return stackView
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.backButtonTitle, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.cornerRadius = 16
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setupUI() {
        view.addSubview(successStackView)
        view.addSubview(backButton)
        
        successStackView.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            successStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            successStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -40),
            successStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            successStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            successImageView.heightAnchor.constraint(equalToConstant: 220),
            
            backButton.heightAnchor.constraint(equalToConstant: 60),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            backButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
    }
}
