//
//  MGSwipeableViewController.swift
//  SwipeablePageView
//
//  Created by Michael Green on 17/04/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import UIKit

class MGSwipeableViewController: UIViewController {

  let viewControllers: [UIViewController]
  
  @IBOutlet var pageView: MGSwipeablePageView!
  @IBOutlet var pageHeader: MGSwipeablePageHeader!
  
  // MARK: Lifecycle
  
  required init(coder aDecoder: NSCoder) {
    viewControllers = [UIViewController]()
    super.init(coder: aDecoder)
  }
  
  override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
    viewControllers = [UIViewController]()
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    var vc1 = ExampleViewController(nibName: "ExampleViewController", bundle: nil)
    self.addViewController(vc1)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  override func loadView() {
    println(1)
    NSBundle.mainBundle().loadNibNamed("MGSwipeableViewController", owner: self, options: nil)
  }
  
  // MARK: Functional
  
  func addViewController(viewController: UIViewController) {
    self.addChildViewController(viewController)
    viewController.didMoveToParentViewController(self)
    pageView.addSubview(viewController.view)
  }
}
