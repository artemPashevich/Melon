//
//  Product.swift
//  Melon
//
//  Created by Артем Пашевич on 2.10.22.


import Foundation
import Firebase
import FirebaseStorage

class Product {
    
    let name: String
    let price: String
    let ref: DatabaseReference?
    let photoUuidArr: [String: Any] // photoUuidArr
    let userId: String
    let describtion: String

    init(name: String, price: String, photo: [String: Any], userId: String, describtion: String) {
        self.name = name
        self.price = price
        self.ref = nil
        self.photoUuidArr = photo
        self.userId = userId
        self.describtion = describtion
    }

    init?(snapshot: DataSnapshot) {
        guard let snapshotValue = snapshot.value as? [String: Any],
              let name = snapshotValue[ConstantsProduct.nameKey] as? String,
              let userId = snapshotValue[ConstantsProduct.userIdKey] as? String,
              let price = snapshotValue[ConstantsProduct.priceKey] as? String,
              let photo = snapshotValue[ConstantsProduct.photoKey] as? [String: Any],
              let describtion = snapshotValue[ConstantsProduct.describtionKey] as? String else { return nil }

        self.name = name
        self.price = price
        self.photoUuidArr = photo
        self.userId = userId
        self.describtion = describtion
        ref = snapshot.ref
    }

    func convertToDictionary() -> [String: Any] {
        [ConstantsProduct.nameKey: name, ConstantsProduct.userIdKey: userId, ConstantsProduct.priceKey: price, ConstantsProduct.photoKey: photoUuidArr, ConstantsProduct.describtionKey: describtion]
    }

    private enum ConstantsProduct {
        static let nameKey = "name"
        static let userIdKey = "userId"
        static let priceKey = "price"
        static let photoKey = "photo"
        static let describtionKey = "describtion"
    }

}
