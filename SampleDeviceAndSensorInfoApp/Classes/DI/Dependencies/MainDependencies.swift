//
//  MainDependencies.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 06/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import Swinject

class MainDependencies: Assembly {

    func assemble(container: Container) {
        container.register(PBatteryService.self) { _ in
            BatteryService()
        }.inObjectScope(.container)

        container.register(PSensorService.self) { _ in
            SensorService()
        }.inObjectScope(.container)
    }
}
