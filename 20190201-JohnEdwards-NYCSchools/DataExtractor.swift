//
//  DataExtractor.swift
//  NYCHighSchools
//
//  Created by John Edwards on 2/1/19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

class DataExtractor {
    
    func getSchoolList(_ data: Data) -> [School]? {
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let list = try decoder.decode([School].self, from: data)
            return list.sorted {$0.schoolName < $1.schoolName}
        } catch {
            print(error)
        }
        
        return nil
    }
    
    func getSchoolDetail(_ data: Data, for dbn: String) -> SchDetail? {
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let schoolList = try decoder.decode([SchDetail].self, from: data)
            
            for schoolDetail in schoolList.sorted(by: {$0.dbn < $1.dbn}) {
                if schoolDetail.dbn == dbn {
                    return schoolDetail
                }
            }
            
        } catch {
            print(error)
        }
        
        return nil
    }
    
}
