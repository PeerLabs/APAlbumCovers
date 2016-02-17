//
//  LibraryAPI.swift
//  APAlbumCovers
//
//  Created by Abrar Peer on 18/02/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import UIKit

class LibraryAPI: NSObject {
    
    class var sharedInstance: LibraryAPI {
        
        log.debug("Started!")

        struct Singleton {

            static let instance = LibraryAPI()
            
        }

        log.debug("Finished!")
        
        return Singleton.instance
        
    }

}
