//
//  ShowData.swift
//  SQLDatabase
//
//  Created by R93 on 20/09/34.
//

import UIKit

class ShowData: UIViewController, UITableViewDelegate, UITableViewDataSource {
   

    @IBOutlet weak var myTable: UITableView!
    var dataS = [User]()
    override func viewDidLoad() {
        super.viewDidLoad()
        myTable.delegate = self
        myTable.dataSource = self
        
        dataS = SQLHelper.shared.retriveAllData()
        myTable.reloadData()
        
        myTable.layer.cornerRadius = 10
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: nil)
        
        cell.textLabel?.text = dataS[indexPath.row].id.description
        cell.detailTextLabel?.text = dataS[indexPath.row].name.description
        return cell
    }
    
}
