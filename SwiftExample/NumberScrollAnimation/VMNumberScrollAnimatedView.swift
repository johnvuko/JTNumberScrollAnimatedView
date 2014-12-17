//
//  VMNumberScrollAnimatedView.swift
//
//  Created by Jimmy Jose on 18/12/14.
//
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


import UIKit

class VMNumberScrollAnimatedView: UIView {
    
    private var numbersText:NSMutableArray = NSMutableArray()
    private var scrollLayers:NSMutableArray = NSMutableArray()
    private var scrollLabels:NSMutableArray = NSMutableArray()
    
    var value:NSNumber = NSNumber()
    
    internal var textColor:UIColor = UIColor.blackColor()
    
    var font:UIFont = UIFont.systemFontOfSize(UIFont.systemFontSize())
    
    var duration:CFTimeInterval = 1.5
    
    var durationOffset:CFTimeInterval = 0.2
    
    var density:NSInteger = 5
    
    internal var minLenght:NSInteger = 0
    
    var isAscending:Bool = false
    
    
    private override init(){
        
        super.init()
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func setValue(_value:NSNumber)
    {
        self.value = _value
        prepareAnimations()
    }
    
    func startAnimation()
    {
        prepareAnimations()
        createAnimations()
    }
    
    func stopAnimation()
    {
        for layer in scrollLayers {
            (layer as CALayer).removeAnimationForKey("VMNumberScrollAnimatedView")
        }
        
    }
    
    
    
    func prepareAnimations()
    {
        for layer in scrollLayers {
            (layer as CALayer).removeFromSuperlayer()
        }
        
        numbersText.removeAllObjects()
        scrollLayers.removeAllObjects()
        scrollLabels.removeAllObjects()
        
        createNumbersText()
        createScrollLayers()
        
    }
    
    
    
    func createNumbersText()
    {
        var textValue:NSString = value.stringValue as NSString
        
        var limit = minLenght - textValue.length
        
        for var i = 0; i < limit; ++i {
            
            numbersText.addObject("0")
            
        }
        
        
        for var i = 0; i < textValue.length; ++i {
            numbersText.addObject(textValue.substringWithRange(NSMakeRange(i, 1)))
            
        }
    }
    
    
    func createScrollLayers()
    {
        var tempWidth = Float(CGRectGetWidth(frame))
        var count = Float(numbersText.count)
        
        var width = roundf(tempWidth/count)
        var height = CGRectGetHeight(self.frame);
        
        for var i:NSInteger = 0; i < numbersText.count; ++i {
            
            var layer:CAScrollLayer = CAScrollLayer()
            
            layer.frame = CGRectMake(CGFloat(roundf(Float(i)  * width)), 0, CGFloat(width), CGFloat(height))
            
            scrollLayers.addObject(layer)
            self.layer.addSublayer(layer)
            
        }
        
        for var i:NSInteger = 0; i < numbersText.count; ++i {
            
            var layer:CAScrollLayer = scrollLayers.objectAtIndex(i) as CAScrollLayer
            
            var numberText:NSString = numbersText.objectAtIndex(i) as NSString
            
            createContentForLayer(layer, numberText: numberText)
            
        }
    }
    
    
    func createContentForLayer(scrollLayer:CAScrollLayer, numberText:NSString)
    {
        var number:Int = numberText.integerValue
        
        var textForScroll:NSMutableArray = NSMutableArray()
        
        var tempValue = (number+1)%10
        
        
        for var i:NSInteger = 0; i < density+1; ++i {
            textForScroll.addObject(String(tempValue))
            
        }
        
        textForScroll.addObject(numberText)
        
        
        if(!self.isAscending){
            
            textForScroll = NSMutableArray(array: textForScroll.reverseObjectEnumerator().allObjects)
            
        }
        
        var height:CGFloat = 0;
        
        for text in textForScroll
        {
            var textLabel:UILabel = createLabel(text as NSString)
            textLabel.frame = CGRectMake(0, height, CGRectGetWidth(scrollLayer.frame), CGRectGetHeight(scrollLayer.frame))
            
            scrollLayer.addSublayer(textLabel.layer)
            scrollLabels.addObject(textLabel)
            height = CGRectGetMaxY(textLabel.frame);
            
        }
        
    }
    
    
    
    func createLabel(text:NSString)-> UILabel
    {
        var view:UILabel = UILabel()
        
        view.textColor = self.textColor;
        view.font = self.font;
        view.textAlignment = NSTextAlignment.Center;
        
        view.text = text;
        
        return view;
    }
    
    
    func createAnimations()
    {
        var duration:CFTimeInterval = self.duration - (CFTimeInterval(numbersText.count) * self.durationOffset);
        var offset:CFTimeInterval = 0;
        
        for scrollLayer in scrollLayers{
            
            var temp: AnyObject? = (scrollLayer as CALayer).sublayers.last?
            
            if (temp != nil){
                
                var layer:CALayer = temp as CALayer
                var maxY:CGFloat = layer.frame.origin.y
                
                var animation:CABasicAnimation = CABasicAnimation(keyPath: "sublayerTransform.translation.y")
                animation.duration = duration + offset;
                animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
                
                if(self.isAscending){
                    
                    animation.fromValue = NSNumber(float: -Float(maxY))
                    animation.toValue = 0
                }
                else{
                    animation.fromValue = 0
                    animation.toValue = NSNumber(float: -Float(maxY))
                }
                
                scrollLayer.addAnimation(animation, forKey: "VMNumberScrollAnimatedView")
                
                
                offset += self.durationOffset;
            }
            
            
        }
        
        
        
    }
    
}
