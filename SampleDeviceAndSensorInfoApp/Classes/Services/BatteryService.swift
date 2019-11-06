//
//  BatteryService.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 06/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol PBatteryService: PSubServiceProtocol {
    var batteryState: BehaviorRelay<UIDevice.BatteryState> { get }
    var batteryLevel: BehaviorRelay<Float> { get }
}

class BatteryService: PBatteryService {

    public let batteryState = BehaviorRelay<UIDevice.BatteryState>(value: UIDevice.BatteryState.unknown)
    public let batteryLevel = BehaviorRelay<Float>(value: 0)

    private let bag = DisposeBag()

    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
        batteryState.accept(UIDevice.current.batteryState)
        batteryLevel.accept(UIDevice.current.batteryLevel)
    }

    func registerForEvents() {
        NotificationCenter.default.rx.notification(UIDevice.batteryLevelDidChangeNotification)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.batteryLevel.accept(UIDevice.current.batteryLevel)
            })
            .disposed(by: bag)

        NotificationCenter.default.rx.notification(UIDevice.batteryStateDidChangeNotification)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in
                self?.batteryState.accept(UIDevice.current.batteryState)
            })
            .disposed(by: bag)
    }
}
