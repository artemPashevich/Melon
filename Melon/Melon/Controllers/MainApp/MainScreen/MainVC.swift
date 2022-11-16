//
//  MainVC.swift
//  Melon
//
//  Created by Артем Пашевич on 31.10.22.
//

import UIKit
import Firebase
import FirebaseStorage

class MainVC: UIViewController {

    private var user: User!
    private var ref_product: DatabaseReference!
    private var products = [Product]()
    @IBOutlet weak var productCollection: MainCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)

        ref_product = Database.database().reference(withPath: "Products")
        
        observeDataBase()
    }

    private func observeDataBase() {
        ref_product.observe(.value) { [weak self] snapshot in
            var products = [Product]()
            for item in snapshot.children {
                guard let snapshot = item as? DataSnapshot,
                      let product = Product(snapshot: snapshot) else { continue }
                products.append(product)
            }
            self?.products = products
            self?.productCollection.reloadData()
        }
    }
    
}

extension MainVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ProductCVCell
        
        cell.nameProduct.text = products[indexPath.row].name
        cell.product = products[indexPath.row]
        cell.descriptionProduct.text = products[indexPath.row].describtion
        cell.layer.cornerRadius = 10
        cell.dwnImage()
        cell.priceProduct.text = "$\(products[indexPath.row].price)"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 361, height: 136)
    }
    
}
