//
//  photoGallery.swift
//  Melon
//
//  Created by Артем Пашевич on 2.10.22.
//

import UIKit

class PhotoGallery: UICollectionView {

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        super.init(frame: .zero, collectionViewLayout: layout)
        backgroundColor = #colorLiteral(red: 0.949019134, green: 0.9490200877, blue: 0.9705254436, alpha: 1)
        showsHorizontalScrollIndicator = false
        translatesAutoresizingMaskIntoConstraints = false
        layout.minimumLineSpacing = 18
        contentInset = UIEdgeInsets(top: 10, left: 19, bottom: 10, right: 19)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}


