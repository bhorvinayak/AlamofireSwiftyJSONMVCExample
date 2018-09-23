//
//  MovieListViewController.swift
//  MovieBrowser
//
//  Created by Vinayak on 23/09/18.
//  Copyright © 2018 Vinayak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher
class MovieListViewController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{

    @IBOutlet weak var movieListCollectionView: UICollectionView!
    
    var movieData = [MovieModel]()
    override func viewDidLoad() {
        super.viewDidLoad()

    movieListCollectionView.delegate = self
    movieListCollectionView.dataSource = self
    fetchJSONData()
        
    }

    
    
    func fetchJSONData(){
        
        let urlString = "https://api.themoviedb.org/3/trending/all/day?api_key=d0f37000982da586903503b7509fc921"
        
        Alamofire.request(urlString, method: .get).validate().responseJSON { (response) -> Void in
            if let value = response.data {
                do {
                    let json = try JSON(data: value)
                    if let dictionnary = json.dictionaryObject {
                        if let messageArray = dictionnary["results"] as? [[String: Any]] {
                            for arr in messageArray {
                                
                                self.movieData.append(MovieModel(movieJson: arr))
                                print("print movieData count array  \(self.movieData.count)")
                                print("movieName : \(self.movieData[0].movie_name)")
                                
                                DispatchQueue.main.async {
                                    
                                   self.movieListCollectionView.reloadData()
                                }
                                
                                
                            }
                            
                        }
                        
                    }
                    
                }catch {
                    print("cannot convert to Json")
                }
            }
            
            
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return movieData.count
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as! MovieListCollectionViewCell
        
        cell.movieNameLbl.text = "\(movieData[indexPath.item].movie_name)"
        
        cell.movieImageView.kf.setImage(with: URL(string:"http://image.tmdb.org/t/p/w185/\(self.movieData[indexPath.item].movie_image)"))
        //cell.matchProfileImageView.kf.setImage(with: URL(string:self.matchProfileChatData[0].profileMatchUserData[indexPath.row].profileImage))
       
        return cell
        
    }
    
    
    
}
