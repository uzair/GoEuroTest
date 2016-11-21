/*
 Copyright 2015 NEOPIXL S.A.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */



import UIKit





@objc

open class NPSegmentedControl : UIControl {
    fileprivate var views = [UIView]()
    fileprivate var labels = [UILabel]()
    open var cursor:UIView?
        {
        didSet{
            if views.count > 0
            {
                self.setItems(items)
                if let cur = oldValue
                {
                    cur.removeFromSuperview()
                }
            }
        }
    }
    
    public enum CursorPosition
    {
        case top
        case bottom
    }
    
    open var cursorPosition:CursorPosition = CursorPosition.bottom
        {
        didSet{
            if views.count > 0
            {
                self.setItems(items)
            }
        }
        
    }
    
    fileprivate var animationChecks = [Bool]()
    
    fileprivate var items:[String]!
    
    fileprivate var currentIndex:Int = 0
    
    open var selectedColor:UIColor? = UIColor.lightGray
        {
        didSet{
            if self.currentIndex <= views.count - 1 && self.currentIndex >= 0
            {
                let view = views[self.currentIndex]
                view.backgroundColor = self.selectedColor
            }
        }
    }
    
    open var selectedTextColor:UIColor?
        {
        didSet{
            if self.currentIndex <= views.count - 1 && self.currentIndex >= 0
            {
                let lab = labels[self.currentIndex]
                lab.textColor = self.selectedTextColor
            }
        }
    }
    
    open var unselectedColor:UIColor? = UIColor.gray
        {
        didSet{
            
            for index in 0..<views.count
            {
                if(index != self.currentIndex)
                {
                    let view = views[index]
                    view.backgroundColor = self.unselectedColor
                }
            }
        }
    }
    
    open var unselectedTextColor:UIColor?
        {
        didSet{
            for index in 0..<views.count
            {
                if(index != self.currentIndex)
                {
                    let lab = labels[index]
                    lab.textColor = self.unselectedTextColor
                }
            }
        }
    }
    
    open var selectedFont:UIFont?
        {
        didSet{
            if self.currentIndex <= views.count - 1 && self.currentIndex >= 0
            {
                let lab = labels[self.currentIndex]
                lab.font = self.selectedFont
            }
        }
    }
    
    open var unselectedFont:UIFont?
        {
        didSet{
            for index in 0..<views.count
            {
                if(index != self.currentIndex)
                {
                    let lab = labels[index]
                    lab.font = self.unselectedFont
                }
            }
        }
    }
    
    fileprivate var cursorCenterXConstraint:NSLayoutConstraint!
    
    fileprivate var tapGestureRecogniser:UITapGestureRecognizer!
    
