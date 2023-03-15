//
//  ExploreHomeViewCell.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 25/9/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//
import UIKit

class ExploreHomeViewCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var catagoryLabel: UILabel!
    
    var viewModel : ExploreHomeViewModel?
    var position : Int = 0
    var numOfCells : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collectionView.delegate = self
        collectionView.dataSource = self
        viewModel = ExploreHomeViewModel(manager: AppDelegate.sharedInstance)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}

extension ExploreHomeViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (viewModel?.homeData.count ?? 0)/numOfCells
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ExploreHomeCollectionViewCell
        //cellTest.subCatagory.text = viewModel?.homeSuggestTitles[indexPath.row] ?? "Missing Title"
        //return cellTest
        let recipeImage = cell.viewWithTag(4002) as? UIImageView
        let recipeTitle = cell.viewWithTag(4001) as? UILabel
        let recipeNum = (((viewModel?.homeData.count ?? 0) * position)/numOfCells) + indexPath.row
        cell.id = viewModel!.homeData[recipeNum].id
        if let recipeImage = recipeImage, let recipeTitle = recipeTitle {
            recipeImage.image = viewModel!.homeData[recipeNum].image ?? #imageLiteral(resourceName: "sampleRecipeDetail1")
            recipeTitle.text = viewModel!.homeData[recipeNum].title
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 140, height: 150)
    }
}
