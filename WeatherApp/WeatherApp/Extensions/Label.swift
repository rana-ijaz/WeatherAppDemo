//
//  Label.swift
//  ListingsApp
//
//  Created by Rana Ijaz Ahmad on 20/08/2022.
//

import UIKit

extension UILabel {
    static func imageWithText(image: UIImage, text:String) -> NSAttributedString {
        let textAttachment = NSTextAttachment(image: image)
        let attachmentString = NSAttributedString(attachment: textAttachment)
        
        let attributedString = NSMutableAttributedString(attributedString: attachmentString)
        attributedString.append(NSAttributedString(string: " " + text))
        return attributedString
    }
}
