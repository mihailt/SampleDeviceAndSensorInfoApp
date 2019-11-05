//
//  AccelerometerViewController.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 05/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import UIKit
import RxSwift
import CoreMotion

class AccelerometerViewController: UIViewController {

    @IBOutlet weak var axisXLabel: UILabel!
    @IBOutlet weak var axisYLabel: UILabel!
    @IBOutlet weak var axisZLabel: UILabel!

    let viewModel = AccelerometerViewModel()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
        addHandlers()
    }

    func addHandlers() {
        viewModel.acceleration
            .asObservable()
            .subscribe(onNext: { [weak self] value in
                self?.configureLabels(acceleration: value)
            })
            .disposed(by: bag)
    }

    func configureLabels(acceleration: CMAcceleration?) {
        guard let acceleration = acceleration else { return }
        axisXLabel.text = "Axis X: \(acceleration.x)"
        axisYLabel.text = "Axis Y: \(acceleration.z)"
        axisZLabel.text = "Axis Z: \(acceleration.z)"
    }
}
