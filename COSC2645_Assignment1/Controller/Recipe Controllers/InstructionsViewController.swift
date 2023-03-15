//
//  InstructionsViewController.swift
//  COSC2645_Assignment1
//
//  Created by Robert Wallace on 26/9/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import UIKit

class InstructionsViewController: BaseViewController, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var recipeTitle: UILabel!
    @IBOutlet weak var recipeStepNumber: UILabel!
    @IBOutlet weak var recipeStepInstructions: UILabel!
    
    @IBOutlet var previousButton: UIButton!
    @IBOutlet var nextButton: UIButton!
    
    var viewModel : ViewModelRecipeInstructions? = nil
    var currentStep = 1
    var recipeId : Int?
    var useHomeData : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ViewModelRecipeInstructions(manager: AppDelegate.sharedInstance)
        self.configView()
    }

    private func configView() {
        for recipe in viewModel!.recipeData{
            if(recipe.id == recipeId){
                recipeTitle.text = recipe.title
            }
        }
        
        tableView.dataSource = self
        guard let id = recipeId,
            let instructions = viewModel?.getRecipeInstructions(id: id, useHomeData: useHomeData) else {
            return
        }
        currentStep = 1
        changeToInstruction(step: currentStep)
        self.setColorForButton(button: previousButton, isEnable: false)
        if instructions.count > 1 {
            self.setColorForButton(button: nextButton, isEnable: true)
        } else {
            self.setColorForButton(button: nextButton, isEnable: false)
        }
        self.tableView.reloadData()

    }

    func setColorForButton(button:UIButton, isEnable:Bool) {
        button.isEnabled = isEnable
        button.setTitleColor(isEnable ? self.view.tintColor : .darkGray, for: .normal)
    }
    
    // provides the view with sample data for testing
    @IBAction func btnNext(_ sender: Any) {
        guard let recipeId = recipeId,
            let instructions = viewModel?.getRecipeInstructions(id: recipeId, useHomeData: useHomeData) else {
            return
        }
        let instructionCount = instructions.count
        
        if (currentStep < instructionCount){
            currentStep += 1
        }
        
        if (currentStep == instructionCount){
            self.setColorForButton(button: nextButton, isEnable: false)
        }
        self.setColorForButton(button: previousButton, isEnable: true)
        changeToInstruction(step: currentStep)
    }
    
    // provides the view with sample data for testing
    @IBAction func btnPrevious(_ sender: Any) {
        
        if (currentStep > 1){
            currentStep -= 1
        }
        
        if (currentStep == 1){
            self.setColorForButton(button: previousButton, isEnable: false)
        }
        self.setColorForButton(button: nextButton, isEnable: true)
        changeToInstruction(step: currentStep)
    }
    
    func changeToInstruction(step : Int){
        guard let recipeId = recipeId,
            let instructions = viewModel?.getRecipeInstructions(id: recipeId, useHomeData: useHomeData) else {
            return
        }
        let instructionCount = instructions.count
        recipeStepNumber.text = "Step \(step) of \(instructionCount)"
        recipeStepInstructions.text = instructions[step - 1]["step"] as? String ?? "No instruction information"
        self.tableView.reloadData()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientListItem", for: indexPath)
        
        let ingredientTitle = cell.viewWithTag(1000) as? UILabel
        
        // fills cells with data for tableView
        if let ingredientTitle = ingredientTitle{
            
            guard let recipeId = recipeId,
                let instructions = viewModel?.getRecipeInstructions(id: recipeId, useHomeData: useHomeData) else {
                    return cell
            }
            
            guard let ingredients = instructions[currentStep - 1]["ingredients"] as? [[String: Any]] else{
                return cell
            }
            
            ingredientTitle.text = ingredients[indexPath.row]["name"] as? String
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let recipeId = recipeId,
            let instructions = viewModel?.getRecipeInstructions(id: recipeId, useHomeData: useHomeData) else {
                return 0
        }
        
        guard let ingredients = instructions[currentStep - 1]["ingredients"] as? [[String: Any]] else{
            return 0
        }
        
        return ingredients.count
    }

}
