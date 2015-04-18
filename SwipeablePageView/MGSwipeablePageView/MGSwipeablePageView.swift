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
    self.pagingEnabled = true
  }
  
  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.delegate = self
    self.delaysContentTouches = false
    self.showsHorizontalScrollIndicator = false
    self.pagingEnabled = true
  }
  
  func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    
  }
}
