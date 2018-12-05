//
//  HomeTableViewController.swift
//  DingChallenge
//
//  Created by Yasin Akinci on 04/12/2018.
//  Copyright © 2018 Yasin Akinci. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HomeTableViewController: UITableViewController {

    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var results = [Results]()
    var isWaitingData = false
    private var moviePresenter = MoviesPresenter()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"

        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.register(UINib(nibName: "MovieTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieTableViewCell")

        self.fetchData()
    }
    
    func fetchData(){
        moviePresenter.fetchMoviesData { [weak self] (movies) in
            if let _results = movies.results{
                self?.results += _results
            }
            self?.isWaitingData = false
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - UIScrollView data source
    //  to detect the bottom of the screen
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let isReachingEnd = scrollView.contentOffset.y >= 0
            && scrollView.contentOffset.y >= (scrollView.contentSize.height - scrollView.frame.size.height)
        
        if isWaitingData == false && isReachingEnd{
            isWaitingData = true
            self.fetchData()
        }
        
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.results.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell", for: indexPath) as! MovieTableViewCell
        
        let result = results[indexPath.row]
     
        cell.titleLabel.text = result.title
        cell.dateLabel.text = result.release_date
        if let popularity = result.popularity{
            cell.popularityLabel.text =  String(describing: popularity)
        }
        if let path = result.poster_path{
         
            let imageUrl = MoviesPresenter.imageURL+path
            
            Alamofire.request(imageUrl).responseImage {[weak cell] response in
                if let image = response.result.value {
                    cell?.thumbnailImageView.image = image
                }
            }
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let detailsViewController = DetailsViewController(nibName: "DetailsViewController", bundle: nil)
        detailsViewController.result = results[indexPath.row]
        self.navigationController?.pushViewController(detailsViewController, animated: true)
    }

    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

     }

}
