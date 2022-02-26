//
//  UITableViewExtension.swift
//  DigitalShowroom
//
//  Created by Vikas Kharb on 30/01/2022.
//

import UIKit

extension UITableView {
    func register<T: RegistrableCellProtocol>(_: T.Type) {
        register(T.self, forCellReuseIdentifier: T.defaultIdentifier)
    }
}
