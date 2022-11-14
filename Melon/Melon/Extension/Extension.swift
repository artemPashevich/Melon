//
//  Extension.swift
//  Melon
//
//  Created by Артем Пашевич on 7.10.22.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

extension Array {
    @discardableResult
    mutating func replaceElement(_ oldElement: Element, withElement element: Element) -> Bool {
        if let i = firstIndex(where: { String(describing: $0) == String(describing: oldElement) }) {
            self[i] = element
            return true
        }
        return false
    }
}


extension UICollectionView {
  var visibleCurrentCellIndexPath: IndexPath? {
    for cell in self.visibleCells {
      let indexPath = self.indexPath(for: cell)
      return indexPath
    }
    
    return nil
  }
}

extension Array  {
    var indexedDictionary: [Int: Element] {
        var result: [Int: Element] = [:]
        enumerated().forEach({ result[$0.offset] = $0.element })
        return result
    }
}


