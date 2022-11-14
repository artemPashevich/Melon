//
//  GalleryCVCell.swift
//  Melon
//
//  Created by Артем Пашевич on 2.10.22.
//

import UIKit

class GalleryCVCell: UICollectionViewCell {
    
    static let reuseId = "GalleryCVCell"
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.layer.cornerRadius = 10
        image.layer.masksToBounds = true
        return image
    }()
    
    var plusImage: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "plus")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(imageView)
        addSubview(plusImage)
        
        imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        imageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        
        plusImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32.5).isActive = true
        plusImage.heightAnchor.constraint(equalToConstant: 15).isActive = true
        plusImage.topAnchor.constraint(equalTo: topAnchor, constant: 32.5).isActive = true
        plusImage.widthAnchor.constraint(equalToConstant: 15).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
