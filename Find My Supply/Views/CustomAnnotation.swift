//
//  CustomAnnotation.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 3/31/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import Foundation


import MapKit
 
class CustomAnnotation:  NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    var storeIndex: Int!
    var chainName: String!
    
    var calloutIsShowing = false
    
    init(coordinate: CLLocationCoordinate2D) {
        self.coordinate = coordinate
    }
}

class Static {
    static let shared = Static()
    var calloutIsShowing = false
}



class AnnotationView: MKAnnotationView
{
/*
override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let hitView = super.hitTest(point, with: event)
        if (hitView != nil)
        {
            self.superview?.bringSubviewToFront(self)
        }
        return hitView
    }
 */
    
   // var calloutIsShowing: Bool?
    
 
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        ////print("================self.BOUNDS: \(self.bounds)")
        ////print("==========point: \(point)")
        //let rect = CGRect(x: 0, y: 0, width: 262, height: 396)
        let rect = self.bounds
        /*
        if self.bounds.width == 262.0 {
            //print("================Inside callout box")
            rect = CGRect(x: 0, y: 0, width: 0, height: 0)
        }
        else {
            //print("================Inside pin")
            rect = CGRect(x: 0, y: 0, width: 87.0, height: 87.0)
        }
 */
         
       
        var isInside: Bool = rect.contains(point)
        if(!isInside)
        {
            
           // if let ann =  self.annotation as? CustomAnnotation {
           ////print("================IsSowing: \(Static.shared.calloutIsShowing)")
            if Static.shared.calloutIsShowing {
                    for view in self.subviews
                    {
                        ////print("================view.FRAME: \(view.frame)")
                        isInside = view.frame.contains(point)
                        if isInside
                        {
                            break
                        }
                    }
                }
            }
        
 
        //}
        ////print("======\(isInside && self.bounds.width==87.0)")
        ////print("======\(isInside)")
        return isInside 
    }
}
 
 
