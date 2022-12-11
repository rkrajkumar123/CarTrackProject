//
//  Utils.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 09/12/22.
//

import Foundation
import SafariServices

//MARK: Common methods used repeatedly in project
class Utils {
    
    class func getMainQueue(closure:@escaping ()->()) {
        DispatchQueue.main.async {
            closure()
        }
    }
    
    class func showSafariWebView(title: String?, link: String, fromController : UIViewController){
        var landingUrl:URL!
        if let url = URL(string: link), link.lowercased().hasPrefix("http") {
            landingUrl = url
        }else{
            let linkStr = "http://\(link)"
            if let url = URL(string: linkStr){
                landingUrl = url
            }
        }
        
        let safariViewController = SFSafariViewController(url: landingUrl)
        safariViewController.title = title
        if let fromController  = fromController as? SFSafariViewControllerDelegate{
            safariViewController.delegate = fromController
        }
        safariViewController.dismissButtonStyle = .done
        fromController.present(safariViewController, animated: true)
    }
    class func delay(_ delay:Double, closure:@escaping ()->()) {
        let when = DispatchTime.now() + delay
        DispatchQueue.main.asyncAfter(deadline: when, execute: closure)
    }
}
