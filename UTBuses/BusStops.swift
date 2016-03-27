//
//  BusStops.swift
//  UTBusses
//
//  Created by Sammy Yousif on 2/25/16.
//  Copyright © 2016 Sammy Yousif. All rights reserved.
//

import Foundation

struct busStop {
    var location: CLLocationCoordinate2D
    var name: String
    var id: Int
    
    init(name: String, latitude: Double, longitude: Double, id: Int) {
        self.name = name
        self.location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        self.id = id
    }
}

let wcStops = [
    busStop(name: "27th & Nueces", latitude: 30.291657, longitude: -97.742835, id: 0),
    busStop(name: "26th & Rio Grande", latitude: 30.290696, longitude: -97.744249, id: 1),
    busStop(name: "26th & Pearl", latitude: 30.29086, longitude: -97.746437, id: 2),
    busStop(name: "25th & San Gabriel", latitude: 30.290050, longitude: -97.747693, id: 3),
    busStop(name: "22nd 1/2 & San Gabriel", latitude: 30.286734, longitude: -97.748030, id: 4),
    busStop(name: "22nd & Pearl", latitude: 30.285285, longitude: -97.746666, id: 5),
    busStop(name: "22nd & Rio Grande", latitude: 30.28513, longitude: -97.74453, id: 6),
    busStop(name: "Dobie", latitude: 30.283679, longitude: -97.74128, id: 7),
    busStop(name: "PCL", latitude: 30.2834, longitude: -97.7377, id: 8),
    busStop(name: "San Jac", latitude: 30.28313, longitude: -97.73439, id: 9),
    busStop(name: "ART", latitude: 30.286032, longitude: -97.733433, id: 10),
    busStop(name: "Engineering", latitude: 30.28956, longitude: -97.73663, id: 11),
    busStop(name: "Student Services", latitude: 30.28972, longitude: -97.7388, id: 12),
    busStop(name: "SRD", latitude: 30.292, longitude: -97.74022, id: 13),
]

let stopAnnotations = wcStops.map { (stop: busStop) -> SpotAnnotation in
    let annotation = SpotAnnotation(type: "stop", location: stop.location, time: nil)
    return annotation
}