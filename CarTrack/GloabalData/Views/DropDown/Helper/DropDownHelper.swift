//
//  DropDownHelper.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 10/12/22.
//

import Foundation
import UIKit

//MARK: DropDown helper for handling dropdown related things
class DropDownHelper {
    static let sharedInstance = DropDownHelper()
    func showDropDown(drodownModel: CTDrodownModel , successHandler : @escaping(String,Int) -> (),cancelHandler : @escaping() -> ()) {
        
        if let topView = UIApplication.shared.windows.first{
            let dropDownView : CTDropDownView =  (Bundle.main.loadNibNamed(String(describing: CTDropDownView.self), owner: nil, options: nil)![0] as! CTDropDownView)
            topView.addSubview(dropDownView)
            dropDownView.translatesAutoresizingMaskIntoConstraints =  false
            let leading = NSLayoutConstraint(item: dropDownView, attribute: .leading, relatedBy: .equal, toItem: topView, attribute: .leading, multiplier: 1.0, constant: 0.0)
            let trailing = NSLayoutConstraint(item: dropDownView, attribute: .trailing, relatedBy: .equal, toItem: topView, attribute: .trailing, multiplier: 1.0, constant: 0.0)
            let bottom = NSLayoutConstraint(item: dropDownView, attribute: .bottom, relatedBy: .equal, toItem: topView, attribute: .bottom, multiplier: 1.0, constant: 0.0)
            let top = NSLayoutConstraint(item: dropDownView, attribute: .top, relatedBy: .equal, toItem:topView, attribute: .top, multiplier: 1.0, constant: 0.0)
            NSLayoutConstraint.activate([ leading, trailing, bottom, top])
            dropDownView.showComponent(dropDownModel: drodownModel, successHandler: successHandler, cancelHandler: cancelHandler)
        }
    }
}
