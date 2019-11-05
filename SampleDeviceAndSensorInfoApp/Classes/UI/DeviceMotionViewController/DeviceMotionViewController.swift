//
//  DeviceMotionViewController.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 05/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import UIKit
import RxSwift
import CoreMotion

class DeviceMotionViewController: UIViewController {

    @IBOutlet weak var pitchLabel: UILabel!
    @IBOutlet weak var rollLabel: UILabel!
    @IBOutlet weak var yawLabel: UILabel!

    @IBOutlet weak var rotationYLabel: UILabel!
    @IBOutlet weak var rotationXLabel: UILabel!
    @IBOutlet weak var rotationZLabel: UILabel!

    @IBOutlet weak var userAccelerationYLabel: UILabel!
    @IBOutlet weak var userAccelerationXLabel: UILabel!
    @IBOutlet weak var userAccelerationZLabel: UILabel!

    let viewModel = DeviceMotionViewModel()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
        addHandlers()
    }

    func addHandlers() {
        viewModel.deviceMotion
            .asObservable()
            .subscribe(onNext: { [weak self] value in
                self?.configureLabels(deviceMotion: value)
            })
            .disposed(by: bag)
    }

    func configureLabels(deviceMotion: CMDeviceMotion?) {
        guard let deviceMotion = deviceMotion else { return }
        pitchLabel.text = "Attitude Pitch: \(deviceMotion.attitude.pitch)"
        rollLabel.text = "Attitude Roll: \(deviceMotion.attitude.roll)"
        yawLabel.text = "Attitude Yaw: \(deviceMotion.attitude.yaw)"

        rotationYLabel.text = "Rotation Y: \(deviceMotion.rotationRate.x)"
        rotationXLabel.text = "Rotation Y: \(deviceMotion.rotationRate.y)"
        rotationZLabel.text = "Rotation Z: \(deviceMotion.rotationRate.z)"

        userAccelerationYLabel.text = "User acceleration Y: \(deviceMotion.userAcceleration.x)"
        userAccelerationXLabel.text = "User acceleration X: \(deviceMotion.userAcceleration.y)"
        userAccelerationZLabel.text = "User acceleration Z: \(deviceMotion.userAcceleration.z)"
    }
}
