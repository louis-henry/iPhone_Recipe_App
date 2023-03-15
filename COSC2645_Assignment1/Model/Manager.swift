//
//  RecipeManager.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 28/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation

protocol Manager{
    var appliances : ApplianceOpt?{get set}
    var favouriteRecipes : [FavRecipe]?{get set}
    var dietaries : DietOpt?{get set}
    var recipeData: [Recipe]{get}
    var homeData: [Recipe]{get}
    var apiKey: String {get}
    func loadRecipes(withRequest: URLRequest, then: @escaping () -> Void)
    func loadHomeData(withRequest: URLRequest, then: @escaping () -> Void)
    func resetRecipes()
}
