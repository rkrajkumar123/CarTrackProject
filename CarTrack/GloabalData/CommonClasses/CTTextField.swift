//
//  CTTextField.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 08/12/22.
//

import UIKit

//MARK: Super Class of TextField used for commmon work writing here

open class CTTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func commonInit() {
        self.smartDashesType = UITextSmartDashesType.no
        self.smartQuotesType = UITextSmartQuotesType.no
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        self.commonInit()
    }
    
}
