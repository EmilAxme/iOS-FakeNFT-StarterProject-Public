//
//  DeleteNFTAlertViewController.swift
//  FakeNFT
//
//  Created by Emil on 14.10.2025.
//

import UIKit

final class DeleteNFTAlertViewController: UIViewController {
    
    private enum Strings {
        static let deleteConfirmation = "Delete.confirmation".localized
        static let delete = "Delete.deleteButton".localized
        static let cancel = "Delete.cancelButton".localized
    }
    
    var nftImageURL: String?
    var onDelete: (() -> Void)?
    
    private lazy var blurView: UIVisualEffectView = {
        let blur = UIBlurEffect(style: .light) //
        let view = UIVisualEffectView(effect: blur)
        view.alpha = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.cornerRadius = 20
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.deleteConfirmation
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 13, weight: .medium)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.delete, for: .normal)
        button.setTitleColor(UIColor(resource: .deleteLabel), for: .normal)
        button.backgroundColor = .label
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.addTarget(self, action: #selector(deleteTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(Strings.cancel, for: .normal)
        button.backgroundColor = .label
        button.setTitleColor(.systemBackground, for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.addTarget(self, action: #selector(cancelTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [deleteButton, cancelButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        if let urlString = nftImageURL, let url = URL(string: urlString) {
            imageView.kf.setImage(with: url, placeholder: UIImage(resource: .nft1))
        }
        animateIn()
    }
    
    private func setupUI() {
        view.addSubview(blurView)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: view.topAnchor),
            blurView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        view.addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(messageLabel)
        containerView.addSubview(buttonsStackView)
        
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -view.bounds.height * 0.1),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 56),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -56),
            
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 108),
            imageView.heightAnchor.constraint(equalToConstant: 108),
            
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 41),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -41),
            
            buttonsStackView.topAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 20),
            buttonsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            buttonsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            buttonsStackView.heightAnchor.constraint(equalToConstant: 44),
            buttonsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor)
        ])
    }
    
    @objc private func deleteTapped() {
        dismiss(animated: true) {
            self.onDelete?()
        }
    }
    
    @objc private func cancelTapped() {
        dismiss(animated: true)
    }
    
    private func animateIn() {
        containerView.alpha = 0
        containerView.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        UIView.animate(withDuration: 0.25) {
            self.containerView.alpha = 1
            self.containerView.transform = .identity
        }
    }
}
