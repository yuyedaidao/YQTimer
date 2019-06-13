//
//  YQTimer.swift
//  YQTimerLabel
//
//  Created by 王叶庆 on 2019/6/13.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import Foundation
public protocol YQTimerBinder {
    var timeInterval: TimeInterval {get set}
}
open class YQTimer {
    var displayLink: CADisplayLink?
    var startDate: Date?
    var pauseDate: Date?
    var endDate: Date?
    public var timeIntervalObserver: ((TimeInterval) -> Void)?
    public var binder: YQTimerBinder?
    public init(){}
    open func start() {
        displayLink?.invalidate()
        displayLink = CADisplayLink(target: self, selector: #selector(displayLinkHandler(_:)))
        pauseDate = nil
        startDate = Date()
        timeInterval = 0
        performUpdate(timeInterval)
        displayLink?.add(to: RunLoop.current, forMode: RunLoop.Mode.common)
    }
    open func pause() {
        displayLink?.isPaused = true
    }
    open func resue() {
        guard let displayLink = self.displayLink, displayLink.isPaused else {
            start()
            return
        }
        displayLink.isPaused = false
    }
    open func end() {
        displayLink?.invalidate()
    }
    
    @objc func displayLinkHandler(_ sender: Any) {
        guard let startDate = self.startDate else {
            return
        }
        if let pauseDate = self.pauseDate {
            timeInterval = pauseDate.timeIntervalSince(startDate) + Date().timeIntervalSince(pauseDate)
        } else {
            timeInterval = Date().timeIntervalSince(startDate)
        }
        
    }
    
    public var timeInterval: TimeInterval = 0 {
        didSet {
            if self.timeInterval != oldValue {
                performUpdate(self.timeInterval)
            }
        }
    }
    
    func performUpdate(_ timeInterval: TimeInterval) {
        timeIntervalObserver?(timeInterval)
        binder?.timeInterval = timeInterval
    }
}
