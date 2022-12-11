//
//  CTStoryBoardHelper.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 09/12/22.
//

import UIKit

//MARK: Used for storing storyboard collection together
class CTStoryBoardHelper {
    
    class func userListingStoryboard() -> UIStoryboard{
        return UIStoryboard.init(name: Constants.storyboardNames.userListingStoryboard, bundle: Bundle.main)
    }
    
    class func mainStoryboard() -> UIStoryboard{
        return UIStoryboard.init(name: Constants.storyboardNames.main, bundle: Bundle.main)
    }
}
