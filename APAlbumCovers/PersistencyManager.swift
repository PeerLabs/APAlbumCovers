//
//  PersistencyManager.swift
//  APAlbumCovers
//
//  Created by Abrar Peer on 18/02/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import UIKit

class PersistencyManager: NSObject {
    
    private var albums = [Album]()

    override init() {
        
        log.debug("Started!")
        
        let album1 = Album(title: "Best of Bowie", artist: "David Bowie", genre: "Pop", coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_david_bowie_best_of_bowie.png", year: "1992")
        
        let album2 = Album(title: "It's My Life", artist: "No Doubt", genre: "Pop", coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_no_doubt_its_my_life_bathwater.png", year: "2003")
        
        let album3 = Album(title: "Nothing Like The Sun", artist: "Sting", genre: "Pop", coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_sting_nothing_like_the_sun.png", year: "1999")
        
        let album4 = Album(title: "Staring at the Sun", artist: "U2", genre: "Pop", coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_u2_staring_at_the_sun.png", year: "2000")
        
        let album5 = Album(title: "American Pie", artist: "Madonna", genre: "Pop", coverUrl: "https://s3.amazonaws.com/CoverProject/album/album_madonna_american_pie.png", year: "2000")
        
        albums = [album1, album2, album3, album4, album5]
        
        log.debug("Finished!")
        
    }
    
    
    func getAlbums() -> [Album] {
        
        log.debug("Started!")
        
        log.debug("Finished!")
        
        return albums
        
    }
    
    func addAlbum(album: Album, index: Int) {
        
        log.debug("Started!")
        
        if (albums.count >= index) {
            
            albums.insert(album, atIndex: index)
            
        } else {
            
            albums.append(album)
            
        }
        
        log.debug("Finished!")
        
    }
    
    func deleteAlbumAtIndex(index: Int) {
        
        log.debug("Started!")
        
        albums.removeAtIndex(index)
        
        log.debug("Finished!")
        
    }
    
    func saveImage(image: UIImage, filename: String) {
        
        log.debug("Started!")
        
        let path = NSHomeDirectory().stringByAppendingString("/Documents/\(filename)")
        let data = UIImagePNGRepresentation(image)
        data!.writeToFile(path, atomically: true)
        
        log.debug("Finished!")
        
    }
    
    func getImage(filename: String) -> UIImage? {
        
        log.debug("Started!")
        
        let path = NSHomeDirectory().stringByAppendingString("/Documents/\(filename)")
        
        do {
            
            let data = try NSData(contentsOfFile: path, options: .UncachedRead)
            
            log.debug("Finished!")
            return UIImage(data: data)
            
            
        } catch {
            
            log.error("Error encountered whilst trying to download Image!\nError: \(error)")
            
            log.debug("Finished!")
            return nil
            
        }

        
    }
    
}
