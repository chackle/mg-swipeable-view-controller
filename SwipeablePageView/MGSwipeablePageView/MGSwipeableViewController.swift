//
//  MGSwipeableViewController.swift
//  SwipeablePageView
//
//  Created by Michael Green on 17/04/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import UIKit

typealias PageTuple = (viewController: UIViewController, name: String)

class MGSwipeableViewController: UIViewController, UIScrollViewDelegate, MGSwipeablePageHeaderDelegate {
  
  private var currentPagePosition: CGFloat
  
  var pages: [PageTuple]
  
  @IBOutlet var pageView: MGSwipeablePageView!
  @IBOutlet var pageHeader: MGSwipeablePageHeader!
  
  var pagePosition: CGFloat {
    set {
      currentPagePosition = newValue
      if Int(currentPagePosition) > (pages.count-1) {
        currentPagePosition = CGFloat(pages.count)
      }
      pageView.snapToPagePosition(currentPagePosition)
    }
    get {
      return currentPagePosition
    }
  }
  
  // MARK: Lifecycle
  required init(coder aDecoder: NSCoder) {
    pages = [PageTuple]()
    currentPagePosition = 1
    super.init(coder: aDecoder)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    pages = [PageTuple]()
    currentPagePosition = 1
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    pageView.delegate = self
    pageHeader.delegate = self
    pageHeader.pageDelegate = self
  }
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    self.view.setNeedsLayout()
    self.view.layoutIfNeeded()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func loadView() {
    NSBundle.mainBundle().loadNibNamed("MGSwipeableViewController", owner: self, options: nil)
  }
  
  override func willAnimateRotationToInterfaceOrientation(toInterfaceOrientation: UIInterfaceOrientation, duration: NSTimeInterval) {
    pageHeader.refreshViews()
    pageView.refreshViews()
    pageView.snapToPagePosition(currentPagePosition)
  }
  
  // MARK: UIScrollView Delegate
  func scrollViewDidScroll(scrollView: UIScrollView) {
    if scrollView.isEqual(pageView) {
      let contentOffsetX = scrollView.contentOffset.x
      let headerContentOffsetX = contentOffsetX / 3
      var pageHeaderRect = pageHeader.bounds
      pageHeaderRect.origin.x = headerContentOffsetX
      pageHeader.scrollRectToVisible(pageHeaderRect, animated: false)
    }
    else if scrollView.isEqual(pageHeader) {
      pageHeader.updateDisplayPropertiesForButtons()
    }
  }
  
  func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
    if scrollView.isEqual(pageView) {
      currentPagePosition = (pageView.contentOffset.x / pageView.bounds.width) + 1
    }
  }
  
  // MARK: MGSwipeablePageHeaderDelegate
  func pageHeader(pageHeader: MGSwipeablePageHeader, didSelectPosition position: Int) {
    if pageHeader.isEqual(self.pageHeader) {
      var pageRect = pageView.bounds
      pageRect.origin.x = CGFloat(position) * pageRect.size.width
      pageView.scrollRectToVisible(pageRect, animated: true)
    }
  }
  
  // MARK: Functional
  func addViewControllers(viewControllers: [UIViewController], withTitles titles: [String]) {
    for var i = 0; i < viewControllers.count; i++ {
      addViewController(viewControllers[i], withTitle:titles[i])
    }
    pageHeader.addPages(pages)
    pageView.addPages(pages)
  }
  
  private func addViewController(viewController: UIViewController, withTitle title: String) {
    self.addChildViewController(viewController)
    viewController.didMoveToParentViewController(self)
    pages.append((viewController, title))
  }
}
