//
//  CTLoginHeaderCell.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 09/12/22.
//

import UIKit

//MARK: used for header on login screen
class CTLoginHeaderCell: CTBaseTableViewCell,ReusableView,NibLoadableView {
    @IBOutlet weak var headerImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(model:CTHeaderLabelCellModel?){
        headerImageView.image = model?.headerImage
    }
}
