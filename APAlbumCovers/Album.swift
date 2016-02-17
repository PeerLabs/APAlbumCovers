//
//  Album.swift
//  APAlbumCovers
//
//  Created by Abrar Peer on 18/02/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import UIKit
import XCGLogger

class Album: NSObject {
    
    var title : String!
    var artist : String!
    var genre : String!
    var coverUrl : String!
    var year : String!
    
    init(title: String, artist: String, genre: String, coverUrl: String, year: String) {
        
        log.debug("Started!")
        
        super.init()
        
        self.title = title
        self.artist = artist
        self.genre = genre
        self.coverUrl = coverUrl
        self.year = year
        
        log.debug("Finished!")
        
    }
    
    override var description: String {
        
        log.debug("Started!")
        
        log.debug("Finished!")
        
        return "title: \(title)" + "artist: \(artist)" + "genre: \(genre)" + "coverUrl: \(coverUrl)" + "year: \(year)"
        
    }
    

}
