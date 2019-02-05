//
//  QueryService.swift
//  NYCHighSchools
//
//  Created by John Edwards on 2/1/19.
//  Copyright © 2019 none. All rights reserved.
//

import Foundation

final class QueryService {
    
    typealias QueryResult = (Data?, String) ->()
    var errorMessage = ""

    
    func dataForURL(_ urlStr: String, completion: @escaping QueryResult ) {
        guard let url = URL(string: urlStr) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                self.errorMessage += "DataTask error " + error.localizedDescription
               // self.data = nil
            } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                //self.data = data
                DispatchQueue.main.async {
                    completion(data, self.errorMessage)
                }
            }
        }
            .resume()
    }
}
