//
//  DependencyAssembler.swift
//  SampleDeviceAndSensorInfoApp
//
//  Created by Mihais Tumkins on 06/11/2019.
//  Copyright © 2019 Mihails Tumkins. All rights reserved.
//

import Swinject

class DependencyAssembler {
    static let shared = DependencyAssembler()
    var dependencies: [Assembly] = [] {
        didSet {
            configureDI()
        }
    }

    var resolver: Resolver {
        return assebmler.resolver
    }

    private let assebmler = Assembler(container: Container())

    private func configureDI() {
        assebmler.apply(assemblies: self.dependencies)
    }

    class func with(_ dependencies: [Assembly]) {
        shared.dependencies = dependencies
    }
}
