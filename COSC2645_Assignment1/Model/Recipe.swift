//
//  Recipe.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 10/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation
import UIKit

struct Recipe {
    var image : UIImage?
    var id : Int
    var title: String
    var cooking_time: Int?
    var region : [String : Any]
    var price : Double?
    var diet : [String]
    var ingredients : [[String : Any]]
    var description : String
    var instructions : [[String : Any]]
    
    init(id : Int, title: String, cooking_time: Int?, region : [String : Any], price : Double?, diet : [String], ingredients : [[String : Any]], description : String, instructions : [[String : Any]], image : UIImage?){
        self.id = id
        self.title = title
        self.cooking_time = cooking_time
        self.region = region
        self.price = price
        self.diet = diet
        self.ingredients = ingredients
        self.description = description
        self.instructions = instructions
        self.image = image
    }
}

