//
//  MovieModel.swift
//  MovieBrowser
//
//  Created by Vinayak on 23/09/18.
//  Copyright © 2018 Vinayak. All rights reserved.
//

import Foundation

struct MovieModel{
    
    var movie_name = String()
    var movie_image = String()
   
    init()
    {
        
    }
    
    init(movieJson:[String:Any]){
        
        if let movieName = movieJson["title"] as? String{
            
            self.movie_name = movieName
        }
        
        if let movieImage = movieJson["backdrop_path"] as? String{
            self.movie_image = movieImage
        }
        
       
    }
    
}
