//
//  AppCoordinator.swift
//  CoordinatorDemo
//
//  Created by Charles Hsieh on 2021/4/7.
//

import Coordinator
import UIKit

final class AppCoordinator: Coordinator<Bool> {
    private let window: UIWindow

    init(window: UIWindow) {
        self.window = window
    }

    override func start(onCompleted: @escaping (Bool) -> Void) {
        window.rootViewController = ViewController.initFromStoryboard()
        window.makeKeyAndVisible()
    }
}
