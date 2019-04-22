//
//  ViewController.swift
//  UIDynamicAnimationsWithTwoViews
//
//  Created by Art Karma on 4/22/19.
//  Copyright © 2019 Art Karma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var squareViews = [UIView]()
    var animator: UIDynamicAnimator!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let numberOfView = 3
        var colors = [UIColor.red,  UIColor.yellow, UIColor.green]
        let eachViewSize = CGSize(width: 50, height: 50)
        var currentCenterPoint: CGPoint = self.view.center // сж поинт это только х и у
        
        for counter in 0..<numberOfView {
            let newView = UIView()
            newView.frame = CGRect(x: 0, y: 0, width: eachViewSize.width, height: eachViewSize.height)
            newView.backgroundColor = colors[counter] // у каждой вью будет из массива цветов выбираться новый цвет
            newView.center = currentCenterPoint
            newView.layer.cornerRadius = 0.5 * newView.bounds.size.width
            currentCenterPoint.y += eachViewSize.height + 10 // у каждой следующей вьюшке берем высоту вьюшки и прибавляем 10
            self.view.addSubview(newView)
            squareViews.append(newView)
        }
        
        animator = UIDynamicAnimator(referenceView: self.view)
        
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(touch))
        squareViews[0].addGestureRecognizer(gesture)
        squareViews[0].isUserInteractionEnabled = true
        
//        let gravity = UIGravityBehavior(items: squareViews)
//        gravity.magnitude = 0.1
//        animator.addBehavior(gravity)
        
        let collision = UICollisionBehavior(items: squareViews)
        collision.translatesReferenceBoundsIntoBoundary = true // будет внизу биться головйо об стенку и останавливаться
        animator.addBehavior(collision)
        

        
        
        //        let snapping = UISnapBehavior(item: squareViews[1], snapTo: .init(x: 5, y: 100))
        //        let snapping1 = UISnapBehavior(item: squareViews[1], snapTo: .init(x: -2, y: 60))
        //        let snapping2 = UISnapBehavior(item: squareViews[1], snapTo: .init(x: 18, y: -6))
        //
        //
        //        animator.addBehavior(snapping)
        //        animator.addBehavior(snapping1)
        //        animator.addBehavior(snapping2)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
        
        
    }
    
    @objc func touch(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .possible:
            ()
        case .changed:
            let move = sender.translation(in: self.view)
            squareViews[0].center = CGPoint(x: squareViews[0].center.x + move.x, y: squareViews[0].center.y + move.y)
            sender.setTranslation(.zero, in: self.view)
        case .ended:
            ()
        case .cancelled:
            ()
        case .failed:
            ()
        @unknown default:
            ()
        }
    }
}
