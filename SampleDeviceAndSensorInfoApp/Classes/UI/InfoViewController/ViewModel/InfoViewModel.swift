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

class InfoViewModel: BatteryServiceInjectable {

    public let model = BehaviorRelay<String?>(value: nil)
    public let minorOsVersion = BehaviorRelay<String?>(value: nil)
    public let majorOsVersion = BehaviorRelay<String?>(value: nil)
    public let screenResolution = BehaviorRelay<String?>(value: nil)

    public let batteryState = BehaviorRelay<String?>(value: nil)
    public let batteryLevel = BehaviorRelay<String?>(value: nil)

    private let bag = DisposeBag()

    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true

        batteryLevel.accept("Battery level: \(UIDevice.current.batteryLevel * 100)%")
        batteryState.accept("Battery state: \(UIDevice.current.batteryState.rawValue)")

        guard let deviceInfo = GBDeviceInfo.deviceInfo() else { return }

        model.accept("Device Model: \(deviceInfo.modelString ?? "")")
        minorOsVersion.accept("Minor Os Version: \(deviceInfo.osVersion.major)")
        majorOsVersion.accept("Major Os Version: \(deviceInfo.osVersion.minor)")
        screenResolution.accept("Screen pixels per inch: \(deviceInfo.displayInfo.pixelsPerInch)")
    }

    func loadData() {
        batteryService
            .batteryState
            .asObservable()
            .subscribe(onNext: { [weak self] value in
                let state: String
                switch value {
                case UIDevice.BatteryState.full:
                    state = "full"
                case UIDevice.BatteryState.charging:
                    state = "charging"
                case UIDevice.BatteryState.unplugged:
                    state = "unplugged"
                default:
                    state = "unknown"
                }
                self?.batteryState.accept("Battery state: \(state)")
            })
            .disposed(by: bag)

        batteryService
            .batteryLevel
            .asObservable()
            .subscribe(onNext: { [weak self] value in
                self?.batteryLevel.accept("Battery level: \(value * 100)%")
            })
            .disposed(by: bag)
    }
}
