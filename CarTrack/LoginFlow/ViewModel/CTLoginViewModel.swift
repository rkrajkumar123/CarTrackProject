//
//  CTLoginViewModel.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 09/12/22.
//

import Foundation
import UIKit

//MARK: used for defining type of cells which will be showing on login screen
public enum LoginPageCells: Int {
    case CellTypeHeader = 0
    case CellTypeEmail
    case CellTypePassword
    case CellTypeDropdown
    case CellTypeLoginBtn
    case TotalCellCount
}

//MARK: LoginViewModelDelegate usde for passing data b/w controller and viewmodel
protocol CTLoginViewModelDelegate: AnyObject  {
    func configureCellOnEditingBases(row: Int)
    func loginSuccessful()
    func wrongCredentials()
    func endTheViewEditing()
}

extension CTLoginViewModelDelegate{
    func configureCellOnEditingBases(row: Int){}
    func endTheViewEditing() {}
}
//MARK: used this viewm model for login screen
class CTLoginViewModel {
    var cellViewModel = [Any]()
    weak var delegate:CTLoginViewModelDelegate?
    init() {
        prepareLoginPageData()
    }
    
    //MARK: preparing cellViewModel for login screen
    private func prepareLoginPageData(){
        for i in 0..<LoginPageCells.TotalCellCount.rawValue {
            switch i {
            case LoginPageCells.CellTypeHeader.rawValue:
                let model = CTHeaderLabelCellModel()
                model.headerImage = UIImage(named: Constants.Images.loginHeader)
                self.cellViewModel.append(model)
                break
            case LoginPageCells.CellTypeEmail.rawValue:
                let model = CTInputTFCellModel()
                model.cellTextHeading = Constants.emailId
                model.placeholder = Constants.emailId
                model.isCellHeadingHidden = true
                model.validationLblHidden = true
                model.keyboardType = UIKeyboardType.emailAddress
                self.cellViewModel.append(model)
                break
            case LoginPageCells.CellTypePassword.rawValue:
                let model = CTInputTFCellModel()
                model.cellTextHeading = Constants.password
                model.placeholder = Constants.password
                model.isCellHeadingHidden = true
                model.validationLblHidden = true
                model.isCellSecureEntry = true
                model.isShowHideInputButtonHidden = false
                model.keyboardType = UIKeyboardType.default
                self.cellViewModel.append(model)
                break
            case LoginPageCells.CellTypeDropdown.rawValue:
                let model = CTInputTFCellModel()
                model.cellTextHeading = Constants.selectCountry
                model.placeholder = Constants.selectCountry
                model.isCellHeadingHidden = true
                model.validationLblHidden = true
                model.isCellSecureEntry = false
                model.keyboardType = UIKeyboardType.default
                let countryList = Locale.isoRegionCodes.compactMap { Locale.current.localizedString(forRegionCode: $0)}
                let obj = CTDrodownModel(title: Constants.countryList, items: countryList.sorted())
                model.dropDownData = obj
                self.cellViewModel.append(model)
                break
            case LoginPageCells.CellTypeLoginBtn.rawValue:
                let model = CTActionButtonCellModel()
                model.buttonText = Constants.login
                model.backgroundColor = UIColor.ct_BlackButtonsColor()
                model.textColor = .white
                self.cellViewModel.append(model)
                break
            default:
                break
            }
        }
    }
    
    //MARK: goToUserListingScreen
    func goToUserListingScreen(from vc:UIViewController){
        LoginDataManager.sharedManager.updateLoginStatus(isUserLogin: true)
        let userListingViewController = CTStoryBoardHelper.userListingStoryboard().instantiateViewController(withIdentifier: String(describing: CTUserListingViewController.self)) as! CTUserListingViewController
        vc.navigationController?.viewControllers = [userListingViewController]
        vc.navigationController?.pushViewController(userListingViewController, animated: true)
    }
    
    //MARK: Configure cell for drop down data of country
    private func configureCellForCountryDropdown(row:Int){
        if let model = cellViewModel[row] as? CTInputTFCellModel,let dropDownData = model.dropDownData{
            DropDownHelper.sharedInstance.showDropDown(drodownModel: dropDownData) {[weak self] (selectedValue,dropDownDataRow) in
                self?.dropDownSelectionEditingEnd(row: row, str: selectedValue,dropDownDataRow:dropDownDataRow)
            } cancelHandler: {[weak self] in
                self?.dropDownSelectionEditingEnd(row: row, str:model.fieldValue, dropDownDataRow: model.dropDownData?.selectedRow ?? -1)
            }
        }
    }
}

// MARK: Input Text Field Callback Handling
extension CTLoginViewModel:CTInputTFCellDelegate{
    func inputTFCellDelegateEditingBegin(cell: UITableViewCell, textField: UITextField?) -> Bool {
        if let index = cell.tableView?.indexPath(for: cell){
            self.changeTextFieldUIOnBeginEditing(modelIndex: index.row)
            if index.row == LoginPageCells.CellTypeDropdown.rawValue{
                self.delegate?.endTheViewEditing()
                self.configureCellForCountryDropdown(row:index.row)
                return false
            }
        }
        return true
    }
    
    //MARK: textfield delegate callback hanlding for shoing error on textfield
    func changeTextFieldUIOnBeginEditing(modelIndex: Int) {
        if modelIndex == LoginPageCells.CellTypeEmail.rawValue || modelIndex == LoginPageCells.CellTypePassword.rawValue || modelIndex == LoginPageCells.CellTypeDropdown.rawValue{
            let cellViewModel = self.cellViewModel[modelIndex] as! CTInputTFCellModel
            cellViewModel.headerLblColor = UIColor.ct_BlackButtonsColor()
            cellViewModel.separatorColor = UIColor.ct_BlackButtonsColor()
            cellViewModel.placeholder = ""
            cellViewModel.isCellHeadingHidden = false
            cellViewModel.validationLblHidden = true
            cellViewModel.isValidationErrPresent = false
        }
        self.delegate?.configureCellOnEditingBases(row: modelIndex)
    }
    
