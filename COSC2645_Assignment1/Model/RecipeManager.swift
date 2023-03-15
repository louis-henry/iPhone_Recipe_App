//
//  RecipeManager.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 28/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation
import UIKit

class RecipeManager : Manager{
    
    let session = URLSession.shared
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let apiKey = "675e2bf1ffcc44ceaca86f2cf60710c5"
    // let apiKey = "33b9e63aaa794bcfa2846794a967caef"
    // let apiKey = "decf870fdf514c3b86beb664ad93a60c"
    // let apiKey = "1a70bd49aa814dff90b7b3cf7410a938"
    // let apiKey = "51d7b9e0c3794e04a60bbe049c7e9ba2"

    var recipeData: [Recipe] = []
    var homeData: [Recipe] = []
    
    init(){
        
    }
    
    var appliances: ApplianceOpt?{
        get{
            do {
                var appliances = try context.fetch(ApplianceOpt.fetchRequest()) as! [ApplianceOpt]
                if(appliances.count == 0){
                    let newState = ApplianceOpt(context: self.context)
                    newState.oven = true
                    newState.microwave = true
                    newState.stoveTop = true
                    newState.steamer = true
                    newState.pressureCooker = true
                    newState.blender = true
                    newState.bbq = true
                    newState.airFryer = true
                    newState.deepFryer = true
                    newState.sousVide = true
                    do {
                        try self.context.save()
                    } catch {
                    }
                    appliances = try context.fetch(ApplianceOpt.fetchRequest()) as! [ApplianceOpt]
                }
                return appliances[0]
            }catch{
            }
            return nil //Context has crashed, coredata itself doesn't exist
        }
        
        set(stateToSet){
            do {
                let appliances = try context.fetch(ApplianceOpt.fetchRequest()) as! [ApplianceOpt]
                var values : [Bool] = []
                if(stateToSet != nil) {
                    values = [stateToSet!.oven, stateToSet!.microwave, stateToSet!.stoveTop, stateToSet!.steamer, stateToSet!.pressureCooker, stateToSet!.blender, stateToSet!.bbq, stateToSet!.airFryer, stateToSet!.deepFryer, stateToSet!.sousVide]
                }
                
                for app in appliances{
                    self.context.delete(app)
                    try self.context.save()
                }
                if(stateToSet != nil){
                    let newState = ApplianceOpt(context: self.context)
                    newState.oven = values[0]
                    newState.microwave = values[1]
                    newState.stoveTop = values[2]
                    newState.steamer = values[3]
                    newState.pressureCooker = values[4]
                    newState.blender = values[5]
                    newState.bbq = values[6]
                    newState.airFryer = values[7]
                    newState.deepFryer = values[8]
                    newState.sousVide = values[9]
                }
                try self.context.save()
            } catch {
            }
        }
    }
    
    var favouriteRecipes : [FavRecipe]?{
        get{
            do {
                let newRecipe = try context.fetch(FavouriteRecipe.fetchRequest()) as! [FavouriteRecipe]
                var returnRecipes : [FavRecipe] = []
                for recipe in newRecipe{
                    returnRecipes.append(FavRecipe(fav_recipe_id : recipe.recipeID))
                }
                return returnRecipes
            }catch{
            }
            return nil //Context has crashed, coredata itself doesn't exist
        }
        set(stateToSet){
            do {
                let recipes = try context.fetch(FavouriteRecipe.fetchRequest()) as! [FavouriteRecipe]
                for rec in recipes{
                    self.context.delete(rec)
                    try self.context.save()
                }
                if let newRecipes = stateToSet{
                    for rec in newRecipes{
                        let newRecipe = FavouriteRecipe(context: self.context)
                        newRecipe.recipeID = rec.fav_recipe_id
                    }
                }
                try self.context.save()
            } catch {
            }
        }
    }
    
