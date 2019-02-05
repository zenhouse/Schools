//
//  DetailViewController.swift
//  NYCHighSchools
//
//  Created by John Edwards on 11/19/18.
//  Copyright © 2018 none. All rights reserved.
//

import UIKit



class DetailViewController: UIViewController {

    private let urlStr = "https://data.cityofnewyork.us/resource/734v-jeq5.json"
    var dbn = String()
    
    @IBOutlet weak var mathScore: UILabel!
    @IBOutlet weak var rdScore: UILabel!
    @IBOutlet weak var wrScore: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // update detail info for school
        updateSchDetail()
    }
    
    func updateLabels( _ math: String?, _ reading: String?, _ writing: String? ) {
        self.mathScore.text = math ?? "No Data"
        self.rdScore.text = reading ?? "No Data"
        self.wrScore.text = writing ?? "No Data"
    }
    
    // Mark: - updateSchools
    func updateSchDetail() {
        // first init labels to default values
        updateLabels(nil, nil, nil)
        
        // get details from URL
        let service = QueryService()
        service.dataForURL(urlStr) { data, error in
            guard error.isEmpty else {
                print(error)
                return
            }
            
            // extract details from JSON data
            DispatchQueue.global().async { [unowned self] in
                if let data = data {
                    let extractor = DataExtractor()
                    if let detail = extractor.getSchoolDetail(data, for: self.dbn) {
                        DispatchQueue.main.async {
                            self.updateLabels(detail.satMathAvgScore, detail.satCriticalReadingAvgScore, detail.satWritingAvgScore)
                        }
                    }
                }
            }
        }
    }
}
