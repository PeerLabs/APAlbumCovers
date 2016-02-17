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
    
        initialize()
        
        log.debug("Finished!")
        
        
    }
    
    init(frame: CGRect, albumCover: String) {
        
        log.debug("Started!")
        
        super.init(frame: frame)
        
        initialize()
        
        log.debug("Finished!")
        
    }
    
    func initialize() {
        
        log.debug("Started!")
        
        backgroundColor = UIColor.blackColor()
        coverImage = UIImageView(frame: CGRect(x: 5, y: 5, width: frame.size.width - 10, height: frame.size.height - 10))
        addSubview(coverImage)
        indicator = UIActivityIndicatorView()
        indicator.center = center
        indicator.activityIndicatorViewStyle = .WhiteLarge
        indicator.startAnimating()
        addSubview(indicator)
        
        log.debug("Finished!")
        
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
    
    
}
