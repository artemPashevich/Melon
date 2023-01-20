//
//  CollectionPhotoCell.swift
//  Melon
//
//  Created by Артем Пашевич on 18.01.23.
//

import UIKit

class CollectionPhotoCell: UICollectionViewCell {
    
    static let reuseId = "CollectionPhotoCell"
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        return image
    }()
    
    var activityIndicate: UIActivityIndicatorView = {
        let indicate = UIActivityIndicatorView()
        return indicate
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        addSubview(activityIndicate)
        activityIndicate.center = center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
