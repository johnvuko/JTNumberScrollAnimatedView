//
//  ViewController.swift
//  NumberScrollAnimation
//
//  Created by Jimmy Jose on 18/12/14.
//  Copyright (c) 2014 Varshyl Mobile Pvt. Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var animatedView:VMNumberScrollAnimatedView? = VMNumberScrollAnimatedView?()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.animatedView?.textColor = UIColor.whiteColor()
        
        self.animatedView?.font = UIFont(name: "HelveticaNeue-Bold", size: 42)!
        self.animatedView?.minLenght = 3
        
    }

     @IBAction func start(){
    
        self.animatedView?.setValue(NSNumber(int: rand()%5000))
        self.animatedView?.startAnimation()
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

