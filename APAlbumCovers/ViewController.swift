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
    
    override func viewDidLoad() {
        
        log.debug("Started!")
        
        super.viewDidLoad()

        self.navigationController?.navigationBar.translucent = false
        currentAlbumIndex = 0
        
        allAlbums = LibraryAPI.sharedInstance.getAlbums()
        
        // 3
        // the uitableview that presents the album data
        dataTable.delegate = self
        dataTable.dataSource = self
        dataTable.backgroundView = nil
        view.addSubview(dataTable!)
        
        self.showDataForAlbum(currentAlbumIndex)
        
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
