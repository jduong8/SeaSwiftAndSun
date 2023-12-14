//
//  HomeViewController.swift
//  SeaSwiftAndSun-Simplon
//
//  Created by Mahdia Amriou on 14/12/2023.
//

import UIKit
import SwiftUI

class HomeViewController: UIViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()

        let vcApple = UIHostingController(rootView: SingInWitAppleView())
        addChild(vcApple)
        view.addSubview(vcApple.view)
        vcApple.didMove(toParent: self)
        vcApple.view.translatesAutoresizingMaskIntoConstraints = false
        vcApple.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        vcApple.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
//        vcApple.view.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        vcApple.view.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
   
}

