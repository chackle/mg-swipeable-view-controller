//
//  MGSwipeablePageHeader.swift
//  SwipeablePageView
//
//  Created by Michael Green on 17/04/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import UIKit

class MGSwipeablePageHeader: UIScrollView {

  typealias PageHeaderPair = (page: PageTuple, button: UIButton)
  
  private var pages: [PageTuple]
  private var pageHeaderPairs: [PageHeaderPair]
  private var currentPosition: Int
  
  var lowerAlpha = CGFloat(0.3)
  var higherAlpha = CGFloat(1)
  
  var pageDelegate: MGSwipeablePageHeaderDelegate?
  
  override init(frame: CGRect) {
    pages = [PageTuple]()
    pageHeaderPairs = [PageHeaderPair]()
    currentPosition = 0
    super.init(frame: frame)
    self.pagingEnabled = true
    self.showsHorizontalScrollIndicator = false
    self.scrollEnabled = false
  }
  
  required init(coder aDecoder: NSCoder) {
    pages = [PageTuple]()
    pageHeaderPairs = [PageHeaderPair]()
    currentPosition = 0
    super.init(coder: aDecoder)
    self.pagingEnabled = true
    self.showsHorizontalScrollIndicator = false
    self.scrollEnabled = false
  }
  
  func addPages(pages: [PageTuple]) {
    self.pages += pages
    buildButtonViews()
  }
  
  override func layoutSubviews() {
    updateDisplayPropertiesForButtons()
  }
  
  private func buildButtonViews() {
    for var i = 0; i < pages.count; i++ {
      var page = pages[i]
      let buttonFrame = CGRectMake(CGFloat(i) * self.frame.size.width / 3 + (self.frame.size.width / 3), 10, self.frame.size.width / 3, self.frame.size.height)
      var button = UIButton(frame: buttonFrame)
      button.setTitle(pages[i].name, forState: UIControlState.Normal)
      button.addTarget(self, action: "didPressButton:", forControlEvents: UIControlEvents.TouchUpInside)
      button.titleLabel?.font = UIFont.systemFontOfSize(22)
      self.addSubview(button)
      pageHeaderPairs.append((page, button))
    }
    
    self.contentSize = CGSizeMake(CGFloat(pages.count + 2) * self.frame.size.width / 3, self.frame.size.height)
  }
  
  func didPressButton(sender: UIButton!) {
    let position = getPositionForButton(sender)
    if let unwrappedDelegate = pageDelegate, unwrappedPosition = position {
      unwrappedDelegate.pageHeader(self, didSelectPosition: unwrappedPosition)
    }
  }
  
  private func getPositionForButton(button: UIButton) -> Int? {
    for var i = 0; i < pages.count; i++ {
      if pageHeaderPairs[i].button.isEqual(button) {
        return i
      }
    }
    return nil
  }
  
  private func getPageForButton(button: UIButton) -> PageTuple? {
    for var i = 0; i < pages.count; i++ {
      if pageHeaderPairs[i].button.isEqual(button) {
        return pageHeaderPairs[i].page
      }
    }
    return nil
  }
  
  func updateDisplayPropertiesForButtons() {
    var qualifyingWidth = self.bounds.size.width
    var centerPointX = self.bounds.size.width / 2 + self.contentOffset.x
    let lowerPointX = self.contentOffset.x
    let upperPointX = self.contentOffset.x + qualifyingWidth
    
    for var i = 0; i < pageHeaderPairs.count; i++ {
      var button = pageHeaderPairs[i].button
      var alpha = CGFloat(1)
      
      if button.center.x < centerPointX {
        var lowerSegment = centerPointX - lowerPointX
        var buttonPosition = button.frame.origin.x - lowerPointX
        alpha = buttonPosition / lowerSegment
      }
      else if button.center.x > centerPointX {
        var upperSegment = upperPointX - centerPointX
        var buttonPosition =  upperPointX - (button.frame.origin.x + button.frame.size.width)
        alpha = buttonPosition / upperSegment
      }
      
      if alpha < lowerAlpha {
        alpha = lowerAlpha
      }
      
      button.alpha = alpha
    }
  }
}
