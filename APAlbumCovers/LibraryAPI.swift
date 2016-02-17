//
//  LibraryAPI.swift
//  APAlbumCovers
//
//  Created by Abrar Peer on 18/02/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import UIKit

class LibraryAPI: NSObject {
    
    private let persistencyManager: PersistencyManager
    private let httpClient: HTTPClient
    private let isOnline: Bool
    
    class var sharedInstance: LibraryAPI {
        
        log.debug("Started!")

        struct Singleton {

            static let instance = LibraryAPI()
            
        }

        log.debug("Finished!")
        
        return Singleton.instance
        
    }
    
    
    override init() {
        
        log.debug("Started!")
        
        persistencyManager = PersistencyManager()
        httpClient = HTTPClient()
        isOnline = false
        
        super.init()
        
        log.debug("Finished!")
        
    }
    
    
    func getAlbums() -> [Album] {
        
        log.debug("Started!")
        
        log.debug("Finished!")
        
        return persistencyManager.getAlbums()
        
    }
    
    func addAlbum(album: Album, index: Int) {
        
        log.debug("Started!")
        
        persistencyManager.addAlbum(album, index: index)
        
        if isOnline {
            
            httpClient.postRequest("/api/addAlbum", body: album.description)
        
        }
        
        log.debug("Finished!")
        
    }
    
    func deleteAlbum(index: Int) {
        
        log.debug("Started!")
        
        persistencyManager.deleteAlbumAtIndex(index)
        
        if isOnline {
            
            httpClient.postRequest("/api/deleteAlbum", body: "\(index)")
            
        }
        
        log.debug("Finished!")
        
    }
    

}
