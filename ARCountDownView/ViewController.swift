//
//  ViewController.swift
//  ARCountDownView
//
//  Created by Yufei Tang on 2015-04-30.
//  Copyright (c) 2015 Yufei Tang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ARCountDownViewDelegate {

    @IBOutlet weak var countdownView: ARCountDownView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        countdownView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func startCountDown(sender: AnyObject) {
        countdownView.startAnimation()
    }
    
    @IBAction func pauseCountDown(sender: AnyObject) {
        countdownView.pauseAnimation()
    }
    
    
    
    func countDownView(countDownView: ARCountDownView, timeElapsed second: UInt, didFinish flag: Bool) {
        println("Second elapsed: \(second)s. Countdown finished: \(flag)")
        if flag {
            UIAlertView(title: "Alert", message: "Countdown finishes!", delegate: nil, cancelButtonTitle: "OK").show()
        }
    }

}

