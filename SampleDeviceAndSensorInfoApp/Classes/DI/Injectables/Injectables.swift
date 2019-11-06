//
//  Injectables.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 06/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import Foundation

protocol BatteryServiceInjectable {
    var batteryService: PBatteryService { get }
}

extension BatteryServiceInjectable {
    var batteryService: PBatteryService {
        return DependencyAssembler.shared.resolver.resolve(PBatteryService.self)!
    }
}

protocol SensorServiceInjectable {
    var sensorService: PSensorService { get }
}

extension SensorServiceInjectable {
    var sensorService: PSensorService {
        return DependencyAssembler.shared.resolver.resolve(PSensorService.self)!
    }
}
