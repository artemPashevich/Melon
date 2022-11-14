//
//  CartCVCell.swift
//  Melon
//
//  Created by Артем Пашевич on 25.10.22.
//

import UIKit
import PassKit

class CartCVCell: UICollectionViewCell {
        
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var payBtn: UIButton!
    @IBOutlet weak var descriptionProduct: UILabel!
    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    @IBOutlet weak var imageProduct: UIImageView!
    var productInCart: Product?
    
    
    @IBAction func payAction(_ sender: Any) {
        
    }
    
    func designButton() {
        payBtn.layer.cornerRadius = 18
    }
    
    func allParameters() {
        priceProduct.text = productInCart?.price
        descriptionProduct.text = productInCart?.describtion
        nameProduct.text = productInCart?.name
    }
    
    func dwnImage() {
        indicator.startAnimating()
        Request.shared.downloadImageWithCache(urlString: productInCart!.photoUuidArr.values.first as! String) { image in
            self.imageProduct.image = image
            self.indicator.stopAnimating()
        }
    }
    
}
