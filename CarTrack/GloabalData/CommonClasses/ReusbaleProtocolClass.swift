//
//  ReusbaleProtocolClass.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 08/12/22.
//

import Foundation
import UIKit

//MARK: Used for retriving identifier in simple way
protocol ReusableView: AnyObject {}

extension ReusableView where Self: UIView {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

//MARK: Used for retriving nibName in simple way
protocol NibLoadableView: AnyObject {}

extension NibLoadableView where Self: UIView {
    static var nibName: String {
        return String(describing: self)
    }
}
