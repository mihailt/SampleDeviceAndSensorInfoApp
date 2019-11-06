//
//  MagnetometerViewModel.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 05/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreMotion
import RxCoreMotion

class MagnetometerViewModel: SensorServiceInjectable {

    public let magneticField = BehaviorRelay<CMMagneticField?>(value: nil)
    private let bag = DisposeBag()

    func loadData() {
        sensorService.manager
            .flatMapLatest { manager in
                manager.magneticField ?? Observable.empty()
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                self?.magneticField.accept(value)
            })
            .disposed(by: bag)
    }
}
