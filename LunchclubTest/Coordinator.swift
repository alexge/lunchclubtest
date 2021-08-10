//
//  Coordinator.swift
//  LunchclubTest
//
//  Created by Alexander Ge on 06/08/2021.
//

import UIKit


class Coordinator {
    var root: UINavigationController?
    
    func start() {
        let vc = ViewController()
        vc.delegate = self
        root = UINavigationController(rootViewController: vc)
    }
}

extension Coordinator: ViewControllerDelegate {
    func didSelectContact(_ contact: LCContact) {
        let detail = DetailViewController(contact: contact)
        root?.pushViewController(detail, animated: true)
    }
}
