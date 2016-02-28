//
//  ViewController.swift
//  Alchemy
//
//  Created by Akash on 17/02/16.
//  Copyright © 2016 Akash. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var iClearContextTapGesture: UITapGestureRecognizer!
    
    @IBOutlet var iDrawView: DrawView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func clearDrawingContext(sender: UIGestureRecognizer) {
        
        self.iDrawView.points.removeAll()
        self.iDrawView.contextImage = nil
        self.iDrawView.setNeedsDisplay()
    }

}

