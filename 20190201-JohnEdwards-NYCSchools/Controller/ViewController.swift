//
//  ViewController.swift
//  NYCHighSchools
//
//  Created by John Edwards on 1/31/18.
//  Copyright © 2019 none. All rights reserved.
//

import UIKit

class ViewController : UIViewController {

    private let urlStr = "https://data.cityofnewyork.us/resource/97mf-9njv.json"
    var schools = [School]()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // get a list of schools
        updateSchools()
    }

    // Mark: - updateSchools
    func updateSchools() {
        let service = QueryService()
        service.dataForURL(urlStr) { data, error in
            guard error.isEmpty else {
                print(error)
                return
            }
            
            DispatchQueue.global().async { [unowned self] in
                if let data = data {
                    let extractor = DataExtractor()
                    if let schools = extractor.getSchoolList(data) {
                        self.schools = schools
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }
            }
        }
    }
}

// MARK: - Datasource, Delegate functions
extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return schools.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Configure the cell...
        let cell = tableView.dequeueReusableCell(withIdentifier: "NYCCell", for: indexPath)
        let text = self.schools[indexPath.row].schoolName
        cell.textLabel?.text = text
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "SchoolDetailsSeg", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        if let indexPath = self.tableView.indexPathForSelectedRow {
            detailVC.dbn = self.schools[indexPath.row].dbn
        }
    }
}
