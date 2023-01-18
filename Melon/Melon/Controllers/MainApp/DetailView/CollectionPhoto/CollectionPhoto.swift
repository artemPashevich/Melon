//
//  CollectionPhoto.swift
//  Melon
//
//  Created by Артем Пашевич on 18.01.23.
//

import UIKit

class CollectionPhoto: UICollectionView {

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = 18
        contentInset = UIEdgeInsets(top: 10, left: 19, bottom: 10, right: 19)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
