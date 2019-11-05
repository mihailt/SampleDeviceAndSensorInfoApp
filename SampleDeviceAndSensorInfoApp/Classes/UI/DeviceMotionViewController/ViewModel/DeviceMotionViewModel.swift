//
//  DeviceMotionViewModel.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 05/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreMotion
import RxCoreMotion

class DeviceMotionViewModel {

    public let deviceMotion = BehaviorRelay<CMDeviceMotion?>(value: nil)

    private let bag = DisposeBag()
    private let manager = CMMotionManager.rx.manager()

    func loadData() {
        manager
            .flatMapLatest { manager in
                 manager.deviceMotion ?? Observable.empty()
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                self?.deviceMotion.accept(value)
            })
            .disposed(by: bag)
    }
}
