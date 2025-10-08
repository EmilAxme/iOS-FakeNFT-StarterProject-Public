//
//  CartViewController.swift
//  FakeNFT
//
//  Created by Emil on 08.10.2025.
//

import UIKit

final class CartViewController: UIViewController {
    
    private lazy var nftCollectionView: UICollectionView = {
        var collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
    }
}

extension CartViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
}

extension CartViewController: UICollectionViewDelegateFlowLayout {
    
}
