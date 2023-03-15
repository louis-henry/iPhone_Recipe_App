//
//  RecipeViewController.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 25/9/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

enum RecipeViewType{
    case TableView
    case CollectionView
}

enum RecipeView{
    case byDefault
    case byRegion
    case byTime
    case byCalories
    case byDietary
}

import UIKit

protocol ChangeViewProtocol{
    func changeView(to : RecipeViewType,  _ sender: Any)
    
}

class RecipeViewController: UINavigationController, UIPopoverPresentationControllerDelegate, ChangeViewProtocol {
    
    @IBOutlet var RecipeBarButtonItem: UIBarButtonItem!
    
    var howToDisplay : RecipeView = RecipeView.byDefault;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // sets the table view to display as table/default so that it loads
        changeView(to: .TableView, RecipeView.byDefault)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        for child in self.children {
            if let controller = child as? RecipeTableViewController {
                controller.doReload = true
            }
        }
    }
    
    func changeView(to : RecipeViewType, _ sender: Any){
        switch to {
        case .TableView:
            self.performSegue(withIdentifier: "DisplayRecipesAsTable", sender: sender)
        case .CollectionView:
            self.performSegue(withIdentifier: "DisplayRecipesAsCollection", sender: sender)
        }
    }
    
    @IBAction func ShowPopover(_ sender: Any) {
        self.performSegue(withIdentifier: "ChooseDisplayFormat", sender: sender)
    }

     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Ensure referring to correct segue
        
        if(segue.identifier! == "ChooseDisplayFormat"){
            if let popOverController = segue.destination.popoverPresentationController{
                //Tell the controller of the popover to delegate its events to this controller
                popOverController.delegate = self
            }
            if let dropDownController = segue.destination as? RecipeDropViewController{
                dropDownController.delegate = self
            }
            
        }
        
        if(segue.identifier! == "DisplayRecipesAsTable" || segue.identifier == "DisplayRecipesAsCollection"){
            if let buttonSender = sender as? UIButton{
                switch (buttonSender.titleLabel?.text)!{
                case "Sort By Default":
                    howToDisplay = .byDefault
                case "Sort By Region":
                    howToDisplay = .byRegion
                case "Sort By Time":
                    howToDisplay = .byTime
                case "Sort By Calories":
                    howToDisplay = .byCalories
                case "Sort By Diet":
                    howToDisplay = .byDietary
                default:
                    break;
                }
            }
        }
        
        if(segue.identifier! == "DisplayRecipesAsTable"){
            if let destinationView = segue.destination as? RecipeTableViewController{
                destinationView.sourceCollection = "";
                destinationView.changeViewType(toRecipe: self.howToDisplay)
            }
        }
        
        
        if(segue.identifier! == "DisplayRecipesAsCollection"){
            if let destinationView = segue.destination as? RecipeCollectionViewController{
                destinationView.changeViewType(toRecipe: self.howToDisplay)
            }
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        //Makes the popover drop down on iphones as well as ipads. Remove to make it cover the screen on iphones
        return .none
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
}
