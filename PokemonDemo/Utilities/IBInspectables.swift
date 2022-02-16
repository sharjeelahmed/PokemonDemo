//
//  IBInspectables.swift
//  SanamTech
//
//  Created by Muhammad Maaz Ul haq on 1/8/18.
//  Copyright © 2018 Ingic. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    @IBInspectable var BottomShadowheight: CGFloat {
        get {
            return self.BottomShadowheight
        }
        set {
                self.layer.shadowColor = UIColor.black.cgColor
                self.layer.shadowOffset = CGSize.init(width: 0, height: newValue)
                self.layer.shadowOpacity = 0.05;
                self.layer.shadowRadius = 5;
                self.layer.masksToBounds = false;
        }
    }

    
  
    
    @IBInspectable var isCircleMe: Bool {
        get {
            return self.isCircleMe
        }
        set {
            if newValue == true {
                let radius = self.bounds.width / 2
                self.layer.cornerRadius = radius
                self.layer.masksToBounds = true
                self.clipsToBounds = true
            }
        }
    }
    
    @IBInspectable var shadow: Bool {
        get {
            return layer.shadowOpacity > 0.0
        }
        set {
            if newValue == true {
                self.addShadow()
            }
        }
    }
    
    @IBInspectable var BorderColor: UIColor {
        get {
            return UIColor.init(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var BorderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            
            // Don't touch the masksToBound property if a shadow is needed in addition to the cornerRadius
            if shadow == false {
                self.layer.masksToBounds = true
            }
        }
    }
    
    func addShadow(shadowColor: CGColor = UIColor.lightGray.cgColor,
                   shadowOffset: CGSize = CGSize(width: 0, height: 0.5),
                   shadowOpacity: Float = 0.6,
                   shadowRadius: CGFloat = 1) {
        
        layer.shadowColor = shadowColor
        layer.shadowOffset = shadowOffset
        layer.shadowOpacity = shadowOpacity
        layer.shadowRadius = shadowRadius
    }
    
}

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}

extension UITextView {
    
    //Spacing Top ** UITextView **
    @IBInspectable var TopTextSpaceUITextView: CGFloat {
        get {
            return self.textContainerInset.top
        }
        set {
            self.textContainerInset = UIEdgeInsets(top: newValue, left: self.textContainerInset.left, bottom: self.textContainerInset.bottom, right: self.textContainerInset.right)
        }
    }
    
    //Spacing Left ** UITextView **
    @IBInspectable var LeftTextSpaceUITextView: CGFloat {
        get {
            return self.textContainerInset.left
        }
        set {
            self.textContainerInset = UIEdgeInsets(top: self.textContainerInset.top, left: newValue, bottom: self.textContainerInset.bottom, right: self.textContainerInset.right)
        }
    }
    
    //Spacing Bottom ** UITextView **
    @IBInspectable var BottomTextSpaceUITextView: CGFloat {
        get {
            return self.textContainerInset.bottom
        }
        set {
            self.textContainerInset = UIEdgeInsets(top: self.textContainerInset.top, left: self.textContainerInset.left, bottom: newValue, right: self.textContainerInset.right)
        }
    }
    
    //Spacing Right ** UITextView **
    @IBInspectable var RightTextSpaceUITextView: CGFloat {
        get {
            return self.textContainerInset.right
        }
        set {            
            self.textContainerInset = UIEdgeInsets(top: self.textContainerInset.top, left: self.textContainerInset.left, bottom: self.textContainerInset.bottom, right: newValue)
        }
    }
    
    
}
