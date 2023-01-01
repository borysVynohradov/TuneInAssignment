//
//  UIStoryboard+Instantiate.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 01.01.2023.
//

import UIKit

extension UIStoryboard {
    func instantiateViewController<T: UIViewController>(creator: ((T) -> Void)?) -> T {
        let storyboardID = String(describing: T.self)
        return instantiateViewController(identifier: storyboardID) { coder in
            let controller = T(coder: coder)!
            creator?(controller)
            return controller
        }
    }
}
