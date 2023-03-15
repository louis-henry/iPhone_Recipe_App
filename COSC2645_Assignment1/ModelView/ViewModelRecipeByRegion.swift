//
//  ViewModelRecipeByRegion.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 2/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

class ViewModelRecipeByRegion : ViewModelRecipe{

    var manager : Manager
    var regionTypesTitle : Set<String> = ["African", "American", "British", "Cajun", "Caribbean", "Chinese", "Eastern European", "European", "French", "German", "Greek", "Indian", "Irish", "Italian", "Japanese", "Jewish", "Korean", "Latin American", "Mediterranean", "Mexican", "Middle Eastern", "Nordic", "Southern", "Spanish", "Thai", "Vietnamese"]
    var regionTypesImage : UIImage;
    
    var recipeData: [Recipe]{
        get{
            return manager.recipeData
        }
    }
    
    var numberToLoad: Int{
        get{
            return 10
        }
    }
    
    init(manager : Manager){
        self.manager = manager
        
        regionTypesImage = #imageLiteral(resourceName: "search-region")
        
    }

    func getCollectionRecipeData() -> [(title : String, image : UIImage)]{
        
        var collectionData : [(title : String, image : UIImage)] = []
        if let country = currentLocationObject?.isoCountryCode {
            let region = findRegionFromCountry(country: country)
            print("country = currentLocation") // testing
            for title in regionTypesTitle{
                if title == region {
                    let matchedItem = matchedRegion(collectionItem: (title: title, image: regionTypesImage))
                    collectionData.insert(matchedItem, at: 0)
                }
                else if title != country {
                    collectionData.append((title: title, image: regionTypesImage))
                }
            }
        } else {
            print("country != currentLocation") // testing
            for title in regionTypesTitle{
                collectionData.append((title: title, image: regionTypesImage))
            }
        }
        return collectionData;
    }
    
    func loadTableRecipeData(collectionChosen : String?, wipeFirst : Bool, then: @escaping () -> Void){
        if (wipeFirst) {
            manager.resetRecipes()
            then()
        }
        var userDietStrings : [String] = []
        let userDiet = manager.dietaries
        if (userDiet!.gluten) {
            userDietStrings.append("gluten-free")
        }
        if (userDiet!.keto) {
            userDietStrings.append("ketogenic")
        }
        if (userDiet!.vege) {
            userDietStrings.append("vegetarian")
        }
        if (userDiet!.lacto) {
            userDietStrings.append("lacto-vegetarian")
        }
        if (userDiet!.ovo) {
            userDietStrings.append("ovo-vegetarian")
        }
        if (userDiet!.vegan) {
            userDietStrings.append("vegan")
        }
        if (userDiet!.pesce) {
            userDietStrings.append("pescetarian")
        }
        if (userDiet!.paleo) {
            userDietStrings.append("paleo")
        }
        if (userDiet!.primal) {
            userDietStrings.append("primal")
        }
        if (userDiet!.whole) {
            userDietStrings.append("whole30")
        }
        var query = "https://api.spoonacular.com/recipes/random?apiKey=\(manager.apiKey)&number=10"
        query.append("&tags=")
        
        if (userDietStrings.count != 0) {
            query.append(userDietStrings.joined(separator: ","))
            query.append(",")
        }
        if (collectionChosen != "") {
            query.append(collectionChosen!.lowercased())
        }
        manager.loadRecipes(withRequest:URLRequest(url: URL(string: query)!), then:then)
    }
    
    // changes the image of the matched region to a map pin
    func matchedRegion(collectionItem: (title: String, image: UIImage)) -> (title: String, image: UIImage) {
        let existingTitle = collectionItem.title
        let existingImage = collectionItem.image
        if let newImage = UIImage(named: "map pin") {
            return (title: existingTitle, image: newImage)
        }
        
        return (title: existingTitle, image: existingImage)
    }
    
    // returns a matching region
    func findRegionFromCountry(country: String) -> (String) {
        for dict in Region().Regions {
            if let regionName = dict.first {
                print("\n\ndictionaries first value: " + regionName.value)
                for isoCode in dict {
                    if country == isoCode.key {
                        print("\nmatch found - returning: " + isoCode.value)
                        return isoCode.value
                    }
                }
            }
        }
        
        // no matching region was found for the current location
        print("\nno matching region found - returning none") // testing
        return "none"
    }
    
    struct Region {
        var Regions: [[String: String]]
        
        init() {
            Regions = [African,American,British,Cajun,Caribbean,Chinese,EasternEuropean,European,French,German,Greek,Indian,Ireland,Japanese,Jewish,Korean,LatinAmerican,Mediterranean,Mexican,MiddleEastern,Nordic,Southern,Spanish,Thai,Vietnamese]
        }
        
