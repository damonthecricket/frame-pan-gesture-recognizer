//
//  MainViewController.swift
//  FramePanGestureRecognizer
//
//  Created by Damon Cricket on 21.09.2019.
//  Copyright © 2019 DC. All rights reserved.
//

import UIKit

// MARK: - MainViewController

class MainViewController: UIViewController {

    @IBOutlet weak var polygonView: PolygonView?
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        polygonView?.points = [CGPoint(x: 100.0, y: 100.0), CGPoint(x: 300.0, y: 100.0), CGPoint(x: 300.0 ,y: 300.0), CGPoint(x: 100.0, y: 300.0)]
        polygonView?.color = .red
        
        let gestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(gestureRecognizerPan(sender:)))
        polygonView?.addGestureRecognizer(gestureRecognizer)
    }
    
    // MARK: - UIActions
    
    @objc func gestureRecognizerPan(sender: UIPanGestureRecognizer) {
        for (idx, frame) in polygonView!.frames.enumerated() {
            let location = sender.location(in: polygonView)
            if frame.contains(location) {
                polygonView?.points[idx] = location
                polygonView?.layer.setNeedsDisplay()
            }
        }
    }
}
