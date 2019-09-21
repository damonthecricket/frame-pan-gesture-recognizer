//
//  PolygonLayer.swift
//  FramePanGestureRecognizer
//
//  Created by Damon Cricket on 21.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - PolygonLayer

class PolygonLayer: CALayer {

    var points: [CGPoint] = [] {
        didSet {
            frames = []
            for point in points {
                let offset: CGFloat = 25
                let x = point.x - offset
                let y = point.y - offset
                let width = offset * 2.0
                let height = offset * 2.0
                let frame = CGRect(x: x, y: y, width: width, height: height)
                frames.append(frame)
            }
        }
    }
    
    var color: CGColor = UIColor.clear.cgColor
    
    private(set) var frames: [CGRect] = []
    
    // MARK: - Object LifeCycle
    
    override init() {
        super.init()
        
        postInitSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        postInitSetup()
    }
    
    override init(layer: Any) {
        super.init(layer: layer)
        
        if let polygonLayer = layer as? PolygonLayer {
            points = polygonLayer.points
            color = polygonLayer.color
        }
        
        postInitSetup()
    }
    
    func postInitSetup() {
        contentsScale = UIScreen.main.scale
        needsDisplayOnBoundsChange = true
    }
    
    // MARK: - Draw
    
    override func draw(in ctx: CGContext) {
        super.draw(in: ctx)
        
        guard points.count > 2 else {
            return
        }
        
        UIGraphicsPushContext(ctx)
        
        let first = points.first!
        
        let polygon = CGMutablePath()
        
        polygon.move(to: first)
        
        for idx in 1 ..< points.count {
            let point = points[idx]
            polygon.addLine(to: point)
        }
        
        polygon.closeSubpath()
        
        ctx.addPath(polygon)
        ctx.setFillColor(color)
        ctx.fillPath()

        
        for point in points {
            let circle = CGMutablePath()
            circle.addArc(center: point, radius: 5.0, startAngle: 0.0, endAngle: 2*CGFloat.pi, clockwise: true)
            
            ctx.addPath(circle)
            ctx.setFillColor(UIColor.clear.cgColor)
            ctx.setStrokeColor(UIColor.black.cgColor)
            ctx.strokePath()
        }
        
        for frame in frames {
            ctx.setLineWidth(3.0)
            
            let path = CGMutablePath()
            
            let topLeft = frame.origin
            path.move(to: topLeft)
            
            let topRight = CGPoint(x: topLeft.x + frame.width, y: topLeft.y)
            path.addLine(to: topRight)
            
            let bottomRight = CGPoint(x: topLeft.x + frame.width, y: topLeft.y + frame.height)
            path.addLine(to: bottomRight)
            
            let bottomLeft = CGPoint(x: topLeft.x, y: topLeft.y + frame.height)
            path.addLine(to: bottomLeft)
            path.closeSubpath()
            
            ctx.addPath(path)
            ctx.setFillColor(UIColor.clear.cgColor)
            ctx.setStrokeColor(UIColor.black.cgColor)
            ctx.strokePath()
        }
        
        UIGraphicsPopContext()
    }
}
