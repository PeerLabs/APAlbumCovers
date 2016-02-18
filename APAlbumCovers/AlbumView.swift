//
//  AlbumView.swift
//  APAlbumCovers
//
//  Created by Abrar Peer on 18/02/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import UIKit
import XCGLogger

class AlbumView: UIView {

    private var coverImage: UIImageView!
    
    private var indicator: UIActivityIndicatorView!
    
    required init?(coder aDecoder: NSCoder) {
        
        log.debug("Started!")
        
        super.init(coder: aDecoder)
    
        initializeAlbumView()
        
        log.debug("Finished!")
        
        
    }
    
    init(frame: CGRect, albumCover: String) {
        
        log.debug("Started!")
        
        super.init(frame: frame)
        
        initializeAlbumView()
        
        NSNotificationCenter.defaultCenter().postNotificationName("APAlbumDownloadImageNotification", object: self, userInfo: ["imageView":coverImage, "coverUrl" : albumCover])
        
        log.debug("Finished!")
        
    }
    
    func initializeAlbumView() {
        
        log.debug("Started!")
        
        backgroundColor = UIColor.blackColor()
        coverImage = UIImageView(frame: CGRect(x: 5, y: 5, width: frame.size.width - 10, height: frame.size.height - 10))
        addSubview(coverImage)
        coverImage.addObserver(self, forKeyPath: "image", options: .New, context: nil)
        
        indicator = UIActivityIndicatorView()
        indicator.center = center
        indicator.activityIndicatorViewStyle = .WhiteLarge
        indicator.startAnimating()
        addSubview(indicator)
        
        log.debug("Finished!")
        
    }
    
    deinit {
        
        log.debug("Started!")
        
        log.debug("Finished!")
        
        coverImage.removeObserver(self, forKeyPath: "image")
    
    }
    
    func highlightAlbum(didHighlightView: Bool) {
        
        log.debug("Started!")
        
        if didHighlightView == true {
            
            backgroundColor = UIColor.whiteColor()
            
        } else {
            
            backgroundColor = UIColor.blackColor()
            
        }
        
        log.debug("Finished!")
        
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        
        log.debug("Started!")
        
        if keyPath == "image" {
            indicator.stopAnimating()
        }
        
        log.debug("Finished!")
        
    }
    
}
