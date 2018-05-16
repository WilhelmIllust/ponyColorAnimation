//
//  pieView.swift
//  ponyColorAnimation
//
//  Created by User11 on 2018/5/16.
//  Copyright © 2018年 WilhelmShen. All rights reserved.
//

import UIKit

class pieView: UIView {
    
    
    var hueOffset:CGFloat = 0.0
    override func draw(_ rect: CGRect) {
        var color = [UIColor.red,UIColor.orange,UIColor.yellow,UIColor.green,UIColor.cyan,UIColor.blue,UIColor.purple,UIColor.darkGray]
        let center = CGPoint(x:rect.width/2, y:rect.height/2)
        var startAngle:CGFloat = 0
        let increase:CGFloat = CGFloat.pi/4
        let radius = max(rect.width, rect.height)/2
        var endAngle = increase
        //view.backgroundColor = UIColor.clear
        
        
        for index in 0 ... 7{
            //let layer = CAShapeLayer()
            let triangle = UIBezierPath()
            triangle.move(to:center)
            triangle.addArc(withCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
            
            startAngle=startAngle+increase
            endAngle=endAngle+increase
            triangle.lineWidth=radius
            var hue:CGFloat = 0
            var saturation:CGFloat = 0
            var brightness:CGFloat = 0
            var alpha:CGFloat = 0
            color[index].getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
            let newHue = ((hue + hueOffset)>360) ? (hue + hueOffset-360):(hue + hueOffset)
            UIColor(hue: newHue, saturation: saturation, brightness: brightness, alpha: alpha).setFill()
            //color[index].setFill()
            triangle.fill()
            // layer.path = triangle.cgPath
            // layer.fillColor = color[index]
            
        }
    }
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor=UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
}
