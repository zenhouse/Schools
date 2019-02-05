//
//  TableViewCell.swift
//  20190201-JohnEdwards-NYCSchools
//
//  Created by John Edwards on 2/1/19.
//  Copyright © 2019 John Edwards. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    func configure(school: School) {
        self.textLabel?.text = school.schoolName
    }

}
