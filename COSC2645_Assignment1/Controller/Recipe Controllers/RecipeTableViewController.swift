//
//  RecipeTableViewController.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 1/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import UIKit

class RecipeTableViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    var displayViewModels: [RecipeView: ViewModelRecipe]? = nil
    
    var howToDisplay : RecipeView = .byDefault
    
    var numberDisplayed = 0
    
    var doReload = true
    
    var sourceCollection : String? = nil;
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        
        displayViewModels = [.byDefault : ViewModelRecipeByDefault(manager: AppDelegate.sharedInstance), .byTime : ViewModelRecipeByTime(manager: AppDelegate.sharedInstance), .byDietary : ViewModelRecipeByDietary(manager: AppDelegate.sharedInstance), .byRegion : ViewModelRecipeByRegion(manager: AppDelegate.sharedInstance), .byCalories : ViewModelRecipeByCalories(manager: AppDelegate.sharedInstance)]
        
        tableView.delegate = self
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Navigation is handled by the popover
        self.navigationController?.isNavigationBarHidden = true;
        if(doReload) {
            displayViewModels?[howToDisplay]?.loadTableRecipeData(collectionChosen : sourceCollection, wipeFirst : true, then: {
                self.numberDisplayed = 10
                self.tableView.reloadData()
            });
            //doReload = false
        }
        doReload = true
    }
    
    func changeViewType(toRecipe : RecipeView){
        self.howToDisplay = toRecipe;
        //Make it display correctly here
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return displayViewModels?[howToDisplay]?.recipeData.count ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt
        indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeListItem", for: indexPath)

        let recipeListName = cell.viewWithTag(1000) as? UILabel
        let recipeListDescription = cell.viewWithTag(1001) as? UILabel
        let recipeImage = cell.viewWithTag(1002) as? UIImageView
        
        if let recipeListName = recipeListName, let recipeListDescription = recipeListDescription, let recipeImage = recipeImage {
            recipeListName.text = displayViewModels?[howToDisplay]?.recipeData[indexPath.row].title ?? "No title available"
            recipeListDescription.text = displayViewModels?[howToDisplay]?.recipeData[indexPath.row].description ?? "No description available"
            recipeImage.image = displayViewModels?[howToDisplay]?.recipeData[indexPath.row].image ?? #imageLiteral(resourceName: "sampleRecipeDetail1")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let dataSize = displayViewModels?[howToDisplay]?.recipeData.count else{
            return
        }
        if (indexPath.row + 1 == numberDisplayed) {
            displayViewModels?[howToDisplay]?.loadTableRecipeData(collectionChosen : sourceCollection, wipeFirst : false, then: {
                self.numberDisplayed += 10
                self.tableView.beginUpdates()
                var insertedRows : [IndexPath] = []
                for rowNum in 1...((self.displayViewModels?[self.howToDisplay]?.numberToLoad) ?? 1 - 1){
                    insertedRows.append(IndexPath.init(row: dataSize - 1 - rowNum, section: 0))
                }
                self.tableView.insertRows(at: insertedRows, with: .automatic)
                self.tableView.endUpdates()
            });
        }
    }
    
    @IBAction func unwindFromDetail(_ unwindSegue: UIStoryboardSegue) {
        //Unwinds to here from the detail view
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ChooseRecipe"){
            if let detailDestination = (segue.destination as? UINavigationController)?.topViewController as? RecipeDetailViewController{
                if let sendingCell = sender as? UITableViewCell{
                    guard let superView = sendingCell.superview as? UITableView else {
                        return
                    }
                    let indexPath = superView.indexPath(for: sendingCell)
                    doReload = false
                    detailDestination.recipeId = displayViewModels![howToDisplay]?.recipeData[(indexPath?.row)!].id
                }
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

}
