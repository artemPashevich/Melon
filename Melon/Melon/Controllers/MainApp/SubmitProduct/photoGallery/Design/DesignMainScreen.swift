//
//  Design.swift
//  Melon
//
//  Created by Артем Пашевич on 3.11.22.
//

import UIKit
import SwiftEntryKit

class DesignMainScreen {
    static func setupAttributes() -> EKAttributes {
        var attributes = EKAttributes.bottomFloat
        attributes.displayDuration = .infinity
        attributes.screenBackground = .color(color: .init(light: UIColor(white: 100.0/255.0, alpha: 0.3), dark: UIColor(white: 50.0/255.0, alpha: 0.3)))
        attributes.screenInteraction = .dismiss
        attributes.entryInteraction = .absorbTouches
        attributes.entryBackground = .color(color: .standardBackground)
        attributes.roundCorners = .all(radius: 25)
        return attributes
    }
    
    static func setupMessage() -> EKPopUpMessage {
        let image = (UIImage(named: "mark")!.withRenderingMode(.alwaysTemplate))
        let title = "Successfully!"
        let description = "Your ad will be on the main page in a couple of seconds"
        
        let themeImage = EKPopUpMessage.ThemeImage(image: EKProperty.ImageContent(image: image, size: CGSize(width: 60, height: 60), tint: .init(UIColor(red: 0.996, green: 0.882, blue: 0, alpha: 1)), contentMode: .scaleAspectFill))
        
        let titleLabel = EKProperty.LabelContent(text: title, style: .init(font: UIFont.systemFont(ofSize: 24), color: .black, alignment: .center))
        
        let descriptionLabel = EKProperty.LabelContent(text: description, style: .init(font: UIFont.systemFont(ofSize: 17), color: .black, alignment: .center))
        
        let button = EKProperty.ButtonContent(label: .init(text: "Great", style: .init(font: UIFont.systemFont(ofSize: 17), color: .black)), backgroundColor: .init(UIColor(red: 0.996, green: 0.882, blue: 0, alpha: 1)), highlightedBackgroundColor: .clear)
        
        let message = EKPopUpMessage(themeImage: themeImage,title: titleLabel, description: descriptionLabel, button: button) {
            SwiftEntryKit.dismiss()
        }
        return message
    }
    
    
}
