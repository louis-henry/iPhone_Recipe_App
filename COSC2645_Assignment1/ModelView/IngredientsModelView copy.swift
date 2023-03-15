//
//  IngredientsModelView.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 10/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation
import UIKit

class IngredientsModelView{
    
    var recipeData = [Recipe]()
    
    init(){
        if let fileLocation = Bundle.main.url(forResource: "Recipes", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Recipe].self, from: data)
                self.recipeData = dataFromJson
            } catch {
                print(error)
            }
        }
    }
    
    func getFavIngredientsLen() -> Int{
        
        return getFavIngredients().count;
    }
    
    func getFavIngredients() -> [String]{
        
        var favIngrList : Set<String> = []
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            let recipesUntyped = try context.fetch(FavouriteRecipe.fetchRequest())
            for recipeUntyped in recipesUntyped{
                if let coreRecipe = recipeUntyped as? FavouriteRecipe{
                    
                    for JSONRecipe in recipeData{
                        if(JSONRecipe.title == coreRecipe.name){
                            for ingredient in JSONRecipe.ingredients{
                                favIngrList.insert(ingredient[0])
                            }
                        }
                    }
                    
                }
            }
        }catch{
            print(error)
        }

        return Array(favIngrList)
    }
}
