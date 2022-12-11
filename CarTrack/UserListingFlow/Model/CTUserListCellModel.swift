//
//  CTUserListCellModel.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 09/12/22.
//

import Foundation
import UIKit

enum userDataType {
    case userDetail
    case dataNotFound
}
//MARK: Used for cell in user listing screen
struct CTUserListCellModel{
    var id:Int = 0
    var cellType:userDataType = .userDetail
    var name = ""
    var address = ""
    var phone = ""
    var website = ""
    var companyName = ""
    var companyCatchPhrase = ""
    var compnayBS = ""
    var latitude = ""
    var longitude = ""
    var errorMessage = ""
    var errorImage = UIImage()
}
