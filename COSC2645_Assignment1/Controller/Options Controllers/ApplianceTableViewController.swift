//
//  ApplianceTableViewController.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 11/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import UIKit

class ApplianceTableViewController: UITableViewController {

    
    @IBOutlet weak var activeOven: UISwitch!
    @IBOutlet weak var activeMicrowave: UISwitch!
    @IBOutlet weak var activeStoveTop: UISwitch!
    @IBOutlet weak var activeSteamer: UISwitch!
    @IBOutlet weak var activePressureCooker: UISwitch!
    @IBOutlet weak var activeBlender: UISwitch!
    @IBOutlet weak var activeBBQ: UISwitch!
    @IBOutlet weak var activeAirFryer: UISwitch!
    @IBOutlet weak var activeDeepFryer: UISwitch!
    @IBOutlet weak var activeSousVide: UISwitch!
    
    // Diet Outlets
    @IBOutlet weak var activeGluten: UISwitch!
    @IBOutlet weak var activeKeto: UISwitch!
    @IBOutlet weak var activeVegetarian: UISwitch!
    @IBOutlet weak var activeLacto: UISwitch!
    @IBOutlet weak var activeOvo: UISwitch!
    @IBOutlet weak var activeVegan: UISwitch!
    @IBOutlet weak var activePesce: UISwitch!
    @IBOutlet weak var activePaleo: UISwitch!
    @IBOutlet weak var activePrimal: UISwitch!
    @IBOutlet weak var activeWhole: UISwitch!
    
    var accVM : AccountViewModel? = nil
    
    override func viewDidLoad() {
        accVM = AccountViewModel(manager: AppDelegate.sharedInstance)
        updateButtons()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        updateButtons()
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func updateButtons() {
        let appliances = accVM!.appliances
        let dietaries = accVM!.dietaries
        activeMicrowave.isOn = appliances.microwave
        activeOven.isOn = appliances.oven
        activeStoveTop.isOn = appliances.stoveTop
        activeSteamer.isOn = appliances.steamer
        activePressureCooker.isOn = appliances.pressureCooker
        activeBlender.isOn = appliances.blender
        activeBBQ.isOn = appliances.bbq
        activeAirFryer.isOn = appliances.airFryer
        activeDeepFryer.isOn = appliances.deepFryer
        activeSousVide.isOn = appliances.sousVide
        
        activeGluten.isOn = dietaries.gluten
        activeKeto.isOn = dietaries.keto
        activeVegetarian.isOn = dietaries.vege
        activeLacto.isOn = dietaries.lacto
        activeOvo.isOn = dietaries.ovo
        activeVegan.isOn = dietaries.vegan
        activePesce.isOn = dietaries.pesce
        activePaleo.isOn = dietaries.paleo
        activePrimal.isOn = dietaries.primal
        activeWhole.isOn = dietaries.whole
    }
    
    // Main appliance
    @IBAction func toggleOven(_ sender: Any) {
        checkState(id: self.activeOven, name: "Oven")
    }
    @IBAction func toggleMicrowave(_ sender: Any) {
        checkState(id: activeMicrowave, name: "Microwave")
    }
    @IBAction func toggleStoveTop(_ sender: Any) {
        checkState(id: activeStoveTop, name: "Stovetop")
    }
    @IBAction func toggleSteamer(_ sender: Any) {
        checkState(id: activeSteamer, name: "Steamer")
    }
    @IBAction func togglePressureCooker(_ sender: Any) {
        checkState(id: activePressureCooker, name: "PressureCooker")
    }
    @IBAction func toggleBlender(_ sender: Any) {
        checkState(id: activeBlender, name: "Blender")
    }
    
    // Other appliances
    @IBAction func toggleBBQ(_ sender: Any) {
        checkState(id: activeBBQ, name: "BBQ")
    }
    @IBAction func toggleAirFryer(_ sender: Any) {
        checkState(id: activeAirFryer, name: "AirFryer")
    }
    @IBAction func toggleDeepFryer(_ sender: Any) {
        checkState(id: activeDeepFryer, name: "DeepFryer")
    }
    @IBAction func toggleSousVide(_ sender: Any) {
        checkState(id: activeSousVide, name: "SousVide")
    }
    
    func checkState(id: UISwitch, name: String) {
        if id.isOn {
            print("Active")
            accVM!.updateAppliancePreferences(state: true, name: name)
        } else {
            print("No longer active")
            accVM!.updateAppliancePreferences(state: false, name: name)
        }
    }
    
    // Diet
    @IBAction func toggleKeto(_ sender: Any) {
        checkStateDiet(id: self.activeKeto, name: "keto")
    }
    
    @IBAction func toggleGluten(_ sender: Any) {
        checkStateDiet(id: self.activeGluten, name: "gluten")
    }
    
    @IBAction func toggleVegetarian(_ sender: Any) {
        checkStateDiet(id: self.activeVegetarian, name: "vege")
    }
    @IBAction func toggleLacto(_ sender: Any) {
        checkStateDiet(id: self.activeLacto, name: "lacto")
    }
    @IBAction func toggleOvo(_ sender: Any) {
        checkStateDiet(id: self.activeOvo, name: "ovo")
    }
    @IBAction func toggleVegan(_ sender: Any) {
        checkStateDiet(id: self.activeVegan, name: "vegan")
    }
    @IBAction func togglePesce(_ sender: Any) {
        checkStateDiet(id: self.activePesce, name: "pesce")
    }
    @IBAction func togglePaleo(_ sender: Any) {
        checkStateDiet(id: self.activePaleo, name: "paleo")
    }
    @IBAction func togglePrimal(_ sender: Any) {
        checkStateDiet(id: self.activePrimal, name: "primal")
    }
    @IBAction func toggleWhole(_ sender: Any) {
        checkStateDiet(id: self.activeWhole, name: "whole")
    }
    

    func checkStateDiet(id: UISwitch, name: String) {
        if id.isOn {
            print("Active")
            accVM!.updateDiet(state: true, name: name)
        } else {
            print("No longer active")
            accVM!.updateDiet(state: false, name: name)
        }
    }

}
