//
//  ProductCVCell.swift
//  Melon
//
//  Created by Артем Пашевич on 6.10.22.
//

import UIKit
import FirebaseStorage
import Firebase

class ProductCVCell: UICollectionViewCell {

    @IBOutlet weak var nameProduct: UILabel!
    @IBOutlet weak var imageProduct: UIImageView!
    @IBOutlet weak var descriptionProduct: UILabel!
    @IBOutlet weak var priceProduct: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addCartBtn: UIButton!
    
    
    private var ref_cart: DatabaseReference!
    var product: Product?
    
    @IBAction func addCart() {
        let currentUser = Auth.auth().currentUser
        let user = User(user: currentUser!)
        ref_cart = Database.database().reference(withPath: "Users").child(user.uid).child("Cart").child(nameProduct.text!)
        ref_cart.setValue(product!.convertToDictionary())
    }
    
    func dwnImage() {
        activityIndicator.startAnimating()
        Request.shared.downloadImageWithCache(urlString: product!.photoUuidArr.values.first as! String) { image in
            self.imageProduct.image = image
            self.activityIndicator.stopAnimating()
        }
    }
}
