//
//  File.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 10/12/22.
//

import UIKit
import MapKit

//MARK: AnnotationView for showing user icon on Map
class CTUserAnnotationView: MKAnnotationView {
    override var annotation: MKAnnotation? {
        willSet {
            let pinImage = UIImage(named: Constants.Images.user)
            let size = CGSize(width: 50, height: 50)
            UIGraphicsBeginImageContext(size)
            pinImage!.draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            self.image = resizedImage
        }
    }

    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        canShowCallout = true
        centerOffset = CGPoint(x: 0, y: -20)
    }
}
