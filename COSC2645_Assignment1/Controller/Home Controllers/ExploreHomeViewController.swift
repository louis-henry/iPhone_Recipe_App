//
//  ExploreHomeViewController.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 25/9/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//
import UIKit

class ExploreHomeViewController: BaseViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel : ExploreHomeViewModel? = nil
    var childCells : [ExploreHomeViewCell] = []
    let numOfCells : Int = 3
    let headings : [String] = ["Check these out!", "...Here's some more", "What about these ones?"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ExploreHomeViewModel(manager: AppDelegate.sharedInstance)
        viewModel!.loadHomeData(then: {
            for childCell in self.childCells {
                childCell.collectionView.reloadData()
            }
        });
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "ChooseRecipe"){
            if let detailDestination = (segue.destination as? UINavigationController)?.topViewController as? RecipeDetailViewController{
                if let sendingCell = sender as? ExploreHomeCollectionViewCell{
                    detailDestination.recipeId = sendingCell.id
                    detailDestination.useHomeData = true
                }
            }
        }
    }
    
    @IBAction func unwindFromDetail(_ unwindSegue: UIStoryboardSegue) {
    }
}

extension ExploreHomeViewController: UITableViewDelegate,
UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numOfCells
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let ExploreHomeViewCell = tableView.dequeueReusableCell(withIdentifier: "ExploreHomeViewCell1", for: indexPath) as? ExploreHomeViewCell else {fatalError("Unable to create explore home view cell")}
        ExploreHomeViewCell.catagoryLabel.text = headings[indexPath.row]
        self.childCells.append(ExploreHomeViewCell)
        ExploreHomeViewCell.position = indexPath.row
        ExploreHomeViewCell.numOfCells = self.numOfCells
        return ExploreHomeViewCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt
        indexPath: IndexPath) -> CGFloat {
        return 250
    }
    
}

