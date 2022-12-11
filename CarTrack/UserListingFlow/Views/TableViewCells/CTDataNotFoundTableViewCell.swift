//
//  CTDataNotFoundTableViewCell.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 10/12/22.
//

import UIKit

//MARK: Cell used for showing data not found
class CTDataNotFoundTableViewCell: CTBaseTableViewCell,NibLoadableView,ReusableView {
    @IBOutlet weak var cellBackgroundView: UIView!
    @IBOutlet weak var messageIconImageView: UIImageView!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellBackgroundView.dropShadowWithRadius()
    }
    
    func configureCell(cellModel:CTUserListCellModel){
        messageLabel.text = cellModel.errorMessage
        messageIconImageView.image = cellModel.errorImage
    }
    
}
