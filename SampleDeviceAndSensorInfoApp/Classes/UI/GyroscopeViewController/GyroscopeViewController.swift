//
//  GyroscopeViewController.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 05/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import UIKit
import RxSwift
import CoreMotion

class GyroscopeViewController: UIViewController {

    @IBOutlet weak var axisXLabel: UILabel!
    @IBOutlet weak var axisYLabel: UILabel!
    @IBOutlet weak var axisZLabel: UILabel!

    let viewModel = GyroscopeViewModel()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
        addHandlers()
    }

    func addHandlers() {
        viewModel.rotationRate
            .asObservable()
            .subscribe(onNext: { [weak self] value in
                self?.configureLabels(rotationRate: value)
            })
            .disposed(by: bag)
    }

    func configureLabels(rotationRate: CMRotationRate?) {
        guard let rotationRate = rotationRate else { return }
        axisXLabel.text = "Axis X: \(rotationRate.x)"
        axisYLabel.text = "Axis Y: \(rotationRate.z)"
        axisZLabel.text = "Axis Z: \(rotationRate.z)"
    }
}
