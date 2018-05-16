//
//  ViewController.swift
//  ponyColorAnimation
//
//  Created by User11 on 2018/5/16.
//  Copyright © 2018年 WilhelmShen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let animation:CAKeyframeAnimation = CAKeyframeAnimation.init(keyPath: "transform.rotation.z")
    
    func Animation()  {
        animation.keyTimes=[0,0.25,0.5,0.75,1]
        animation.values=[0,CGFloat.pi/2,CGFloat.pi,CGFloat.pi*3/2,CGFloat.pi*2]
        animation.isRemovedOnCompletion=false
        animation.repeatCount=MAXFLOAT
        animation.duration = 3
        cycle.layer.add(animation, forKey: "animation")
        /*引用自：
         作者：Karl0n
         链接：https://www.jianshu.com/p/2d2e333b2639
         來源：简书
         */
    }
    
    var hue:CGFloat = 0.0
    var saturation:CGFloat = 0.0
    var brightness:CGFloat = 0.0
    var alpha:CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sliderSpeed.value = 0.0
        self.speedState.text = NSString(format: "%.2f", sliderSpeed.value) as String
        
        UIColor.red.getHue(&hue, saturation:&saturation , brightness:&brightness , alpha:&alpha )
        colorState.text = NSString(format: "%.2f", hue) as String
        sliderColor.value = Float(hue)
    }
    var isFirstTimeStart = true
    @IBAction func rotateSwitchOnChange(_ sender: Any) {
        var pauseTime:CFTimeInterval = CACurrentMediaTime()
        
        if rotateSwitch.isOn{
            speedState.isEnabled=true
            sliderSpeed.isEnabled=true
            lableSpeed.isEnabled=true
            rotateState.text="on"
            speedState.text = NSString(format: "%.2f", sliderSpeed.value) as String
            UIView.animate(withDuration:1.0){
                self.cycle.layer.timeOffset =  0.0
                self.cycle.layer.beginTime = 0.0;
                self.cycle.layer.beginTime = CACurrentMediaTime()-pauseTime
                self.cycle.layer.speed = self.sliderSpeed.value
            }
            if isFirstTimeStart {
                Animation()
                isFirstTimeStart = false
            }
        }else{
            speedState.isEnabled=false
            sliderSpeed.isEnabled=false
            lableSpeed.isEnabled=false
            rotateState.text="off"
            //speedState.text="0"
            UIView.animate(withDuration:1.0){
                self.cycle.layer.speed = 0.0;
                pauseTime = CACurrentMediaTime()
                self.cycle.layer.timeOffset = pauseTime
            }
            
        }
    }
    
    @IBAction func rotateSpeedSliderOnChange(_ sender: Any) {
        UIView.animate(withDuration:1.0){
            
            let pauseTime = CACurrentMediaTime()
            self.cycle.layer.beginTime = CACurrentMediaTime()-pauseTime
            self.cycle.layer.speed = self.sliderSpeed.value
            
        }
        speedState.text = NSString(format: "%.2f", sliderSpeed.value) as String
    }
    @IBAction func colorSliderOnchange(_ sender: Any) {
        self.colorView.backgroundColor=UIColor(hue: CGFloat(self.sliderColor.value), saturation: saturation, brightness: brightness, alpha: 0.5)
        self.colorState.text = NSString(format: "%.0f", self.sliderColor.value) as String
        
        
    }
    @IBOutlet weak var rotateSwitch: UISwitch!
    @IBOutlet weak var colorView: UIView!
    @IBOutlet weak var colorState: UILabel!
    @IBOutlet weak var sliderColor: UISlider!
    @IBOutlet weak var speedState: UILabel!
    @IBOutlet weak var sliderSpeed: UISlider!
    @IBOutlet weak var lableSpeed: UILabel!
    @IBOutlet weak var rotateState: UILabel!
    @IBOutlet weak var cycle: pieView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
}
