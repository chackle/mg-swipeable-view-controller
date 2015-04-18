//
//  MGSwipeableScrollView.swift
//  SwipeablePageView
//
//  Created by Michael Green on 17/04/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation
import UIKit

class MGSwipeablePageView: UIScrollView, UIScrollViewDelegate {

  override init(frame: CGRect) {
    super.init(frame: frame)
    self.delegate = self
    self.delaysContentTouches = false
    self.showsHorizontalScrollIndicator = false
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.delegate = self
    self.delaysContentTouches = false
    self.showsHorizontalScrollIndicator = false
  }
  
  func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    let numPages = scrollView.contentSize.width / scrollView.frame.size.width
    let position = scrollView.contentOffset.x / scrollView.frame.size.width
    let snapPosition = round(position)
    let snapOffset = (snapPosition * scrollView.frame.size.width)
    let scrollRect = CGRectMake(snapOffset, 0, scrollView.frame.size.width, scrollView.frame.size.height)
    scrollView.scrollRectToVisible(scrollRect, animated: true)
    println(scrollRect)
  }
}
