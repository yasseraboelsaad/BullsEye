//
//  ViewController.swift
//  BullsEye
//
//  Created by Yasser Abouel-Saad on 8/4/17.
//  Copyright © 2017 Yasser Abouel-Saad. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var currentValue: Int!
    @IBOutlet var slider: UISlider!
    @IBOutlet var targValue: UILabel!
    @IBOutlet var lbScore: UILabel!
    @IBOutlet var lbLevel: UILabel!
    var targetValue: Int = 0
    var score: Int = 0
    var level: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let sliderThumbImageNorm = "SliderThumb-Normal"
        let image = UIImage(named: sliderThumbImageNorm)
        slider.setThumbImage(image, for: .normal)
        let sliderThumbImageHigh = "SliderThumb-Highlighted"
        let image2 = UIImage(named: sliderThumbImageHigh)
        slider.setThumbImage(image2, for: .highlighted)
        
        let sliderMinTrack = "SliderTrackRight"
        var image3: UIImage = UIImage(named: sliderMinTrack)!
        let myInsets : UIEdgeInsets = UIEdgeInsetsMake(0, 16, 0, 16)
        image3 = image3.resizableImage(withCapInsets: myInsets)
        slider.setMaximumTrackImage(image3, for: .normal)

        let sliderMaxTrack = "SliderTrackLeft"
        var image4: UIImage = UIImage(named: sliderMaxTrack)!
        image4 = image4.resizableImage(withCapInsets: myInsets)
        slider.setMinimumTrackImage(image4, for: .normal)

        startNewRound()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAlert(){
        let diff = abs(targetValue-currentValue)
        var points = 0
        var message = ""
        if diff == 0 {
            points = 100
            message = "Perfect!"
        }else if diff < 5 {
            points = 50
            message = "You almost had it!"
        }else if diff <= 10{
            message = "Pretty good!"
        } else{
            message = "Not even close..."
        }
        points = points + 100 - diff
        score = score+points
        let cv = currentValue!
        let alert = UIAlertController(title: nil, message: message + "\nYou have scored: \(points) points" +
            "\nyour value is \(cv)"+"\nyour target is \(targetValue)", preferredStyle: .alert)
        let action = UIAlertAction(title:"OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
        startNewRound()
    }
    
    @IBAction func sliderMoved(_ slider: UISlider){
        currentValue = lroundf(slider.value)
        print("The value of the slider is now \(currentValue)")
    }
    
    func startNewRound(){
        targetValue = 1 + Int(arc4random_uniform(100))
        level = level+1
        targValue.text = String(targetValue)
        lbLevel.text = String(level)
        lbScore.text = String(score)
        currentValue = 50
        slider.value = Float(currentValue)
    }
    
    @IBAction func reset(){
        level=0
        score=0
        startNewRound()
    }
    
    @IBAction func showInfo(){
        let alert = UIAlertController(title: nil, message: "This is the awesome game of Bull's Eye where you can win points and earn fame by dragging a slider.\nYour goal is to place the slider as close as possible to the target value. The closer you are, the more points you score.\nEnjoy!", preferredStyle: .alert)
        let action = UIAlertAction(title:"OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true,completion: nil)
    }

}

