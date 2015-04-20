//
//  MGSwipeableScrollView.swift
//  SwipeablePageView
//
//  Created by Michael Green on 17/04/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation
import UIKit

class MGSwipeablePageView: UIScrollView {
  
  private var pages: [PageTuple]
  var currentOffsetX: CGFloat
  
  override init(frame: CGRect) {
    self.pages = [PageTuple]()
    currentOffsetX = 0
    super.init(frame: frame)
    self.delaysContentTouches = false
    self.showsHorizontalScrollIndicator = false
    self.pagingEnabled = true
  }
  
  required init(coder aDecoder: NSCoder) {
    self.pages = [PageTuple]()
    currentOffsetX = 0
    super.init(coder: aDecoder)
    self.delaysContentTouches = false
    self.showsHorizontalScrollIndicator = false
    self.pagingEnabled = true
  }
  
  func addPages(pages: [PageTuple]) {
    self.pages += pages
    refreshViews()
  }
  
  private func adjustContentSize() {
    let contentWidth = self.frame.size.width * CGFloat(pages.count)
    self.contentSize = CGSizeMake(contentWidth, self.frame.size.height)
  }
  
  private func buildPages() {
    for var i = 0; i < pages.count; i++ {
      var page = pages[i]
      var frame = self.bounds
      frame.origin.x = CGFloat(i) * frame.size.width
      page.viewController.view.frame = frame
      self.addSubview(page.viewController.view)
    }
  }
  
  func refreshViews() {
    for var i = 0; i < self.pages.count; i++ {
      self.pages[i].viewController.view.removeFromSuperview()
    }
    buildPages()
    adjustContentSize()
  }
  
  func snapToPagePosition(pagePosition: CGFloat) {
    var scrollOffset = self.bounds.size.width * pagePosition - self.bounds.size.width
    self.contentOffset.x = scrollOffset
  }
}
