//
//  CTDropDownView.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 10/12/22.
//

import UIKit

//MARK: Dropdown view for handling country
class CTDropDownView: UIView {
    @IBOutlet weak var conatinerView: UIView!
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var itemsPickerView: UIPickerView!
    var successhandler : ((String,Int) -> ())?
    var cancelhandler : (() -> ())?
    var items:[String] = []
    var selectedValue = ""
    var selectedRow = -1
    override func awakeFromNib() {
        super.awakeFromNib()
        conatinerView.layer.cornerRadius = 8.0
        conatinerView.layer.borderWidth = 1.0
        conatinerView.layer.borderColor =  UIColor.white.cgColor
        headerLabel.text = ""
    }
    
    @IBAction func closeBttnTapped(_ sender: UIButton) {
        self.cancelhandler?()
        self.removeFromSuperview()
    }
    
    @IBAction func doneAction(_ sender: UIButton){
        self.dismissViewWithSelectedValues()
    }
    
    func showComponent(dropDownModel : CTDrodownModel ,successHandler : @escaping(String,Int) -> (),cancelHandler : @escaping() -> ()) {
        self.successhandler = successHandler
        self.cancelhandler = cancelHandler
        self.headerLabel.text =  dropDownModel.title
        self.items = dropDownModel.items
        self.selectedValue = items.first.cleanString
        self.itemsPickerView.dataSource = self
        self.itemsPickerView.delegate = self
        self.itemsPickerView.reloadAllComponents()
        if dropDownModel.selectedRow != -1{
            updateSelectedValuesToComponent(row: dropDownModel.selectedRow)
        }
        
    }
    func updateSelectedValuesToComponent(row : Int ) {
        self.itemsPickerView.selectRow(row, inComponent:0, animated:false)
    }
    func dismissViewWithSelectedValues() {
        successhandler?(selectedValue,selectedRow)
        self.removeFromSuperview()
    }
}

//MARK: Pickerview Data Source
extension CTDropDownView : UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return items.count
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 44.0
    }
}

//MARK: Pickerview Delegate
extension CTDropDownView : UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var lbl =  view as? UILabel
        if (lbl == nil) {
            lbl = UILabel()
            lbl?.font = UIFont.helveticaNeueBold(16.0)
            lbl?.textAlignment =  NSTextAlignment.center
        }
        lbl?.text = items[row]
        lbl?.sizeToFit()
        return lbl!
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Utils.delay(0.02) { [weak self] in
            self?.selectedValue = (self?.items[row]).cleanString
            self?.selectedRow = row
        }
    }
}
