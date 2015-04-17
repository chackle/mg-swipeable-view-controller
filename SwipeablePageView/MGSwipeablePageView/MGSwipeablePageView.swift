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
    self.delegate = self;
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.delegate = self;
  }
  
  func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    var snapOffset = Int(scrollView.contentOffset.x) / 320
    let scrollRect = CGRectMake(CGFloat(snapOffset), 0, scrollView.frame.size.width, scrollView.frame.size.height)
    scrollView.scrollRectToVisible(scrollRect, animated: false)
    println(snapOffset)
  }
}
