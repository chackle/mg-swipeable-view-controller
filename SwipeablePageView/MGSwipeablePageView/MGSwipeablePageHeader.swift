//
//  MGSwipeablePageHeader.swift
//  SwipeablePageView
//
//  Created by Michael Green on 17/04/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import UIKit

class MGSwipeablePageHeader: UIScrollView {

  private var pages: [PageTuple]
  private var currentPosition: Int
  
  override init(frame: CGRect) {
    pages = [PageTuple]()
    currentPosition = 0
    super.init(frame: frame)
  }
  
  required init(coder aDecoder: NSCoder) {
    pages = [PageTuple]()
    currentPosition = 0
    super.init(coder: aDecoder)
  }
  
  func addPages(pages: [PageTuple]) {
    self.pages += pages
    buildButtonViews()
  }
  
  private func buildButtonViews() {
    for var i = 0; i < pages.count; i++ {
      var page = pages[i]
      let buttonFrame = CGRectMake(CGFloat(i) * self.frame.size.width / 3, 0, self.frame.size.width / 3, self.frame.size.height)
      var button = UIButton(frame: buttonFrame)
      self.addSubview(button)
    }
  }
  
  func updateSelectionToPosition(position: Int) {
    currentPosition = position
    animateSelectionToPosition(position)
  }
  
  private func animateSelectionToPosition(position: Int) {
    
  }
}
