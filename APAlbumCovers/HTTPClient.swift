//
//  HTTPClient.swift
//  APAlbumCovers
//
//  Created by Abrar Peer on 17/02/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import Foundation
import UIKit

class HTTPClient {
    
    func getRequest(url: String) -> (AnyObject) {
        return NSData()
    }
    
    func postRequest(url: String, body: String) -> (AnyObject){
        return NSData()
    }
    
    func downloadImage(url: String) -> (UIImage) {
        let aUrl = NSURL(string: url)
        let data = NSData(contentsOfURL: aUrl!)
        let image = UIImage(data: data!)
        return image!
    }
    
}
