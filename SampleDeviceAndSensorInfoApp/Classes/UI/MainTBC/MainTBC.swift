//
//  MainTBC.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 05/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import UIKit

class MainTBC: UITabBarController {

    private enum TabController: Int, CaseIterable {
        case info
        case magnetometer
        case deviceMotion
        case accelerometer
        case gyroscope
    }

    private lazy var activeTabIndicator: UIView = {
        let v = UIView()
        v.frame = CGRect(x: 0, y: 0, width: segmentWidth, height: 2)
        v.backgroundColor = UIColor.systemBlue
        return v
    }()

    private var segmentWidth: CGFloat {
        return tabBar.frame.width / CGFloat(TabController.allCases.count)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeActiveIndicator()
    }

    private func initializeActiveIndicator() {
        tabBar.addSubview(activeTabIndicator)
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let index = tabBar.items?.firstIndex(of: item) else { return }
        animateSelection(for: TabController(rawValue: index))
    }

    private func animateSelection(for ctr: TabController?) {
        guard let ctr = ctr else { return }

        let x = segmentWidth * CGFloat(ctr.rawValue)

        var fr = activeTabIndicator.frame
        fr.origin.x = x

        UIView.animate(withDuration: 0.2) { [weak self] in
            self?.activeTabIndicator.frame = fr
        }
    }
}
