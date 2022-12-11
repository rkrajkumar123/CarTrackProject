//
//  UserListingViewModel.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 09/12/22.
//

import Foundation
import UIKit

public enum UserListingCells {
    case CellTypeUserList
    case CellTypeUserNotFound
}

protocol UserListingViewModelDelegate:AnyObject{
    func reloadTableView()
}

//MARK: View Model of listing screen
class CTUserListingViewModel{
    var userList:UserList?
    weak var delegate:UserListingViewModelDelegate?
    var cellViewModel = [CTUserListCellModel]()
    
    // MARK: - Get Users Data
    func getUserLists(sucessHandler : @escaping ApiCompletionHandler){
        CTNetworkManager.sharedInstance.apiRequestForRawData(urlString: Constants.PathUrlType.users, httpMethod: .get, info: nil, requestHeaders: nil) { [weak self] (data, response, error) -> (Void) in
            if let error = error {
                debugPrint(error)
            }
            self?.parseUsersData(data)
            self?.delegate?.reloadTableView()
            sucessHandler()
        }
    }
    
    // MARK: - Parsing Data
    private func parseUsersData(_ data: Data?){
        if let data = data,let userListData = try? JSONDecoder().decode(UserList.self, from: data){
            self.userList = userListData
             prepareUserListingData()
        }else{
            var obj = CTUserListCellModel()
            obj.cellType = .dataNotFound
            obj.errorImage = UIImage(named:Constants.Images.dataNotFound) ?? UIImage()
            obj.errorMessage = Constants.dataNotFound
            cellViewModel.append(obj)
        }
    }
    
    // MARK: - Prepare User Listing Data
     func prepareUserListingData(){
        if let userList = userList , userList.count > 0{
            for i in 0..<userList.count{
                var obj = CTUserListCellModel()
                let address = "\((userList[i].address?.suite).cleanString) \((userList[i].address?.street).cleanString) \((userList[i].address?.city).cleanString) \((userList[i].address?.zipcode).cleanString)"
                obj.id = userList[i].id ?? 0
                obj.name = userList[i].name.cleanString
                obj.address = address
                obj.website = userList[i].website.cleanString
                obj.phone = userList[i].phone.cleanString
                obj.companyName = (userList[i].company?.name).cleanString
                obj.companyCatchPhrase = (userList[i].company?.catchPhrase).cleanString
                obj.compnayBS = (userList[i].company?.bs).cleanString
                obj.latitude = (userList[i].address?.geo?.lat).cleanString
                obj.longitude = (userList[i].address?.geo?.lng).cleanString
                cellViewModel.append(obj)
            }
        }else{
            var obj = CTUserListCellModel()
            obj.cellType = .dataNotFound
            obj.errorMessage = Constants.dataNotFound
            cellViewModel.append(obj)
        }
        
    }
    
    // MARK: - Open Website Link
    func openWebLink(for viewController:UIViewController,and row:Int){
        Utils.showSafariWebView(title: cellViewModel[row].name, link: cellViewModel[row].website, fromController: viewController)
    }
    
    //MARK: goToUserLocationViewController
    func goToUserLocationViewController(from vc:UIViewController,for row:Int){
        let userLocationViewController = CTStoryBoardHelper.userListingStoryboard().instantiateViewController(withIdentifier: String(describing: CTUserLocationViewController.self)) as! CTUserLocationViewController
        var obj = CTUserLocationModel()
        obj.latitude = cellViewModel[row].latitude
        obj.longitude = cellViewModel[row].longitude
        obj.name = cellViewModel[row].name
        obj.address = cellViewModel[row].address
        obj.id = cellViewModel[row].id
        userLocationViewController.userLocationViewModel.userLocationModel =  obj
        vc.navigationController?.pushViewController(userLocationViewController, animated: true)
    }
    
    //MARK: goToLoginScreen
    func goToLoginScreen(from vc:UIViewController){
        LoginDataManager.sharedManager.updateLoginStatus(isUserLogin: false)
        let loginViewController = CTStoryBoardHelper.mainStoryboard().instantiateViewController(withIdentifier: String(describing: CTLoginViewController.self)) as! CTLoginViewController
        vc.navigationController?.viewControllers = [loginViewController]
        vc.navigationController?.pushViewController(loginViewController, animated: false)
    }
}



