//
//  ViewController.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 05/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import UIKit
import GBDeviceInfo

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let deviceInfo = GBDeviceInfo.deviceInfo() else { return }

        print("Major device ver: \(deviceInfo.deviceVersion.major)")
        print("Major device ver: \(deviceInfo.deviceVersion.minor)")
        print("systemInfo: \(deviceInfo.rawSystemInfoString ?? "")")
    }
}
