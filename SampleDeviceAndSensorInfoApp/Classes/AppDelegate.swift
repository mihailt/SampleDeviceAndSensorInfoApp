//
//  AppDelegate.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 05/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        DependencyAssembler.with([MainDependencies()])
        return true
    }
}

private extension AppDelegate {
    func registerServices() {
        let resolver = DependencyAssembler.shared.resolver
        let services: [PSubServiceProtocol?] = [
            resolver.resolve(PBatteryService.self)
        ]
        services.forEach { service in
            service?.registerForEvents()
        }
    }
}
