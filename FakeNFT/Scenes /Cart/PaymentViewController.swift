//
//  PaymentViewController.swift
//  FakeNFT
//
//  Created by Emil on 13.10.2025.
//

import UIKit

final class PaymentViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
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
