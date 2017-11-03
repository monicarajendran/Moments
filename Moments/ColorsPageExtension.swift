//
//  ColorsPageExtension.swift
//  Moments
//
//  Created by user on 02/11/17.
//  Copyright © 2017 user. All rights reserved.
//

import Foundation

import UIKit

extension ColorsPage {
    
    func themeColors(){
        
        red.backgroundColor = UIColor(red: 198/255, green: 40/255, blue: 40/255, alpha: 1.0)
        blue.backgroundColor = UIColor(red: 3/255, green: 155/255, blue: 229/255, alpha: 1.0)
        pink.backgroundColor = UIColor(red: 236/255, green: 64/255, blue: 122/255, alpha: 1.0)
        indigo.backgroundColor = UIColor(red: 92/255, green: 107/255, blue: 192/255, alpha: 1.0)
        teal.backgroundColor = UIColor(red: 77/255, green: 182/255, blue: 172/255, alpha: 1.0)
        cyan.backgroundColor = UIColor(red: 0/255, green: 172/255, blue: 193/255, alpha: 1.0)
        pestoGreen.backgroundColor = UIColor(red: 0/255, green: 170/255, blue: 141/255, alpha: 1.0)
        purple.backgroundColor = UIColor(red: 171/255, green: 71/255, blue: 188/255, alpha: 1.0)
        lime.backgroundColor = UIColor(red: 175/255, green: 180/255, blue: 43/255, alpha: 1.0)
        orange.backgroundColor = UIColor(red: 239/255, green: 108/255, blue: 0/255, alpha: 1.0)
        
        
    }
    
    func circleShape(){
        
        red.layer.cornerRadius = red.frame.size.width / 2
        red.layer.masksToBounds = true
        blue.layer.cornerRadius = blue.frame.size.width / 2
        pink.layer.cornerRadius = pink.frame.size.width / 2
        indigo.layer.cornerRadius = indigo.frame.size.width / 2
        teal.layer.cornerRadius = teal.frame.size.width / 2
        cyan.layer.cornerRadius = cyan.frame.size.width / 2
        pestoGreen.layer.cornerRadius = pestoGreen.frame.size.width / 2
        purple.layer.cornerRadius = purple.frame.size.width / 2
        lime.layer.cornerRadius = lime.frame.size.width / 2
        orange.layer.cornerRadius = orange.frame.size.width / 2

        
    }
    
    
}
