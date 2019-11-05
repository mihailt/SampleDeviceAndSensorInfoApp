//
//  InfoViewController.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 05/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class InfoViewController: UIViewController {

    private let bag = DisposeBag()

    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var majorOsVersionLabel: UILabel!
    @IBOutlet weak var minorOsVersionLabel: UILabel!
    @IBOutlet weak var screenResolutionLabel: UILabel!

    let viewModel = InfoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.loadData()
        addHandlers()
    }

    func addHandlers() {
        viewModel.model
            .asObservable()
            .bind(to: modelLabel.rx.text)
            .disposed(by: bag)

        viewModel.majorOsVersion
            .asObservable()
            .bind(to: majorOsVersionLabel.rx.text)
            .disposed(by: bag)

        viewModel.minorOsVersion
            .asObservable()
            .bind(to: minorOsVersionLabel.rx.text)
            .disposed(by: bag)

        viewModel.screenResolution
            .asObservable()
            .bind(to: screenResolutionLabel.rx.text)
            .disposed(by: bag)
    }
}
