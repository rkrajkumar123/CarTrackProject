//
//  Extensions.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 08/12/22.
//

import UIKit
//MARK: Some unique color code that has been used in whole project
extension UIColor {
    class func ct_CellHeaderColor() -> UIColor {
        return UIColor(red: 124.0/255.0, green: 139.0/255.0, blue: 162.0/255.0, alpha: 1)
    }
    
    class func ct_CellSeparatorColor() -> UIColor {
        return UIColor(red: 234.0/255.0, green: 239.0/255.0, blue: 245.0/255.0, alpha: 1)
    }
    
    class func ct_validationErrorColor() -> UIColor {
        return UIColor.red
    }
    
    class func ct_BlackButtonsColor() -> UIColor {
        return UIColor(red: 0, green: 0, blue: 0, alpha: 1.0)
    }
    class func ct_shadowColor() -> UIColor! {
        return UIColor(red: 81.0/255.0, green: 119.0/255.0, blue: 255.0/255.0, alpha: 0.2)
    }
}

//MARK: For optional handling
extension Optional where Wrapped == String {
    var cleanString : String {
        return (self ?? "").isEmpty ? "" : self!
    }
    var isEmptyOrNil : Bool {
        guard let value = self else { return true }
        return value.isEmpty
    }
    
}

//MARK: Converting String to Double
extension String{
    var doubleValue:Double{
        return Double(self) ?? 0.0
    }
}

//MARK: Setting Corner radius with shadow
extension UIView{
    func dropShadowWithRadius() {
        self.layer.cornerRadius = 8
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.ct_shadowColor().cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.8
    }
    func dropShadowWithOutRadius() {
        self.layer.shadowColor = UIColor.ct_shadowColor().cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.8
    }
}

//MARK: for registering cell with UITableView
extension UITableView{
    func register<T: UITableViewCell & ReusableView & NibLoadableView>(_: T.Type) {
        let nib = UINib(nibName: T.nibName, bundle: nil)
        register(nib, forCellReuseIdentifier: T.reuseIdentifier)
    }
}

//MARK: Setting corner radius of button
extension UIButton{
    func setCornerRadius(radius: CGFloat,bgColor: UIColor,textColor:UIColor) {
        self.layer.cornerRadius = radius
        self.backgroundColor = bgColor
        self.setTitleColor(textColor, for: .normal)
        self.layer.masksToBounds = true
    }
}

extension UITableViewCell {
    var tableView: UITableView? {
        var view = self.superview
        while (view != nil && view!.isKind(of: UITableView.self) == false) {
            view = view!.superview
        }
        return view as? UITableView
    }
}

extension UIFont{
    class func helveticaNeueBold(_ fontSize: CGFloat) -> UIFont? {
        return UIFont(name: "HelveticaNeue", size:fontSize)
    }
}
