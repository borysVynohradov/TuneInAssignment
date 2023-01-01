//
//  ReusableCell.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 28.12.2022.
//

import UIKit

protocol ReusableCell {
    static var nibName: String? { get }
    static var reuseIdentifier: String { get }
    
    associatedtype CellModel: Hashable & Sendable
    
    func configure(with model: CellModel)
}

extension ReusableCell {
    static var nibName: String? { String(describing: Self.self) }
    static var reuseIdentifier: String { String(describing: Self.self) }
}
