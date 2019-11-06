//
//  SensorService.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 06/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import CoreMotion
import RxCoreMotion

protocol PSensorService {
    var manager: Observable<MotionManager> { get }
}

class SensorService: PSensorService {
    var manager: Observable<MotionManager> = CMMotionManager.rx.manager()
}
