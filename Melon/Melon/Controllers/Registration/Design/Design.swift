//
//  Design.swift
//  Melon
//
//  Created by Артем Пашевич on 27.09.22.
//

import UIKit

class Design {
    
    static func borderColorError(isValid: Bool, textField: UITextField) {
        if isValid {
            textField.layer.borderWidth = 0
        } else {
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor(red: 0.913, green: 0.295, blue: 0.16, alpha: 1).cgColor
        }
    }
    
    static func addTire(textField: UITextField) {
           if textField.text?.count == 3 || textField.text?.count == 6 {
               textField.text = textField.text! + "-"
           }
    }
    
    static func showError(errorLbl: UILabel) {
        UIView.animate(withDuration: 3, delay: 0, options: .curveEaseInOut, animations: {
            errorLbl.isHidden = false
        }) { _ in errorLbl.isHidden = true }
    }
}

