//
//  DataTableViewController.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 2/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import UIKit

class TipsDataTableViewController: UITableViewController {

    var viewModel : TipsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = TipsViewModel(manager: AppDelegate.sharedInstance)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel!.tipData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.detailTextLabel?.text = viewModel!.tipData[indexPath.row].tip_content
        cell.textLabel?.text = viewModel!.tipData[indexPath.row].tip_name

        return cell
    }
    
}
