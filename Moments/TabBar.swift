//
//  TabBar.swift
//  Moments
//
//  Created by user on 18/07/1939 Saka.
//  Copyright © 1939 Saka user. All rights reserved.
//

import UIKit
import TransitionableTab

enum Type: String {
    case move
    case fade
    case scale
    case custom
    
    static var all: [Type] = [.move, .scale, .fade, .custom]
}

class TabBar: UITabBarController {
    
    var type : Type = .scale
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.delegate = self

        navigationController?.setNavigationBarHidden(true, animated: false)
        
        navigationItem.setHidesBackButton(true, animated: false)
        
    }
}
extension TabBar : TransitionableTab {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {

        return animateTransition(tabBarController, shouldSelect: viewController)
    }
    //custom and scale works well
    func toTransitionAnimation(layer: CALayer, direction: Direction) -> CAAnimation {
        switch type {
        case .move: return DefineAnimation.move(.from, direction: direction)
        case .scale: return DefineAnimation.scale(.to)
        case .fade: return DefineAnimation.fade(.from)
        case .custom:
            let animation = CABasicAnimation(keyPath: "transform.translation.y")
            animation.fromValue = layer.frame.height
            animation.toValue = 0
            return animation
    }
}
}
