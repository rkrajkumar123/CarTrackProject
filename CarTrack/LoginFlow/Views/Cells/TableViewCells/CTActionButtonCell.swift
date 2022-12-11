//
//  CTActionButtonCell.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 09/12/22.
//

import UIKit

protocol CTActionBtnDelegate: AnyObject  {
    func actionCellButtonTapped()
}

//MARK: used this cell for hanlding login button
class CTActionButtonCell: CTBaseTableViewCell , ReusableView , NibLoadableView {
    
    @IBOutlet weak var footerBtn: UIButton!
    weak var delegate: CTActionBtnDelegate?
    var coreNerRadius:CGFloat = 5.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        footerBtn.isExclusiveTouch =  true
        coreNerRadius = self.footerBtn.frame.height/2
    }
    func configureCell(model: CTActionButtonCellModel?){
        guard let model = model else {return}
        self.footerBtn.setTitle(model.buttonText.cleanString, for: .normal)
        self.footerBtn.setCornerRadius(radius: coreNerRadius, bgColor: model.backgroundColor ?? .white, textColor: model.textColor ?? .black)
    }
    
    @IBAction func actionCellButtonTapped(_ sender: Any) {
        self.delegate?.actionCellButtonTapped()
    }
}
