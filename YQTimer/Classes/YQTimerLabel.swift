//
//  YQTimerLabel.swift
//  YQTimerLabel
//
//  Created by 王叶庆 on 2019/6/13.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

open class YQTimerLabel: UILabel {
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    func commonInit() {
        text = "00:00:00"
    }
    
    public var timeInterval: TimeInterval = 0 {
        didSet {
            let duration = Int(self.timeInterval)
            let second = duration % 60
            var minute = duration / 60
            let hour = minute / 60
            minute = minute % 60
            text = String(format: "%2d:%2d:%2d", hour, minute, second)
        }
    }
}

extension YQTimerLabel: YQTimerBinder {}
