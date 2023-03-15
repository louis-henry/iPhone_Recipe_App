//
//  FavouriteTableViewController.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 10/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import UIKit

class FavouriteTableViewController: UITableViewController {
    
    var viewModel : FavouriteViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        viewModel = FavouriteViewModel(manager: AppDelegate.sharedInstance)
        
    }
    
    // This ensures the table loads every time it is accessed
    override func viewWillAppear(_ animated: Bool) {
        viewModel!.loadFavouriteRecipeData(then: self.tableView.reloadData);
    }
    
    
    @IBAction func unwindFromDetail(_ unwindSegue: UIStoryboardSegue) {
        //Unwinds to here from the detail view
    }
    
    @IBAction func addTapped(_ sender: Any) {
        // Updates table on refresh
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel?.recipeData.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavouriteTableViewCell
        
        let recipeImage = cell.viewWithTag(5000) as? UIImageView
        
        if let recipeImage = recipeImage {
            recipeImage.image = viewModel?.recipeData[indexPath.row].image ?? #imageLiteral(resourceName: "sampleRecipeDetail1")
        }
        cell.recipeName.text = viewModel?.recipeData[indexPath.row].title ?? "No title available"
        cell.recipeDescrip.text = viewModel?.recipeData[indexPath.row].description ?? "No description available"
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt
        indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let action = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completionHandler) in
            
            self.viewModel?.removeFavourite(id: self.viewModel!.recipeData[indexPath.row].id)
            self.viewModel!.loadFavouriteRecipeData(then: self.tableView.reloadData);
        }
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ChooseRecipe"){
            if let detailDestination = (segue.destination as? UINavigationController)?.topViewController as? RecipeDetailViewController{
                if let sendingCell = sender as? UITableViewCell{
                    guard let superView = sendingCell.superview as? UITableView else {
                        return
                    }
                    let indexPath = superView.indexPath(for: sendingCell)
                    detailDestination.recipeId = viewModel?.recipeData[(indexPath?.row)!].id
                    
                }
            }
        }
    }
}
