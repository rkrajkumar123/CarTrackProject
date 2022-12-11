//
//  CTUserDetailTableViewCell.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 09/12/22.
//

import UIKit

protocol CTUserDetailTableViewCellDelegate:AnyObject{
    func linkClicked(at row:Int)
}

//MARK: Cell used for showing user details
class CTUserDetailTableViewCell: CTBaseTableViewCell,ReusableView,NibLoadableView {
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var phoneLbl: UILabel!
    @IBOutlet weak var websiteLbl: UIButton!
    @IBOutlet weak var companyNameLbl: UILabel!
    @IBOutlet weak var companyCatchPhraseLbl: UILabel!
    @IBOutlet weak var compnayBSLbl: UILabel!
    weak var delegate:CTUserDetailTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackgroundView.dropShadowWithOutRadius()
    }
    
    func configureCell(cellModel:CTUserListCellModel){
        nameLbl.text = cellModel.name
        addressLbl.text = cellModel.address
        phoneLbl.text = cellModel.phone
        websiteLbl.setTitle(cellModel.website, for: .normal)
        companyNameLbl.text = cellModel.companyName
        compnayBSLbl.text = cellModel.compnayBS
        companyCatchPhraseLbl.text = cellModel.companyCatchPhrase
    }
    
    @IBAction func linkClicked(_ sender: UIButton) {
        delegate?.linkClicked(at: self.tag)
    }
    
}
