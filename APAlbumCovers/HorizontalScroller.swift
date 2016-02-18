//
//  HorizontalScroller.swift
//  APAlbumCovers
//
//  Created by Abrar Peer on 18/02/2016.
//  Copyright © 2016 peerlabs. All rights reserved.
//

import UIKit

@objc protocol HorizontalScrollerDelegate {
    
    // ask the delegate how many views it wants to present inside the horizontal scroller
    func numberOfViewsForHorizontalScroller(scroller: HorizontalScroller) -> Int
    
    // ask the delegate to return the view that should appear at <index>
    func horizontalScrollerViewAtIndex(scroller: HorizontalScroller, index:Int) -> UIView
    
    // inform the delegate what the view at <index> has been clicked
    func horizontalScrollerClickedViewAtIndex(scroller: HorizontalScroller, index:Int)
    
    // ask the delegate for the index of the initial view to display. This method is optional
    // and defaults to 0 if it's not implemented by the delegate
    optional func initialViewIndex(scroller: HorizontalScroller) -> Int
    
}

class HorizontalScroller: UIView {
    
    private let VIEW_PADDING = 10
    private let VIEW_DIMENSIONS = 100
    private let VIEWS_OFFSET = 100

    private var scroller : UIScrollView!

    var viewArray = [UIView]()
    
    weak var delegate: HorizontalScrollerDelegate?
    
    override init(frame: CGRect) {
        
        log.debug("Started!")
        
        super.init(frame: frame)
        initializeScrollView()
        
        log.debug("Finished!")
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        log.debug("Started!")
        
        super.init(coder: aDecoder)
        initializeScrollView()
        
        log.debug("Finished!")
        
    }
    
    func initializeScrollView() {
        
        log.debug("Started!")

        scroller = UIScrollView()
        addSubview(scroller)
        
        scroller.translatesAutoresizingMaskIntoConstraints = false

        //scroller.setTranslatesAutoresizingMaskIntoConstraints(false)
        
        scroller.delegate = self
        
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .Leading, relatedBy: .Equal, toItem: self, attribute: .Leading, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .Trailing, relatedBy: .Equal, toItem: self, attribute: .Trailing, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0.0))
        self.addConstraint(NSLayoutConstraint(item: scroller, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.0))

        let tapRecognizer = UITapGestureRecognizer(target: self, action:Selector("scrollerTapped:"))
        scroller.addGestureRecognizer(tapRecognizer)
        
        log.debug("Finished!")
        
    }
    
    func scrollerTapped(gesture: UITapGestureRecognizer) {
        
        log.debug("Started!")
        
        let location = gesture.locationInView(gesture.view)
        
        if let delegate = delegate {
            
            for index in 0..<delegate.numberOfViewsForHorizontalScroller(self) {
                
                let view = scroller.subviews[index] as UIView
                
                if CGRectContainsPoint(view.frame, location) {
                    
                    delegate.horizontalScrollerClickedViewAtIndex(self, index: index)
                    scroller.setContentOffset(CGPoint(x: view.frame.origin.x - self.frame.size.width/2 + view.frame.size.width/2, y: 0), animated:true)
                    
                    log.debug("Finished!")
                    
                    break
                    
                }
            }
        }
        
        log.debug("Finished!")
    }
    
    func viewAtIndex(index :Int) -> UIView {
        
        log.debug("Started!")

        log.debug("Finished!")

        return viewArray[index]
        
    }

    
    func reload() {
        
        log.debug("Started!")
        
        // Check if there is a delegate, if not there is nothing to load.
        if let delegate = delegate {
            
            //Will keep adding new album views on reload, need to reset.
            viewArray = []
            let views: NSArray = scroller.subviews
            
            //remove all subviews
            for view in views {
                
                view.removeFromSuperview()
                
            }
            
            //xValue is the starting point of the views inside the scroller
            var xValue = VIEWS_OFFSET
            
            for index in 0..<delegate.numberOfViewsForHorizontalScroller(self) {
                
                //add a view at the right position
                xValue += VIEW_PADDING
                let view = delegate.horizontalScrollerViewAtIndex(self, index: index)
                view.frame = CGRectMake(CGFloat(xValue), CGFloat(VIEW_PADDING), CGFloat(VIEW_DIMENSIONS), CGFloat(VIEW_DIMENSIONS))
                scroller.addSubview(view)
                xValue += VIEW_DIMENSIONS + VIEW_PADDING
                
                //Store the view so we can reference it later
                viewArray.append(view)
                
            }
            
            scroller.contentSize = CGSizeMake(CGFloat(xValue + VIEWS_OFFSET), frame.size.height)
            
            //If an initial view is defined, center the scroller on it
            if let initialView = delegate.initialViewIndex?(self) {
                
                scroller.setContentOffset(CGPoint(x: CGFloat(initialView)*CGFloat((VIEW_DIMENSIONS + (2 * VIEW_PADDING))), y: 0), animated: true)
                
            }
            
        }
        
        log.debug("Finished!")
        
    }
    
    
    override func didMoveToSuperview() {
        
        log.debug("Started!")
        
        log.debug("Finished!")
        
        reload()
        
    }
    
    func centerCurrentView() {
        
        log.debug("Started!")
        
        var xFinal = Int(scroller.contentOffset.x) + (VIEWS_OFFSET/2) + VIEW_PADDING
        
        let viewIndex = xFinal / (VIEW_DIMENSIONS + (2*VIEW_PADDING))
        xFinal = viewIndex * (VIEW_DIMENSIONS + (2*VIEW_PADDING))
        
        scroller.setContentOffset(CGPoint(x: xFinal, y: 0), animated: true)
        
        if let delegate = delegate {
            
            delegate.horizontalScrollerClickedViewAtIndex(self, index: Int(viewIndex))
        
        }
        
        log.debug("Finished!")
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}

extension HorizontalScroller: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        
        log.debug("Started!")
        
        if !decelerate {
            
            centerCurrentView()
            
        }
        
        log.debug("Finished!")
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        log.debug("Started!")
        
        log.debug("Finished!")
        
        centerCurrentView()
        
    }
    
}
