//
//  ViewController.swift
//  BirdInCage
//
//  Created by Alixa Bahena and Jonathan Martin on 10/15/17.
//  Copyright © 2017 Alixa Bahena. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //variables
    var startClicked: Bool = true
    var speed: Double = 1.0
    
    @IBOutlet var startButton: UIButton!
    @IBOutlet var slowButton: UIButton!
    @IBOutlet var fastButton: UIButton!
    @IBOutlet var cageImage: UIImageView!
    @IBOutlet var birdImage: UIImageView!
    @IBOutlet var birdImageCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var cageImageCenterXConstraint: NSLayoutConstraint!
    @IBOutlet var speedLabel: UILabel!
    
    @IBAction func fastButtonPressed(_ sender: Any) {
        
        
        speed -= 0.1
        animateLabelTransitions()
    }
    
    @IBAction func slowButtonPressed(_ sender: Any) {
        speed += 0.1
        animateLabelTransitions()
    }
    
    @IBAction func startButtonPressed(sender: AnyObject)
    {
        
            if (startClicked)
            {
                startButton.setTitle("Stop", for: .normal)
                animateLabelTransitions()
                startClicked = false
            }
            else
            {
                startButton.setTitle("Start", for: .normal)
                birdImage.layer.removeAllAnimations()
                cageImage.layer.removeAllAnimations()
                slowButton.isEnabled = false
                fastButton.isEnabled = false
                self.birdImage.alpha = 0
                self.cageImage.alpha = 1
                startClicked = true
                
            }
       
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        updateOffScreenLabel()
        slowButton.isEnabled = false
        fastButton.isEnabled = false
        cageImage.alpha = 0
        speedLabel.text = "1"
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//       //cageImage.alpha = 0
//    }
    
    func updateOffScreenLabel(){
        let screenWidth = view.frame.width
        cageImageCenterXConstraint.constant = -screenWidth
    }
    
    //function to create animations for labels and label constraints
    func animateLabelTransitions() {
        //test to disable buttons
        if (speed > 0.2) {
            fastButton.isEnabled = true
        } else {
            fastButton.isEnabled = false
        }
        if (speed < 0.9) {
            slowButton.isEnabled = true
        } else {
            slowButton.isEnabled = false
        }
        //force any outstanding layout changes to occur
        speedLabel.text = String(speed)
        view.layoutIfNeeded()
        //Animate the alpha
        //and the center X constraints
        let screenWidth = view.frame.width
        self.cageImageCenterXConstraint.constant = 0
        self.birdImageCenterXConstraint.constant += screenWidth
        
        
        UIView.animate(withDuration: speed,
                       delay: 0.0,
                       options: [.repeat, .autoreverse, .showHideTransitionViews],
                       animations: {
                        self.birdImage.alpha = 0
                        self.cageImage.alpha = 1
                        //self.birdImage.isHidden = true
                        //self.cageImage.isHidden = false;
                        self.view.layoutIfNeeded()
        },
                       completion: { _ in
                        swap(&self.birdImage, &self.cageImage)
                        swap(&self.birdImageCenterXConstraint,  &self.cageImageCenterXConstraint)
                        
                        self.updateOffScreenLabel()
                        self.view.layoutIfNeeded()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

