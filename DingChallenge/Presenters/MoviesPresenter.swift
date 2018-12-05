//
//  MoviesPresenter.swift
//  DingChallenge
//
//  Created by Yasin Akinci on 04/12/2018.
//  Copyright © 2018 Yasin Akinci. All rights reserved.
//

import Foundation

class MoviesPresenter{
    
    private let HOST = "https://api.themoviedb.org"
    private let SERVICE = "/3/discover/movie?"
    private let API_KEY_NAME = "api_key="
    private let PAGE_KEY_NAME = "&page="
    private let OTHET_KEY_PARAM = "&language=en-US&sort_by=popularity.desc&include_adult=false&include_video=false"
    private let apiKey = "a874a785f5b47354475d14574a969a7a"
    private var page = 0
    private var listURL: String{
        get{
            page += 1
            return HOST+SERVICE+API_KEY_NAME+apiKey+OTHET_KEY_PARAM+PAGE_KEY_NAME+String(describing: page)
        }
    }
    
    static var imageURL = "http://image.tmdb.org/t/p/w185"
    let moviesServices = MoviesServices()
    
    //MARK: - Init
    init() {
        
    }
    
    func fetchMoviesData (completion: @escaping (_ result: Movies) -> Void) {
        
        moviesServices.fetchWeatherData(listUrl:listURL) { (movie) in
            completion(movie)
        }
        
    }
    
}
