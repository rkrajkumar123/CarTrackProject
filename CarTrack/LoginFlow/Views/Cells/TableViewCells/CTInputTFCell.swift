//
//  CTInputTFCell.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 08/12/22.
//

import UIKit

//MARK: used this delegation for passind textfield data to contorller
protocol CTInputTFCellDelegate: AnyObject {
    func inputTFCellDelegateEditingBegin(cell: UITableViewCell, textField: UITextField?) -> Bool
    func inputTFCellDelegateEditingEnd(cell: UITableViewCell, str: String)
    func inputTFCellDelegateCharacterChange(textField: UITextField, range: NSRange, string: String, cell: UITableViewCell) -> Bool
    func inputTFCellDelegateRemoveCharacter(cell: UITableViewCell , textField: UITextField , string: String)
}

extension CTInputTFCellDelegate {
    
    func inputTFCellDelegateCharacterChange(textField: UITextField, range: NSRange, string: String, cell: UITableViewCell) -> Bool {
        return true
    }
    func inputTFCellDelegateRemoveCharacter(cell: UITableViewCell , textField: UITextField , string: String) {
        
    }
    
}

//MARK: usded this cell for managing textfield
class CTInputTFCell: CTBaseTableViewCell,ReusableView,NibLoadableView {
    
    @IBOutlet weak var inputHeaderLbl: UILabel!
    @IBOutlet weak var hideInputBtn: UIButton!
    @IBOutlet weak var inputValueTextField: CTTextField!
    @IBOutlet weak var inputValidationLbl: UILabel!
    @IBOutlet weak var separatorLine: UILabel!
    @IBOutlet weak var btnHideShowWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var topLblHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topLblConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomLblConstraint: NSLayoutConstraint!
    @IBOutlet weak var tfHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var warningLblHeightConstraint: NSLayoutConstraint!
    var cellModel : CTInputTFCellModel?
    weak var delegate: CTInputTFCellDelegate?
    
    func configureCell(model: CTInputTFCellModel?) {
        guard let model = model else{ return}
        cellModel = model
        inputValueTextField.delegate = self
        inputValueTextField.keyboardType = model.keyboardType
        inputValueTextField.text = model.fieldValue
        inputValueTextField.attributedPlaceholder = NSAttributedString(string:model.placholderStr,attributes: [NSAttributedString.Key.foregroundColor:UIColor.ct_CellHeaderColor()])
        if model.isHidden{
            topLblHeightConstraint.constant = 0
            tfHeightConstraint.constant = 0
            topLblConstraint.constant = 0
            bottomLblConstraint.constant = 0
            warningLblHeightConstraint.constant = 0
            inputValueTextField.isHidden = true
            self.isHidden = true
            
        }else{
            topLblHeightConstraint.constant = 20
            topLblConstraint.constant = 10
            bottomLblConstraint.constant = 10
            tfHeightConstraint.constant = 30
            warningLblHeightConstraint.constant = 16
            inputValueTextField.isHidden = false
            self.isHidden = false
        }
        inputValueTextField.isEnabled =  model.txtFieldEditOption == .disable ? false : true
        inputValueTextField.tag = model.cellModelTag
        self.tag = model.cellModelTag
        inputHeaderLbl.text = model.cellTextHeading
        inputHeaderLbl.textColor = model.headerLblColor
        inputHeaderLbl.isHidden = model.isCellHeadingHidden
        separatorLine.backgroundColor = model.separatorColor
        inputValidationLbl.text = model.validationErrorText
        inputValidationLbl.isHidden = !model.isValidationErrPresent
        inputValidationLbl.textColor = model.validationLblColor
        inputValueTextField.autocapitalizationType = model.autoCapitalizationWords
        if model.isValidationErrPresent == false && model.showDescpHelperTxt.isEmpty == false {
            inputValidationLbl.text =  model.showDescpHelperTxt
            inputValidationLbl.textColor =  UIColor.ct_CellHeaderColor()
            inputValidationLbl.isHidden = false
        }
        hideInputBtn.isHidden = model.isShowHideInputButtonHidden
        btnHideShowWidthConstraint.constant = model.isShowHideInputButtonHidden ? 0 : 64
        if model.isCellSecureEntry{
            inputValueTextField.isSecureTextEntry = model.isCellSecureEntry
        }
    }
    
    @IBAction func hideInputTextAction(_ sender: UIButton) {
        if let model = self.cellModel {
            sender.isSelected = !sender.isSelected
            model.isCellSecureEntry = !sender.isSelected
            inputValueTextField.isSecureTextEntry = !sender.isSelected
            let currentText: String = self.inputValueTextField.text!
            inputValueTextField.text = "";
            inputValueTextField.text = currentText
            
        }else{
            sender.isSelected = !sender.isSelected
            inputValueTextField.isSecureTextEntry = !sender.isSelected
            let currentText: String = self.inputValueTextField.text!
            inputValueTextField.text = "";
            inputValueTextField.text = currentText
        }
    }
    
    func openKeyBoard() {
        inputValueTextField.becomeFirstResponder()
    }
    
}

//MARK: UITextFieldDelegate methods handling
extension CTInputTFCell: UITextFieldDelegate{
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool  {
        if let isEditingTrue = self.delegate?.inputTFCellDelegateEditingBegin(cell: self, textField: self.inputValueTextField) {
            return isEditingTrue
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if range.length > 0 && string.isEmpty {
            if let text = textField.text, let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange,with: string)
                self.delegate?.inputTFCellDelegateRemoveCharacter(cell:self, textField:textField, string:updatedText)
                return true
            }
        }
        if textField.isSecureTextEntry {
            if let text = textField.text,
               let textRange = Range(range, in: text) {
                let updatedText = text.replacingCharacters(in: textRange, with: string)
                textField.text = updatedText
                return false
            }
        }
        else{
            if let text = textField.text, let textRange = Range(range, in: text) {
                if (text.count == 0 && string == " "){
                    return false
                }
                
                let updatedText = text.replacingCharacters(in: textRange,with: string)
                return self.delegate?.inputTFCellDelegateCharacterChange(textField: textField, range: range, string: updatedText, cell: self) ?? true
            }
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.inputTFCellDelegateEditingEnd(cell: self, str: textField.text ?? "")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
