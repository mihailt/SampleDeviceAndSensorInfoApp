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
