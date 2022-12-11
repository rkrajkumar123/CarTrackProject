//
//  CTBaseViewController.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 08/12/22.
//

import UIKit

// MARK: - For Common Work in ViewControllers
class CTBaseViewController: UIViewController {
    var activityView:UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        debugPrint("Screen Name=>\(self)")
    }
    
    // MARK: - for showing indicator view at the time of api calling
    func showProgressView(){
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                self.activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
            } else {
                self.activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
            }
            self.activityView.center = self.view.center
            self.view.addSubview(self.activityView)
            self.activityView.startAnimating()
        }
    }
    
    // MARK: hide indicator view
    func hideProgressView(){
        self.view.isUserInteractionEnabled = true
        if (activityView != nil){
            DispatchQueue.main.async {
                self.activityView.stopAnimating()
            }
        }
    }
    
    // MARK: to show UIAlertController with message
    func showMessage(with message:String){
        let alert = UIAlertController(title: Constants.carTrack, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.ok, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: managing navigation bar
    func hideNavigationBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    func showNavigationBar(with title:String?=nil){
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.title = title ?? ""
    }
}