    //MARK: textfield delegate callback hanlding for shoing error on textfield
    func inputTFCellDelegateEditingEnd(cell: UITableViewCell, str: String) {
        if let index = cell.tableView?.indexPath(for: cell), (index.row == LoginPageCells.CellTypeEmail.rawValue || index.row == LoginPageCells.CellTypePassword.rawValue){
            let cellViewModel = self.cellViewModel[index.row] as! CTInputTFCellModel
            cellViewModel.fieldValue = str
            self.changeTextFieldUIOnEndEditing(modelIndex: index.row)
        }
    }
    
    //MARK: textfield delegate callback hanlding for shoing error on textfield
    func dropDownSelectionEditingEnd(row:Int, str: String,dropDownDataRow:Int) {
        if row == LoginPageCells.CellTypeDropdown.rawValue {
            let cellViewModel = self.cellViewModel[row] as! CTInputTFCellModel
            cellViewModel.fieldValue = str
            cellViewModel.dropDownData?.selectedRow = dropDownDataRow
            self.changeTextFieldUIOnEndEditing(modelIndex: row)
        }
    }
    
    //MARK: textfield delegate callback hanlding for shoing error on textfield
    func changeTextFieldUIOnEndEditing(modelIndex: Int) {
        guard let cellViewModel = self.cellViewModel[modelIndex] as? CTInputTFCellModel else {return}
        
        var validationError : CTValidationError?
        switch modelIndex {
        case LoginPageCells.CellTypeEmail.rawValue:
            validationError = CTValidationManager.validateEmailForLogin(cellViewModel.fieldValue)
            break
        case LoginPageCells.CellTypePassword.rawValue:
            validationError = CTValidationManager.validatePassword(cellViewModel.fieldValue)
            break
        case LoginPageCells.CellTypeDropdown.rawValue:
            validationError = CTValidationManager.validateDropDown(cellViewModel.fieldValue)
            break
        default:
            break
        }
        
        if let error = validationError{
            cellViewModel.separatorColor = UIColor.ct_validationErrorColor()
            cellViewModel.headerLblColor = UIColor.ct_CellHeaderColor()
            cellViewModel.validationErrorText = error.errorString.cleanString
            cellViewModel.validationLblHidden = false
            cellViewModel.isCellHeadingHidden = true
            cellViewModel.isValidationErrPresent = true
            cellViewModel.placeholder = cellViewModel.cellTextHeading
        }else{
            cellViewModel.headerLblColor = UIColor.ct_CellHeaderColor()
            cellViewModel.separatorColor = UIColor.ct_CellSeparatorColor()
            cellViewModel.validationLblHidden = true
            cellViewModel.validationErrorText = ""
            cellViewModel.isValidationErrPresent = false
            cellViewModel.isCellHeadingHidden = false
            cellViewModel.placeholder = cellViewModel.cellTextHeading
        }
        self.delegate?.configureCellOnEditingBases(row: modelIndex)
    }
    
    //MARK: checking data is valid or not
    fileprivate func checkValidData() -> (isValid: Bool, invalidCellIndex : [Int]) {
        var isValid = true
        var invalidCellIndex = [Int]()
        for i in 0..<LoginPageCells.TotalCellCount.rawValue {
            switch i {
            case LoginPageCells.CellTypeEmail.rawValue:
                if cellViewModel.count > i,let cellViewModel = self.cellViewModel[i] as? CTInputTFCellModel {
                    let validationError = CTValidationManager.validateEmailForLogin(cellViewModel.fieldValue)
                    if let error = validationError{
                        isValid = false
                        invalidCellIndex.append(i)
                        cellViewModel.validationErrorText = error.errorString.cleanString
                        cellViewModel.isValidationErrPresent = true
                        cellViewModel.separatorColor = UIColor.ct_validationErrorColor()
                    }
                }
                break
            case LoginPageCells.CellTypePassword.rawValue:
                if cellViewModel.count > i,let cellViewModel = self.cellViewModel[i] as? CTInputTFCellModel{
                    let validationError: CTValidationError? = CTValidationManager.validatePassword(cellViewModel.fieldValue)
                    if let error = validationError{
                        isValid = false
                        invalidCellIndex.append(i)
                        cellViewModel.validationErrorText = error.errorString.cleanString
                        cellViewModel.isValidationErrPresent = true
                        cellViewModel.separatorColor = UIColor.ct_validationErrorColor()
                    }
                }
                break
            default:
                break
            }
        }
        return (isValid, invalidCellIndex)
    }
}

// MARK: Login Button Action Handling
extension CTLoginViewModel:CTActionBtnDelegate{
    func actionCellButtonTapped() {
        self.delegate?.endTheViewEditing()
        let tuple = self.checkValidData()
        if tuple.isValid,let obj  = LoginDataManager.sharedManager.getLoginCredential(){
            let emailCellModel = self.cellViewModel[LoginPageCells.CellTypeEmail.rawValue] as? CTInputTFCellModel
            let passwordCellModel = self.cellViewModel[LoginPageCells.CellTypePassword.rawValue] as? CTInputTFCellModel
            if emailCellModel?.fieldValue.lowercased() == obj.email && passwordCellModel?.fieldValue == obj.password{
                LoginDataManager.sharedManager.updateLoginStatus(isUserLogin: true)
                self.delegate?.loginSuccessful()
            }else{
                self.delegate?.wrongCredentials()
            }
        }else{
            self.delegate?.wrongCredentials()
        }
    }
}
