//
//  Image.swift
//  Melon
//
//  Created by Артем Пашевич on 13.10.22.
//

import UIKit

struct Photo {
    let uuid = NSUUID().uuidString
    let image: UIImage?
    let defaultImage = #imageLiteral(resourceName: "addPhoto")
}
