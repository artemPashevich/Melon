//
//  ShoppingCartCV.swift
//  Melon
//
//  Created by Артем Пашевич on 25.10.22.
//

import UIKit
import Firebase
import FirebaseStorage
import PassKit

class ShoppingCartCV: UIViewController {
    
    private var ref_cart: DatabaseReference!
    private var user: User!
    private var products = [Product]()
    @IBOutlet var CartProductCollection: CartProductCollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let currentUser = Auth.auth().currentUser else { return }
        user = User(user: currentUser)
        ref_cart = Database.database().reference(withPath: "Users").child(user.uid).child("Cart")
        observeCart()
    }
    
    private func observeCart() {
        ref_cart.observe(.value) { [weak self] snapshot  in
            var products = [Product]()
            for item in snapshot.children {
                guard let snapshot = item as? DataSnapshot,
                      let product = Product(snapshot: snapshot) else { continue }
                products.append(product)
            }
            self?.products = products
            self?.CartProductCollection.reloadData()
        }
    }
    
    private var paymentRequest: PKPaymentRequest = {
        let request = PKPaymentRequest()
        request.merchantIdentifier = "merchant.com.pushpendra.pay"
        request.supportedNetworks = [.masterCard, .visa, .quicPay]
        request.supportedCountries = ["US", "IN"]
        request.merchantCapabilities = .capability3DS
        request.countryCode = "IN"
        request.countryCode = "INR"
        request.paymentSummaryItems = [PKPaymentSummaryItem(label: "Test", amount: 12343)]
        
        return request
    }()
    
    @IBAction func payProduct(_ sender: Any) {
        let controller = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
        if controller != nil {
            controller!.delegate = self
            present(controller!, animated: true)
        }
    }
    
}

extension ShoppingCartCV: PKPaymentAuthorizationViewControllerDelegate {
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        controller.dismiss(animated: true)
    }

    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment) async -> PKPaymentAuthorizationResult {
        PKPaymentAuthorizationResult(status: .success, errors: nil)
    }
    
}


extension ShoppingCartCV: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = CartProductCollection.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CartCVCell
        cell.layer.cornerRadius = 10
        cell.productInCart = products[indexPath.row]
        cell.designButton()
        cell.dwnImage()
        cell.allParameters()
        return cell
    }
}
