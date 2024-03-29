//
//  AccelerometerViewModel.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 05/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreMotion
import RxCoreMotion

class AccelerometerViewModel: SensorServiceInjectable {

    public let acceleration = BehaviorRelay<CMAcceleration?>(value: nil)
    private let bag = DisposeBag()

    func loadData() {
        sensorService.manager
            .flatMapLatest { manager in
                manager.acceleration ?? Observable.empty()
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                self?.acceleration.accept(value)
            })
            .disposed(by: bag)
    }
}
