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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector:"downloadImage:", name: "APAlbumDownloadImageNotification", object: nil)
        
        log.debug("Finished!")
        
    }
    
    deinit {
        
        log.debug("Started!")
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
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
    
    
    func downloadImage(notification: NSNotification) {
        
        log.debug("Started!")
        
        let userInfo = notification.userInfo as! [String: AnyObject]
        let imageView = userInfo["imageView"] as! UIImageView?
        let coverUrlString = userInfo["coverUrl"] as! String
        
        if let coverUrl = NSURL(string: coverUrlString) {
            
            //2
            if let imageViewUnWrapped = imageView {
                
                imageViewUnWrapped.image = persistencyManager.getImage(coverUrl.lastPathComponent!)
                
                if imageViewUnWrapped.image == nil {
                    //3
                    
                    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
                        
                        let downloadedImage = self.httpClient.downloadImage(coverUrlString)
                        //4
                        
                        dispatch_sync(dispatch_get_main_queue(), { () -> Void in
                            
                            imageViewUnWrapped.image = downloadedImage
                            self.persistencyManager.saveImage(downloadedImage, filename: coverUrl.lastPathComponent!)
                            
                        })
                        
                    })
                    
                }
                
            }
            
        }
        
        
        
    }

}
