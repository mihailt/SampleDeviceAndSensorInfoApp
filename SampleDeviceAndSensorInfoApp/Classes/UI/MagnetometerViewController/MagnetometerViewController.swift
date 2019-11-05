//
//  MagnetometerViewController.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 05/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import UIKit
import RxSwift
import CoreMotion

class MagnetometerViewController: UIViewController {

    @IBOutlet weak var axisXLabel: UILabel!
    @IBOutlet weak var axisYLabel: UILabel!
    @IBOutlet weak var axisZLabel: UILabel!

    let viewModel = MagnetometerViewModel()
    private let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadData()
        addHandlers()
    }

    func addHandlers() {
        viewModel.magneticField
            .asObservable()
            .subscribe(onNext: { [weak self] value in
                self?.configureLabels(magneticField: value)
            })
            .disposed(by: bag)
    }

    func configureLabels(magneticField: CMMagneticField?) {
        guard let magneticField = magneticField else { return }
        axisXLabel.text = "Axis X: \(magneticField.x)"
        axisYLabel.text = "Axis Y: \(magneticField.z)"
        axisZLabel.text = "Axis Z: \(magneticField.z)"
    }
}
