//
//  SchDetail.swift
//  NYCHighSchools
//
//  Created by John Edwards on 2/1/19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

struct SchDetail : Decodable {
    let dbn : String
    let schoolName : String
    let numOfSatTestTakers : String
    let satCriticalReadingAvgScore : String
    let satMathAvgScore : String
    let satWritingAvgScore : String
}
