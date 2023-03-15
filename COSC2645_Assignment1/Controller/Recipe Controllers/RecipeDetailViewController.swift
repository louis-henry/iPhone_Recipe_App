//
//  RecipeDetailViewController.swift
//  COSC2645_Assignment1
//
//  Created by Robert Wallace on 2/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import UIKit

class RecipeDetailViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var recipeId : Int?
    var viewModel : ViewModelRecipeDetail?
    let FavouriteSelected = #imageLiteral(resourceName: "star-full")
    let FavouriteUnselected = #imageLiteral(resourceName: "star-empty")
    var isFavourite = false;
    var useHomeData = false
    
    //@IBOutlet weak var TableView: UITableView!
    
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeDescription: UILabel!
    
    @IBOutlet var FavouritesButton: UIButton!
    
    @IBAction func FavouriteRecipe(_ sender: Any) {
        isFavourite = viewModel!.toggleFavouriteRecipe(id: recipeId!)
        
        if(isFavourite){
            FavouritesButton.setImage(FavouriteSelected, for: .normal)
        }else{
            FavouritesButton.setImage(FavouriteUnselected, for: .normal)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModelRecipeDetail(manager: AppDelegate.sharedInstance)
        //self.setupCustomBackButton(isDismiss: true)
        TableView.dataSource = self
        self.TableView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isFavourite = viewModel!.isRecipeFavourite(id: recipeId!);
        
        if(isFavourite){
            FavouritesButton.setImage(FavouriteSelected, for: .normal)
        }else{
            FavouritesButton.setImage(FavouriteUnselected, for: .normal)
        }
        if (useHomeData) {
            if let recipeId = recipeId, let recipe = viewModel?.getHomeRecipeDetails(id: recipeId){
                recipeName.text = recipe.title
                recipeImage.image = recipe.image
                recipeDescription.text = recipe.description
            }
        } else {
            if let recipeId = recipeId, let recipe = viewModel?.getRecipeDetails(id: recipeId){
                recipeName.text = recipe.title
                recipeImage.image = recipe.image
                recipeDescription.text = recipe.description
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.TableView.reloadData()
    }
    
    @IBAction func backPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "goToRecipeSteps"){
            if let stepsDestination = segue.destination as? InstructionsViewController{
                stepsDestination.recipeId = self.recipeId;
                stepsDestination.useHomeData = self.useHomeData
            }
        }
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientsListItem", for: indexPath)
        
        let ingredientTitle = cell.viewWithTag(1012) as? UILabel
        
        if let ingredientTitle = ingredientTitle {
            var ingredients : [[String : Any]]? = []
            if (useHomeData) {
                ingredients = viewModel!.getHomeRecipeDetails(id: recipeId!)?.ingredients
            } else {
                ingredients = viewModel!.getRecipeDetails(id: recipeId!)?.ingredients
            }
            ingredientTitle.text = ingredients![indexPath.row]["originalString"] as? String
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return (viewModel.getRecipeIngredients(title: recipeName!)!).count
        if (useHomeData) {
            return viewModel!.getHomeRecipeDetails(id: recipeId!)!.ingredients.count
        }
        return viewModel!.getRecipeDetails(id: recipeId!)!.ingredients.count
    }
    
}
