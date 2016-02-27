//
//  BusStops.swift
//  UTBusses
//
//  Created by Sammy Yousif on 2/25/16.
//  Copyright © 2016 Sammy Yousif. All rights reserved.
//

import Foundation

let wcStops = [
    CLLocationCoordinate2D(latitude: 30.28956, longitude: -97.73663), // DEAN KEETON/SPEEDWAY NE CORNER',
    CLLocationCoordinate2D(latitude: 30.28954, longitude: -97.74775), // SAN GABRIEL / 25TH',
    CLLocationCoordinate2D(latitude: 30.2834, longitude: -97.7377), // SPEEDWAY / 21ST',
    CLLocationCoordinate2D(latitude: 30.283679, longitude: -97.74128), // 21ST/WHITIS (DOBIE MALL)',
    CLLocationCoordinate2D(latitude: 30.292, longitude: -97.74022), // 27TH/WHITIS',
    CLLocationCoordinate2D(latitude: 30.28513, longitude: -97.74453), // 22ND/RIO GRANDE',
    CLLocationCoordinate2D(latitude: 30.285285, longitude: -97.746666), // 22ND/PEARL',
    CLLocationCoordinate2D(latitude: 30.290696, longitude: -97.744249), // 26TH/RIO GRANDE',
    CLLocationCoordinate2D(latitude: 30.29086, longitude: -97.746437), // 26TH/PEARL',
    CLLocationCoordinate2D(latitude: 30.28313, longitude: -97.73439), // 309 21ST/SAN JACINTO',
    CLLocationCoordinate2D(latitude: 30.285874, longitude: -97.747959), // 2212 SAN GABRIEL/22ND HALF',
    CLLocationCoordinate2D(latitude: 30.28972, longitude: -97.7388), // 116 DEAN KEETON/UNIVERSITY',
    CLLocationCoordinate2D(latitude: 30.291657, longitude: -97.742835), // NUECES/27TH',
    CLLocationCoordinate2D(latitude: 30.286032, longitude: -97.733433) // SAN JACINTO/23RD MIDBLOCK'
]

let stopAnnotations = wcStops.map { (location: CLLocationCoordinate2D) -> SpotAnnotation in
    let annotation = SpotAnnotation(type: "stop", location: location, time: nil)
    return annotation
}