    var dietaries : DietOpt?{
        get{
            do {
                var dietaries = try context.fetch(DietOpt.fetchRequest()) as! [DietOpt]
                if(dietaries.count == 0){
                    let newState = DietOpt(context: self.context)
                    newState.gluten = false
                    newState.keto = false
                    newState.vege = false
                    newState.lacto = false
                    newState.ovo = false
                    newState.vegan = false
                    newState.pesce = false
                    newState.paleo = false
                    newState.primal = false
                    newState.whole = false
                    do {
                        try self.context.save()
                    } catch {
                    }
                    dietaries = try context.fetch(DietOpt.fetchRequest()) as! [DietOpt]
                }
                return dietaries[0]
            }catch{
            }
            return nil //Context has crashed, coredata itself doesn't exist
        }
        set(stateToSet){
            do {
                let dietaries = try context.fetch(DietOpt.fetchRequest()) as! [DietOpt]
                var value : [Bool] = []
                if(stateToSet != nil) {
                    value = [stateToSet!.gluten, stateToSet!.keto, stateToSet!.vege, stateToSet!.lacto, stateToSet!.ovo, stateToSet!.vegan, stateToSet!.pesce, stateToSet!.paleo, stateToSet!.primal, stateToSet!.whole]
                }
                for diet in dietaries{
                    self.context.delete(diet)
                    try self.context.save()
                }
                if(stateToSet != nil){
                    let newState = DietOpt(context: self.context)
                    newState.gluten = value[0]
                    newState.keto = value[1]
                    newState.vege = value[2]
                    newState.lacto = value[3]
                    newState.ovo = value[4]
                    newState.vegan = value[5]
                    newState.pesce = value[6]
                    newState.paleo = value[7]
                    newState.primal = value[8]
                    newState.whole = value[9]
                }
                try self.context.save()
            } catch {
            }
        }
    }

    
    func loadRecipes(withRequest: URLRequest, then: @escaping () -> Void) {
        let task = session.dataTask(with: withRequest, completionHandler: {
            data, response, downloadError in
            if let error = downloadError
            {
                print(error)
            }
            else
            {
                
                var parsedResult: Any! = nil
                do
                {
                    parsedResult = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments)
                }
                catch{
                    print()
                }
                
                var allRecipes : [[String : Any]]?
                
                if let result = parsedResult as? [String:Any] {
                    
                    if let allFormatResults = result["results"] as? [[String : Any]]{
                        allRecipes = allFormatResults
                    }
                    
                    if let allFormatRecipes = result["recipes"] as? [[String : Any]]{
                        allRecipes = allFormatRecipes
                    }
                } else {
                    if let allFormatBulk = parsedResult as? [[String : Any]] {
                        allRecipes = allFormatBulk
                    }
                }
                guard let allRecipesFinal = allRecipes else{
                    return
                }
                
                for recipe in allRecipesFinal{
                    
                    let id : Int? = recipe["id"] as? Int ?? nil
                    let title : String? = recipe["title"] as? String ?? nil
                    let cooking_time : Int? = recipe["ready_in_minutes"] as? Int ?? nil
                    let region : [String : Any] = recipe["cuisines"] as? [String : Any] ?? [:]
                    let price : Double? = recipe["pricePerServing"] as? Double ?? nil
                    let diet : [String] = recipe["diets"] as? [String] ?? []
                    let ingredients : [[String : Any]] = recipe["extendedIngredients"] as? [[String : Any]] ?? [["originalString" : "No Ingredient Data Available"]]
                    let description : String = recipe["summary"] as? String ?? "No Description Available"
                    let instructions : [[String : Any]]? = recipe["analyzedInstructions"] as? [[String : Any]] ?? nil
                    //Instructions list length can be 0, so set a default and override if the length is more than 0
                    var instructionsList : [[String: Any]] = [["step": "No Step Data Available"], ["ingredients" : "No Step Data available"]]
                    if(instructions?.count ?? 0 > 0){
                        let instructionsContainer : [String : Any]? = instructions?[0] ?? nil
                        instructionsList = instructionsContainer?["steps"] as? [[String: Any]] ?? [["step": "No Step Data Available"], ["ingredients" : "No Step Data available"]]
                    }
                    
                    var recipeImage : UIImage? = nil
                    
                    if let imageUrl : String = recipe["image"] as? String{
                        if let url = URL(string: imageUrl)
                        {
                            do{
                                //This is a synchronous call, but it's in another side thread anyway
                                let data = try Data(contentsOf: url)
                                if let image = UIImage(data: data){
                                    recipeImage = image
                                }
                            }
                            catch{
                                //Failed to load image, stays nil
                            }
                        }
                    }
                    
                    
                    if let id = id, let title = title{
                        self.recipeData.append(Recipe(id: id, title: title, cooking_time: cooking_time, region: region, price: price, diet: diet, ingredients: ingredients, description: description.replacingOccurrences(of: "<b>", with: "").replacingOccurrences(of: "</b>", with: ""), instructions: instructionsList, image: recipeImage))
                    }
                    
                    
                }
                
                
            }
            DispatchQueue.main.async(execute:{
                then()
            })
        })
        task.resume()
        
    }
    func resetRecipes() {
        recipeData = []
    }
    func getLoadedRecipes() -> [Recipe] {
        return []
    }
    func loadHomeData(withRequest: URLRequest, then: @escaping () -> Void) {
        loadRecipes(withRequest: withRequest, then: {
            for recipe in self.recipeData {
                self.homeData.append(recipe)
            }
            self.recipeData = []
            then()
        });
    }
}
