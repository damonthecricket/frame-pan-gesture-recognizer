//
//  PolygonView.swift
//  FramePanGestureRecognizer
//
//  Created by Damon Cricket on 21.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - PolygonView

class PolygonView: UIView {
    
    var points: [CGPoint] {
        set {
            polygonLayer.points = newValue
        } get {
            return polygonLayer.points
        }
    }
    
    var color: UIColor {
        set {
            polygonLayer.color = newValue.cgColor
        } get {
            return UIColor(cgColor: polygonLayer.color)
        }
    }
    
    var frames: [CGRect] {
        return polygonLayer.frames
    }
    
    var polygonLayer: PolygonLayer {
        return layer as! PolygonLayer
    }
    
    override open class var layerClass: AnyClass {
        return PolygonLayer.self
    }
}
