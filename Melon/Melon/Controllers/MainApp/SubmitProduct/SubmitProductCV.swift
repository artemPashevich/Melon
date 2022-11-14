//
//  SubmitProductCV.swift
//  Melon
//
//  Created by Артем Пашевич on 2.10.22.
//

import UIKit
import Firebase
import FirebaseStorage
import SwiftEntryKit

class SubmitProductCV: UIViewController {

    @IBOutlet weak var descriptionDownView: UIView!
    @IBOutlet weak var nameDownView: UIView!
    @IBOutlet weak var priceDownView: UIView!
    @IBOutlet weak var viewDesign: UIView!
    @IBOutlet weak var postBtn: UIButton!
    @IBOutlet weak var nameProduct: UITextField!
    @IBOutlet weak var priceProduct: UITextField!
    @IBOutlet weak var descriptionText: UITextField!
    @IBOutlet weak var addProductLbl: UILabel!
    @IBOutlet weak var nameError: UILabel!
    @IBOutlet weak var descriptionError: UILabel!
    @IBOutlet weak var priceError: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    var indexPathRow: Int?
    private var photos = [#imageLiteral(resourceName: "addPhoto"), #imageLiteral(resourceName: "addPhoto"), #imageLiteral(resourceName: "addPhoto"), #imageLiteral(resourceName: "addPhoto"), #imageLiteral(resourceName: "addPhoto")]
    private var isValidName = false { didSet { btnIsEnabled() }}
    private var isValidDescription = false { didSet { btnIsEnabled() }}
    private var isValidPrice = false { didSet { btnIsEnabled() }}
    
    private var galleryCollection = PhotoGallery()
    private var user: User!
    private var ref_product: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegateTextField()
        constrainsViewCollection()
        postBtn.isEnabled = false
        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
    }
    
    
    @IBAction func nameAction(_ sender: UITextField) {
        validColor(textField: sender, view: nameDownView, error: nameError)
        isValidName = !sender.text!.isEmpty ? true : false
    }
    
    @IBAction func describtionAction(_ sender: UITextField) {
        validColor(textField: sender, view: descriptionDownView, error: descriptionError)
        isValidDescription = !sender.text!.isEmpty ? true : false
    }
    
    @IBAction func priceAction(_ sender: UITextField) {
        validColor(textField: sender, view: priceDownView, error: priceError)
        isValidPrice = !sender.text!.isEmpty ? true : false
    }
    
    private func validColor(textField: UITextField, view: UIView, error: UILabel) {
        if !textField.text!.isEmpty {
            view.backgroundColor = #colorLiteral(red: 0.9953046441, green: 0.8822001815, blue: 0.04041770101, alpha: 1)
            error.isHidden = true
        } else {
            view.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
            error.isHidden = false
        }
    }
    
    @IBAction func addProduct(_ sender: UIButton) {
        activityIndicator.startAnimating()
        startProduct()
        uploadArrayPhotos(nameProduct: nameProduct.text!)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.activityIndicator.stopAnimating()
            self.showAlert()
        }
    }
    
    private func showAlert() {
        clearPlace()
        SwiftEntryKit.display(entry: MyPopUpView(with: DesignMainScreen.setupMessage()), using: DesignMainScreen.setupAttributes())
    }
    
    private func clearPlace() {
        nameProduct.text = ""
        priceProduct.text = ""
        descriptionText.text = ""
        photos = [#imageLiteral(resourceName: "addPhoto"), #imageLiteral(resourceName: "addPhoto"), #imageLiteral(resourceName: "addPhoto"), #imageLiteral(resourceName: "addPhoto"), #imageLiteral(resourceName: "addPhoto")]
        galleryCollection.reloadData()
    }
    
    func startProduct() {
        guard let nameProduct = nameProduct.text,
              let priceProduct = priceProduct.text,
              let describtion = descriptionText.text else { return }
        ref_product = Database.database().reference(withPath: "Products").child(nameProduct)

        let product = Product(name: nameProduct, price: priceProduct, photo: [:], userId: self.user.uid, describtion: describtion)
            self.ref_product.setValue(product.convertToDictionary())
    }
    
    private func saveToDB(url: String, nameProduct: String) {
        ref_product = Database.database().reference(withPath: "Products").child(nameProduct).child("photo")
        ref_product.childByAutoId().setValue(url)
    }
    
    private func uploadArrayPhotos(nameProduct: String) {
        for image in photos {
           if image != Photo.init(image: nil).defaultImage {
                let photo = Photo(image: image)
               Request.shared.upload(photo: photo.image!) { [weak self] result in
                     switch result {
                     case .success(let url):
                         self?.saveToDB(url: url.description, nameProduct: nameProduct)
                     case .failure(let error):
                         print(error)
                     }
                 }
            }
        }
    }
    
    private func btnIsEnabled() {
        postBtn.isEnabled = isValidName && isValidDescription && isValidPrice
    }
    
}

extension SubmitProductCV: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = galleryCollection.dequeueReusableCell(withReuseIdentifier: GalleryCVCell.reuseId, for: indexPath) as! GalleryCVCell
        cell.imageView.image = photos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presentGallary()
        indexPathRow = indexPath.row
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80, height: 80)
    }
}

extension SubmitProductCV: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        photos.replaceElement(photos[indexPathRow!], withElement: image)
        galleryCollection.reloadData()
    }
    private func presentGallary() {
        let imagePicerController = UIImagePickerController()
        imagePicerController.sourceType = .photoLibrary
        imagePicerController.allowsEditing = true
        imagePicerController.delegate = self
        present(imagePicerController, animated: true)
     }
}

extension SubmitProductCV {
    private func constrainsViewCollection() {
        galleryCollection.delegate = self
        galleryCollection.dataSource = self
        galleryCollection.register(GalleryCVCell.self, forCellWithReuseIdentifier: GalleryCVCell.reuseId)
        view.addSubview(galleryCollection)
        galleryCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        galleryCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        galleryCollection.topAnchor.constraint(equalTo: addProductLbl.bottomAnchor, constant: 15).isActive = true
        galleryCollection.heightAnchor.constraint(equalToConstant: 100).isActive = true
        viewDesign.layer.cornerRadius = 20
        postBtn.layer.cornerRadius = 25
    }
    private func delegateTextField() {
        nameProduct.delegate = self
        priceProduct.delegate = self
        descriptionText.delegate = self
    }
}

extension SubmitProductCV: UITextFieldDelegate {
     func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
