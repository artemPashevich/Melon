//
//  DetailScreen.swift
//  Melon
//
//  Created by Артем Пашевич on 31.12.22.
//

import UIKit
import Firebase
import FirebaseStorage

class DetailScreen: UIViewController, UISheetPresentationControllerDelegate {
    
    private var ref_product: DatabaseReference!
    var indexPathRow: Int?
    private var products = [Product]()
    private var photos = [Any]()
    
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var priceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    override var sheetPresentationController: UISheetPresentationController {
        presentationController as! UISheetPresentationController
    }
    
    private var galleryCollection = CollectionPhoto()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref_product = Database.database().reference(withPath: "Products")
        observeDataBase()
        
        sheetPresentationController.delegate = self
        sheetPresentationController.selectedDetentIdentifier = .medium
        sheetPresentationController.prefersGrabberVisible = true
        sheetPresentationController.detents = [.medium()]
        constrainsViewCollection()
    }
    
    
    
    private func constrainsViewCollection() {
        galleryCollection.delegate = self
        galleryCollection.dataSource = self
        galleryCollection.register(CollectionPhotoCell.self, forCellWithReuseIdentifier: CollectionPhotoCell.reuseId)
        
        view.addSubview(nameLabel)
        nameLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27).isActive = true
        nameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        view.addSubview(galleryCollection)
        galleryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollection.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16).isActive = true
        galleryCollection.heightAnchor.constraint(equalToConstant: 220).isActive = true
        
        view.addSubview(descriptionLabel)
        descriptionLabel.topAnchor.constraint(equalTo: galleryCollection.bottomAnchor, constant: 16).isActive = true
//        descriptionLabel.heightAnchor.constraint(equalToConstant: 60).isActive = true
        descriptionLabel.widthAnchor.constraint(equalToConstant: 334).isActive = true
        descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        
        view.addSubview(priceLabel)
        priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 16).isActive = true
        priceLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
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
            self?.nameLabel.text = products[(self?.indexPathRow!)!].name
            self?.descriptionLabel.text = products[(self?.indexPathRow!)!].describtion
            self?.priceLabel.text = "$\(products[(self?.indexPathRow!)!].price) per day"
            self?.photos = Array(products[(self?.indexPathRow!)!].photoUuidArr.values)
//            self?.productCollection.reloadData()
        }
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension DetailScreen: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = galleryCollection.dequeueReusableCell(withReuseIdentifier: CollectionPhotoCell.reuseId, for: indexPath) as! CollectionPhotoCell
        Request.shared.downloadImageWithCache(urlString: photos[indexPath.row] as! String) { image in
            cell.imageView.image = image
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 206, height: 206)
    }
}
