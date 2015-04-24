//
//  ExampleSwipeableViewController.swift
//  SwipeablePageView
//
//  Created by Michael Green on 21/04/2015.
//  Copyright (c) 2015 Michael Green. All rights reserved.
//

import UIKit

class ExampleSwipeableViewController: MGSwipeableViewController {
  
  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
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
    self.pagePosition = 3
  }
}