    fileprivate func initComponents()
    {
        tapGestureRecogniser = UITapGestureRecognizer(target: self, action: #selector(NPSegmentedControl.didTap(_:)))
        self.addGestureRecognizer(tapGestureRecogniser)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initComponents()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initComponents()
    }
    
    open func setItems(_ items:[String])
    {
        self.items = items
        var previousView:UIView?
        
        for lab in labels
        {
            lab.removeFromSuperview()
        }
        
        for view in views
        {
            view.removeFromSuperview()
        }
        if let cur = cursor
        {
            cur.removeFromSuperview()
        }
        labels.removeAll(keepingCapacity: false)
        views.removeAll(keepingCapacity: false)
        
        for i in 0..<items.count
        {
            let view = UIView()
            view.backgroundColor = unselectedColor
            self.addSubview(view)
            views.append(view)
            let label = UILabel()
            label.text = items[i]
            label.textColor = unselectedTextColor
            if let font = unselectedFont
            {
                label.font = font
            }
            view.addSubview(label)
            labels.append(label)
            label.translatesAutoresizingMaskIntoConstraints = false
            var itemHeight = self.frame.height
            if let cur = self.cursor
            {
                itemHeight -= cur.frame.height
            }
            
            let centerXConstraint = NSLayoutConstraint(item:label,
                                                       attribute:NSLayoutAttribute.centerX,
                                                       relatedBy:NSLayoutRelation.equal,
                                                       toItem:view,
                                                       attribute:NSLayoutAttribute.centerX,
                                                       multiplier:1,
                                                       constant:0)
            view.addConstraint(centerXConstraint)
            
            let centerYConstraint = NSLayoutConstraint(item:label,
                                                       attribute:NSLayoutAttribute.centerY,
                                                       relatedBy:NSLayoutRelation.equal,
                                                       toItem:view,
                                                       attribute:NSLayoutAttribute.centerY,
                                                       multiplier:1,
                                                       constant:0)
            view.addConstraint(centerYConstraint)
            
            
            view.translatesAutoresizingMaskIntoConstraints = false
            let viewDict = [ "view" : view ]
            
            let constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[view(\(itemHeight))]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict)
            view.addConstraints(constraints)
            
            if let previous = previousView
            {
                let leftConstraint = NSLayoutConstraint(item:view,
                                                        attribute:NSLayoutAttribute.left,
                                                        relatedBy:NSLayoutRelation.equal,
                                                        toItem:previous,
                                                        attribute:NSLayoutAttribute.right,
                                                        multiplier:1,
                                                        constant:0)
                self.addConstraint(leftConstraint)
                
                let widthConstraint = NSLayoutConstraint(item:view,
                                                         attribute:NSLayoutAttribute.width,
                                                         relatedBy:NSLayoutRelation.equal,
                                                         toItem:previous,
                                                         attribute:NSLayoutAttribute.width,
                                                         multiplier:1,
                                                         constant:0)
                self.addConstraint(widthConstraint)
            }
            else
            {
                let leftConstraint = NSLayoutConstraint(item:view,
                                                        attribute:NSLayoutAttribute.left,
                                                        relatedBy:NSLayoutRelation.equal,
                                                        toItem:self,
                                                        attribute:NSLayoutAttribute.left,
                                                        multiplier:1.0,
                                                        constant:0)
                self.addConstraint(leftConstraint)
            }
            
            
            if(cursorPosition == CursorPosition.top)
            {
                let bottomConstraint = NSLayoutConstraint(item:view,
                                                          attribute:NSLayoutAttribute.bottom,
                                                          relatedBy:NSLayoutRelation.equal,
                                                          toItem:self,
                                                          attribute:NSLayoutAttribute.bottom,
                                                          multiplier:1.0,
                                                          constant:0)
                
                self.addConstraint(bottomConstraint)
            }
            else
            {
                let topConstraint = NSLayoutConstraint(item:view,
                                                       attribute:NSLayoutAttribute.top,
                                                       relatedBy:NSLayoutRelation.equal,
                                                       toItem:self,
                                                       attribute:NSLayoutAttribute.top,
                                                       multiplier:1.0,
                                                       constant:0)
                
                self.addConstraint(topConstraint)
            }
            previousView = view
        }
        if let previous = previousView
        {
            let leftConstraint = NSLayoutConstraint(item:previous,
                                                    attribute:NSLayoutAttribute.right,
                                                    relatedBy:NSLayoutRelation.equal,
                                                    toItem:self,
                                                    attribute:NSLayoutAttribute.right,
                                                    multiplier:1.0,
                                                    constant:0)
            self.addConstraint(leftConstraint)
        }
        if let cur = cursor
        {
            cur.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(cur)
            
            let bottomConstraint = NSLayoutConstraint(item:cur,
                                                      attribute:NSLayoutAttribute.bottom,
                                                      relatedBy:NSLayoutRelation.equal,
                                                      toItem:self,
                                                      attribute:NSLayoutAttribute.bottom,
                                                      multiplier:1.0,
                                                      constant:0)
            self.addConstraint(bottomConstraint)
            
            cursorCenterXConstraint = NSLayoutConstraint(item:cur,
                                                         attribute:NSLayoutAttribute.centerX,
                                                         relatedBy:NSLayoutRelation.equal,
                                                         toItem:self,
                                                         attribute:NSLayoutAttribute.centerX,
                                                         multiplier:1.0,
                                                         constant:0)
            self.addConstraint(cursorCenterXConstraint)
            
            let viewDict = [ "cursor" : cur ]
            
            var constraints = NSLayoutConstraint.constraints(withVisualFormat: "V:[cursor(\(cur.frame.height))]", options: NSLayoutFormatOptions(rawValue: 0) , metrics: nil, views: viewDict)
            cur.addConstraints(constraints)
            constraints = NSLayoutConstraint.constraints(withVisualFormat: "H:[cursor(\(cur.frame.width))]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: viewDict)
            cur.addConstraints(constraints)
        }
        selectCell(currentIndex,animate: false)
    }
    
    //MARK: select cell at index
    
    open func selectCell(_ index:Int, animate:Bool)
    {
        let newView = views[index]
        let newLabel = labels[index]
        let oldView = views[currentIndex]
        let oldLabel = labels[currentIndex]
        var duration:TimeInterval = 0
        if animate
        {
            duration = 0.4
        }
        if (duration == 0 || index != currentIndex) && index < items.count
        {
            
            UIView.animate(withDuration: duration, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 10, options: UIViewAnimationOptions.allowUserInteraction, animations:
                {
                    self.animationChecks.append(true)
                    oldView.backgroundColor = self.unselectedColor
                    oldLabel.textColor = self.unselectedTextColor
                    if let font = self.unselectedFont
                    {
                        oldLabel.font = font
                    }
                    newView.backgroundColor = self.selectedColor
                    newLabel.textColor = self.selectedTextColor
                    if let font = self.selectedFont
                    {
                        newLabel.font = font
                    }
                    if let cur = self.cursor
                    {
                        cur.center.x = newView.center.x
                    }
            },
                           completion: { finished in
                            if self.animationChecks.count == 1
                            {
                                if let cur = self.cursor
                                {
                                    self.removeConstraint(self.cursorCenterXConstraint)
                                    self.cursorCenterXConstraint = NSLayoutConstraint(item:cur,
                                                                                      attribute:NSLayoutAttribute.centerX,
                                                                                      relatedBy:NSLayoutRelation.equal,
                                                                                      toItem:newView,
                                                                                      attribute:NSLayoutAttribute.centerX,
                                                                                      multiplier:1.0,
                                                                                      constant:0)
                                    self.addConstraint(self.cursorCenterXConstraint)
                                }
                                
                            }
                            self.animationChecks.removeLast()
                            
            })
            currentIndex = index
        }
    }
    
    internal func didTap(_ recognizer:UITapGestureRecognizer)
    {
        if recognizer.state == UIGestureRecognizerState.ended
        {
            let currentPoint = recognizer.location(in: self)
            let index = indexFromPoint(currentPoint)
            selectCell(index, animate: true)
            self.sendActions(for: UIControlEvents.valueChanged)
        }
    }
    
    //MARK: getIndex from point
    
    fileprivate func indexFromPoint(_ point:CGPoint) -> Int
    {
        for pos in 0..<views.count
        {
            let view = views[pos]
            if point.x >= view.frame.minX && point.x < view.frame.maxX
            {
                return pos
            }
        }
        return 0
    }
    
    //MARK: selectedIndex
    open func selectedIndex() -> Int
    {
        return self.currentIndex
    }
}
