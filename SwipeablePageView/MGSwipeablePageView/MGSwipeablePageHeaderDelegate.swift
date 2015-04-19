//
//  MGSwipeablePageHeaderDelegate.swift
//  SwipeablePageView
//
//  Created by Michael Green on 19/04/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import Foundation

protocol MGSwipeablePageHeaderDelegate {
  func pageHeader(pageHeader: MGSwipeablePageHeader, didSelectPosition position: Int)
}
