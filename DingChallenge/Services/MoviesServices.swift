//
//  MoviesServices.swift
//  DingChallenge
//
//  Created by Yasin Akinci on 04/12/2018.
//  Copyright © 2018 Yasin Akinci. All rights reserved.
//

import Foundation
import Alamofire

class MoviesServices{
    
    //MARK: - Methods to fetch Data from the webservice
    func fetchWeatherData(listUrl:String, completion: @escaping (_ result: Movies) -> Void) {
        
        Alamofire.request(listUrl).responseData { response in
            
            if let json = response.result.value {
                do {
                    let movies = try JSONDecoder().decode(Movies.self, from: json)
                    completion(movies)
                }
                catch {
                }
            }
        }
    }
    
}
