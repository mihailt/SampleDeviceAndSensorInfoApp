//
//  GyroscopeViewModel.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 05/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import RxSwift
import RxCocoa
import CoreMotion
import RxCoreMotion

class GyroscopeViewModel {

    public let rotationRate = BehaviorRelay<CMRotationRate?>(value: nil)

    private let bag = DisposeBag()
    private let manager = CMMotionManager.rx.manager()

    func loadData() {
        manager
            .flatMapLatest { manager in
                manager.rotationRate ?? Observable.empty()
            }
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] value in
                self?.rotationRate.accept(value)
            })
            .disposed(by: bag)
    }
}
