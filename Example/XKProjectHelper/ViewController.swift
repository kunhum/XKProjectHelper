//
//  ViewController.swift
//  XKProjectHelper
//
//  Created by kunhum on 05/26/2020.
//  Copyright (c) 2020 kunhum. All rights reserved.
//

import UIKit
import XKProjectHelper

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        XKLog(123)
        XKLog(XK_SYSTEM_VERSION)
        
        XK_GlobalThread {
            XKLog(Thread.current)
        }
        
        print(XK_IS_IPHONEX_SERIES)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
