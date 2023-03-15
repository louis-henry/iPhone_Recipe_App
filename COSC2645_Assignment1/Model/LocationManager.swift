//
//  LocationManager.swift
//  COSC2645_Assignment1
//
//  Created by Bob Wallace on 14/11/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation

struct LocationManager {
    let isoCode: String
    
    init(isoCode: String){
        self.isoCode = isoCode
    }
    
    func returnIsoCode() -> (String){
        return isoCode
    }
}
