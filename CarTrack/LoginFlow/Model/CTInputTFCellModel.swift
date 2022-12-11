//
//  CTInputTFCellModel.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 08/12/22.
//

import UIKit
//MARK: used this enum for defining editable type of textfield
enum CTInputTxtFieldOptions {
    case editable
    case disable
    
    init() {
        self = .editable
    }
    
    func checkIfEditable() -> Bool {
        switch self {
        case
                .disable:
            return false
        default:
            return true
        }
    }
}

//MARK: used this model for textfield hanlding
class CTInputTFCellModel {
    
    var cellTextHeading: String = ""
    var isCellHeadingHidden: Bool = true
    var placholderStr : String = ""
    var placeholder: String? {
        didSet {
            placholderStr = self.placeholder.cleanString
        }
    }
    
    var fieldValue: String = ""
    var headerLblColor: UIColor = UIColor.ct_CellHeaderColor()
    var separatorColor: UIColor = UIColor.ct_CellSeparatorColor()
    var validationLblColor: UIColor = UIColor.ct_validationErrorColor()
    var keyboardType: UIKeyboardType = UIKeyboardType.default
    var isValidationErrPresent: Bool = false
    var validationErrorText: String = ""
    var validationLblHidden: Bool =  false
    var isCellSecureEntry: Bool = false
    var isShowHideInputButtonHidden: Bool = true
    var dropDownData:CTDrodownModel? = nil
    var cellModelTag: Int = 0
    var showDescpHelperTxt : String = ""
    var autoCapitalizationWords : UITextAutocapitalizationType = .none
    var txtFieldEditOption = CTInputTxtFieldOptions()
    var isHidden:Bool = false

}
