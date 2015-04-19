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

  var pages: [PageTuple]
  
  @IBOutlet var pageView: MGSwipeablePageView!
  @IBOutlet var pageHeader: MGSwipeablePageHeader!
  
  // MARK: Lifecycle
  
  required init(coder aDecoder: NSCoder) {
    pages = [PageTuple]()
    super.init(coder: aDecoder)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    pages = [PageTuple]()
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
    var vc1 = ExampleViewController(nibName: "ExampleViewController", bundle: nil)
    var vc2 = ExampleViewController(nibName: "ExampleViewController", bundle: nil)
    var vc3 = ExampleViewController(nibName: "ExampleViewController", bundle: nil)
    var vc4 = ExampleViewController(nibName: "ExampleViewController", bundle: nil)
    var vc5 = ExampleViewController(nibName: "ExampleViewController", bundle: nil)
    vc2.view.backgroundColor = UIColor.blueColor()
    vc3.view.backgroundColor = UIColor.greenColor()
    vc4.view.backgroundColor = UIColor.grayColor()
    vc5.view.backgroundColor = UIColor.purpleColor()
    self.addViewControllers([vc1, vc2, vc3, vc4, vc5], withTitles:["News Feed", "Some List", "Settings", "Profile", "Stuff"])
    pageHeader.addPages(pages)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func loadView() {
    NSBundle.mainBundle().loadNibNamed("MGSwipeableViewController", owner: self, options: nil)
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
  }
  
  func addViewController(viewController: UIViewController, withTitle title: String) {
    self.addChildViewController(viewController)
    var frame = pageView.bounds
    frame.origin.x = getCurrentXOffset()
    viewController.view.frame = frame
    viewController.didMoveToParentViewController(self)
    pageView.addSubview(viewController.view)
    pages.append((viewController, title))
    adjustContentSize()
  }
  
  private func getCurrentXOffset() -> CGFloat {
    let numPages = pages.count
    return CGFloat(numPages) * pageView.bounds.width
  }
  
  private func adjustContentSize() {
    let contentWidth = pageView.frame.size.width * CGFloat(pages.count)
    pageView.contentSize = CGSizeMake(contentWidth, pageView.frame.size.height)
  }
}
