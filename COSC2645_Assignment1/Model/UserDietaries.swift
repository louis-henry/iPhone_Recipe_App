//
//  UserDietaries.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 11/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation

struct UserDietaries: Codable {
    var user_gluten: Bool
    var user_keto: Bool
    var user_vege: Bool
    var user_lacto: Bool
    var user_ovo: Bool
    var user_vegan: Bool
    var user_pesce: Bool
    var user_paleo: Bool
    var user_primal: Bool
    var user_whole: Bool
}
