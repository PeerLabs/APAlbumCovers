//
//  AlbumExtensions.swift
//  APAlbumCovers
//
//  Created by Abrar Peer on 18/02/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import Foundation

extension Album {
    
    func ae_tableRepresentation() -> (titles:[String], values:[String]) {
        
        log.debug("Started!")
        
        log.debug("Finished!")
        
        return (["Artist", "Album", "Genre", "Year"], [artist, title, genre, year])
        
    }
    
}
