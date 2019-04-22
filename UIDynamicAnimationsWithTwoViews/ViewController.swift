//
//  ViewController.swift
//  UIDynamicAnimationsWithTwoViews
//
//  Created by Art Karma on 4/22/19.
//  Copyright © 2019 Art Karma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var squareViews = [UIDynamicItem]()
    var animator: UIDynamicAnimator!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let numberOfView = 3
        var colors = [UIColor.red, UIColor.green, UIColor.yellow]
        let eachViewSize = CGSize(width: 50, height: 50)
        var currentCenterPoint: CGPoint = self.view.center // сж поинт это только х и у
        
        for counter in 0..<numberOfView {
            let newView = UIView()
            newView.frame = CGRect(x: 0, y: 0, width: eachViewSize.width, height: eachViewSize.height)
            newView.backgroundColor = colors[counter] // у каждой вью будет из массива цветов выбираться новый цвет
            newView.center = currentCenterPoint
            currentCenterPoint.y += eachViewSize.height + 10 // у каждой следующей вьюшке берем высоту вьюшки и прибавляем 10
            self.view.addSubview(newView)
            squareViews.append(newView)
        }
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        let gravity = UIGravityBehavior(items: squareViews)
        gravity.magnitude = 0.1
        animator.addBehavior(gravity)
        
        let collision = UICollisionBehavior(items: squareViews)
        collision.translatesReferenceBoundsIntoBoundary = true // будет внизу биться головйо об стенку и останавливаться
        animator.addBehavior(collision)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
