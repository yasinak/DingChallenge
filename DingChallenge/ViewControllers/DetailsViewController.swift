//
//  DetailsViewController.swift
//  DingChallenge
//
//  Created by Yasin Akinci on 04/12/2018.
//  Copyright © 2018 Yasin Akinci. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class DetailsViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    var result: Results?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let detailResult = result{
            
            titleLabel.text = detailResult.title
            if let genre = detailResult.genre_ids{
                genreLabel.text = String(describing: genre)
            }
            if let popularity = detailResult.popularity{
                popularityLabel.text =  String(describing: popularity)
            }
            releaseDateLabel.text = detailResult.release_date
            overviewLabel.text = detailResult.overview
            
            if let path = detailResult.poster_path{
                
                let imageUrl = MoviesPresenter.imageURL+path
                
                Alamofire.request(imageUrl).responseImage { [weak self] response in
                    if let image = response.result.value {
                        self?.posterImageView.image = image
                    }
                }
            }
        }
    }

}
