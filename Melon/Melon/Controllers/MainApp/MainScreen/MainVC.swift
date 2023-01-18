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

//    private var user: User!
    var indexPathRow: Int?
    private var ref_product: DatabaseReference!
    private var products = [Product]()
    @IBOutlet weak var productCollection: MainCollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

//        guard let currentUser = Auth.auth().currentUser else { return }
//        user = User(user: currentUser)

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
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//          guard segue.identifier == "ditail" else { return }
//          guard let destination = segue.destination as? DetailScreen else { return }
//          destination.indexPathRow = indexPathRow
//        print(indexPathRow as Any)
//      }
    
    func passData() {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let secondViewController = storyboard.instantiateViewController(identifier: "DetailScreen") as? DetailScreen else { return }
            secondViewController.indexPathRow = indexPathRow
            
            present(secondViewController, animated: true) 
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        indexPathRow = indexPath.row
        passData()
    }
    
}
