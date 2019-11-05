//
//  InfoViewModel.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 05/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//
import RxSwift
import RxCocoa
import CoreMotion
import RxCoreMotion
import GBDeviceInfo

class InfoViewModel {

    public let model = BehaviorRelay<String?>(value: nil)
    public let minorOsVersion = BehaviorRelay<String?>(value: nil)
    public let majorOsVersion = BehaviorRelay<String?>(value: nil)
    public let screenResolution = BehaviorRelay<String?>(value: nil)

    func loadData() {
        guard let deviceInfo = GBDeviceInfo.deviceInfo() else { return }
        model.accept("Device Model: \(String(describing: deviceInfo.modelString))")
        minorOsVersion.accept("Minor Os Version: \(deviceInfo.osVersion.major)")
        majorOsVersion.accept("Major Os Version: \(deviceInfo.osVersion.minor)")
        screenResolution.accept("Screen pixels per inch: \(deviceInfo.displayInfo.pixelsPerInch)")
    }
}
