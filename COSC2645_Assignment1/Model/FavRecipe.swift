//
//  FavRecipe.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 10/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//
import Foundation

struct FavRecipe: Codable {
    var fav_recipe_id: String?
    init(fav_recipe_id : String?) {
        self.fav_recipe_id = fav_recipe_id
    }
}