        let African = ["DZ":"African","AO":"African","BJ":"African","BW":"African","BF":"African","BI":"African","CM":"African","CV":"African","CF":"African","KM":"African","CD":"African","DJ":"African","EG":"African","GQ":"African","ER":"African","ET":"African","GA":"African","GM":"African","GH":"African","GN":"African","GW":"African","CI":"African","KE":"African","LS":"African","LR":"African","LY":"African","MG":"African","MW":"African","ML":"African","MR":"African","MU":"African","MA":"African","MZ":"African","NA":"African","NE":"African","NG":"African","CG":"African","RE":"African","RW":"African","SH":"African","ST":"African","SN":"African","SC":"African","SL":"African","SO":"African","ZA":"African","SS":"African","SD":"African","SZ":"African","TZ":"African","TG":"African","TN":"African","UG":"African","EH":"African","ZM":"African","ZW":"African"]
        let American = ["US":"American"]
        let British = ["GB":"British"]
        let Cajun = ["US":"Cajun"]
        let Caribbean = ["AG":"Caribbean","BH":"Caribbean","BB":"Caribbean","BZ":"Caribbean","CU":"Caribbean","DM":"Caribbean","DO":"Caribbean","GD":"Caribbean","GH":"Caribbean","HT":"Caribbean","JM":"Caribbean","KN":"Caribbean","LC":"Caribbean","VC":"Caribbean","SR":"Caribbean","TT":"Caribbean"]
        let Chinese = ["CN":"Chinese"]
        let EasternEuropean = ["BY":"Eastern European","BG":"Eastern European","CZ":"Eastern European","HU":"Eastern European","MD":"Eastern European","PL":"Eastern European","RO":"Eastern European","RU":"Eastern European","SK":"Eastern European","UA":"Eastern European"]
        let European = ["AL":"European","AD":"European","AT":"European","BY":"European","BE":"European","BA":"European","BG":"European","HR":"European","CY":"European","CZ":"European","DK":"European","EE":"European","FO":"European","FI":"European","FR":"European","DE":"European","GI":"European","GR":"European","HU":"European","IS":"European","IE":"European","IM":"European","IT":"European","XK":"European","LV":"European","LI":"European","LT":"European","LU":"European","MK":"European","MT":"European","MD":"European","MC":"European","ME":"European","NL":"European","NO":"European","PL":"European","PT":"European","RO":"European","RU":"European","SM":"European","RS":"European","SK":"European","SI":"European","ES":"European","SE":"European","CH":"European","UA":"European","GB":"European","VA":"European"]
        let French = ["FR":"French"]
        let German = ["DE":"German"]
        let Greek = ["GR":"Greek"]
        let Indian = ["IN":"Indian"]
        let Ireland = ["IE":"Ireland"]
        let Italian = ["IT":"Italian"]
        let Japanese = ["JP":"Japanese"]
        let Jewish = ["IL":"Jewish"]
        let Korean = ["KP":"Korean","KR":"Korean"]
        let LatinAmerican = ["AR":"Latin American","BO":"Latin American","BR":"Latin American","CL":"Latin American","CO":"Latin American","CR":"Latin American","CU":"Latin American","DO":"Latin American","EC":"Latin American","SV":"Latin American","GF":"Latin American","GP":"Latin American","GT":"Latin American","HT":"Latin American","HN":"Latin American","MQ":"Latin American","MX":"Latin American","NI":"Latin American","PA":"Latin American","PY":"Latin American","PE":"Latin American","PR":"Latin American","BL":"Latin American","MF":"Latin American","UY":"Latin American","VE":"Latin American"]
        let Mediterranean = ["MA":"Mediterranean","DZ":"Mediterranean","TN":"Mediterranean","LY":"Mediterranean","EG":"Mediterranean","PS":"Mediterranean","IL":"Mediterranean","LB":"Mediterranean","CY":"Mediterranean","SY":"Mediterranean","TR":"Mediterranean","GR":"Mediterranean","AL":"Mediterranean","ME":"Mediterranean","BA":"Mediterranean","HR":"Mediterranean","SI":"Mediterranean","MT":"Mediterranean","IT":"Mediterranean","MC":"Mediterranean","FR":"Mediterranean","GI":"Mediterranean","ES":"Mediterranean"]
        let Mexican = ["MX":"Mexican"]
        let MiddleEastern = ["BH":"Middle Eastern","EG":"Middle Eastern","IR":"Middle Eastern","IQ":"Middle Eastern","IL":"Middle Eastern","JO":"Middle Eastern","KW":"Middle Eastern","LB":"Middle Eastern","LY":"Middle Eastern","OM":"Middle Eastern","PS":"Middle Eastern","QA":"Middle Eastern","SA":"Middle Eastern","SY":"Middle Eastern","AE":"Middle Eastern","YE":"Middle Eastern"]
        let Nordic = ["DK":"Nordic","FI":"Nordic","IS":"Nordic","NO":"Nordic","SE":"Nordic","GL":"Nordic","FO":"Nordic","SJ":"Nordic","AX":"Nordic"]
        let Southern = ["US":"Southern"]
        let Spanish = ["ES":"Spanish"]
        let Thai = ["TH":"Thai"]
        let Vietnamese = ["VN":"Vietnamese"]
    }
}

