//
//  CTUserLocationModel.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 10/12/22.
//

import Foundation
import MapKit

//MARK: used for location screen
struct CTUserLocationModel{
    var id:Int = 0
    var name = ""
    var address = ""
    var latitude = ""
    var longitude = ""
    var radius:CLLocationDistance = 2000
}
