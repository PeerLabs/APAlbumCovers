//
//  ViewController.swift
//  APAlbumCovers
//
//  Created by Abrar Peer on 17/02/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private var allAlbums = [Album]()
    private var currentAlbumData : (titles:[String], values:[String])?
    private var currentAlbumIndex = 0
    
    @IBOutlet var dataTable: UITableView!
    @IBOutlet var toolbar: UIToolbar!
    @IBOutlet weak var scroller: HorizontalScroller!
    
    override func viewDidLoad() {
        
        log.debug("Started!")
        
        super.viewDidLoad()

        self.navigationController?.navigationBar.translucent = false
        currentAlbumIndex = 0
        
        allAlbums = LibraryAPI.sharedInstance.getAlbums()

        // the uitableview that presents the album data
        dataTable.delegate = self
        dataTable.dataSource = self
        dataTable.backgroundView = nil
        view.addSubview(dataTable!)
        
        self.showDataForAlbum(currentAlbumIndex)
        
        scroller.delegate = self
        reloadScroller()
        
        log.debug("Finished!")
        
    }
    
    func showDataForAlbum(albumIndex: Int) {
        
        log.debug("Started!")
        
        // defensive code: make sure the requested index is lower than the amount of albums
        
        if (albumIndex < allAlbums.count && albumIndex > -1) {
        
            //fetch the album
            let album = allAlbums[albumIndex]
            // save the albums data to present it later in the tableview
            currentAlbumData = album.ae_tableRepresentation()
        
        } else {
            
            currentAlbumData = nil
        
        }
        
        // we have the data we need, let's refresh our tableview
        dataTable!.reloadData()
        
        log.debug("Finished!")
        
    }
    
    func reloadScroller() {
        
        log.debug("Started!")
        
        allAlbums = LibraryAPI.sharedInstance.getAlbums()
        
        if currentAlbumIndex < 0 {
            
            currentAlbumIndex = 0
            
        } else if currentAlbumIndex >= allAlbums.count {
            
            currentAlbumIndex = allAlbums.count - 1
            
        }
        
        scroller.reload()
        showDataForAlbum(currentAlbumIndex)
        
        log.debug("Finished!")
        
    }

}

extension ViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        log.debug("Started!")
        
        if let albumData = currentAlbumData {
            
            log.debug("Finished!")
            return albumData.titles.count
        
        } else {
        
            log.debug("Finished!")
            return 0
        
        }
    
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        log.debug("Started!")
        
        let cell:UITableViewCell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
        if let albumData = currentAlbumData {
            
            cell.textLabel!.text = albumData.titles[indexPath.row]
            cell.detailTextLabel!.text = albumData.values[indexPath.row]
            
        }
        
        log.debug("Finished!")
        
        return cell
    
    }
    
}

extension ViewController: UITableViewDelegate {
}

extension ViewController: HorizontalScrollerDelegate {
    
    func numberOfViewsForHorizontalScroller(scroller: HorizontalScroller) -> (Int) {
        
        log.debug("Started!")
        
        log.debug("Finished!")
        
        return allAlbums.count
        
    }
    
    func horizontalScrollerViewAtIndex(scroller: HorizontalScroller, index: Int) -> (UIView) {
        
        log.debug("Started!")
        
        let album = allAlbums[index]
        let albumView = AlbumView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), albumCover: album.coverUrl)
        
        if currentAlbumIndex == index {
            
            albumView.highlightAlbum(true)
            
        } else {
            
            albumView.highlightAlbum(false)
            
        }
        
        log.debug("Finished!")
        
        return albumView
        
    }
    
    func horizontalScrollerClickedViewAtIndex(scroller: HorizontalScroller, index: Int) {
        
        log.debug("Started!")

        let previousAlbumView = scroller.viewAtIndex(currentAlbumIndex) as! AlbumView
        previousAlbumView.highlightAlbum(false)

        currentAlbumIndex = index

        let albumView = scroller.viewAtIndex(index) as! AlbumView
        albumView.highlightAlbum(true)

        showDataForAlbum(index)
        
        log.debug("Finished!")
        
    }

}
