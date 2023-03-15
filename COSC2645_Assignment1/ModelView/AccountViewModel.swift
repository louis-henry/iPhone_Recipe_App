//
//  AccountViewModel.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 10/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation
import UIKit

public class AccountViewModel{
    
    
    var manager : Manager
    var appliances: ApplianceOpt{
        get{
            return manager.appliances!
        }
    }
    var dietaries: DietOpt{
        get{
            return manager.dietaries!
        }
    }
    
    init(manager : Manager) {
        self.manager = manager
    }
    
    
    func updateDiet(state: Bool, name: String) {
        let dietToUpdate = manager.dietaries!
        if (name == "gluten") {
            dietToUpdate.gluten = state
        } else if (name == "keto") {
            dietToUpdate.keto = state
        } else if (name == "vege") {
            dietToUpdate.vege = state
        } else if (name == "lacto") {
            dietToUpdate.lacto = state
        } else if (name == "ovo") {
            dietToUpdate.ovo = state
        } else if (name == "vegan") {
            dietToUpdate.vegan = state
        } else if (name == "pesce") {
            dietToUpdate.pesce = state
        } else if (name == "paleo") {
            dietToUpdate.paleo = state
        } else if (name == "primal") {
            dietToUpdate.primal = state
        } else if (name == "whole") {
            dietToUpdate.whole = state
        }
        manager.dietaries = dietToUpdate
    }
    
    func updateAppliancePreferences(state: Bool, name: String) {
        
        let appliances = manager.appliances!
        
        if (name == "Oven") {
            appliances.oven = state
        } else if (name == "Microwave") {
            appliances.microwave = state
        } else if (name == "Stovetop") {
            appliances.stoveTop = state
        } else if (name == "Steamer") {
            appliances.steamer = state
        } else if (name == "PressureCooker") {
            appliances.pressureCooker = state
        } else if (name == "Blender") {
            appliances.blender = state
        } else if (name == "BBQ") {
            appliances.bbq = state
        } else if (name == "AirFryer") {
            appliances.airFryer = state
        } else if (name == "DeepFryer") {
            appliances.deepFryer = state
        } else if (name == "SousVide") {
            appliances.sousVide = state
        }
        
        manager.appliances = appliances
     
    }
    
    func resetAccountData(){
        manager.favouriteRecipes = nil
        manager.appliances = nil
        manager.dietaries = nil
    }

}
