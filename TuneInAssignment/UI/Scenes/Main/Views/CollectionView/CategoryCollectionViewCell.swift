//
//  CategoryCollectionViewCell.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 28.12.2022.
//

import UIKit

class CategoryCollectionViewCell: UICollectionViewCell, ReusableCell {
    typealias CellModel = CategoryCollectionViewCellModel
    
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var underlineView: UIView!
    
    override var isSelected: Bool {
        didSet {
            updateSelectedState()
        }
    }
    
    func configure(with model: CategoryCollectionViewCellModel) {
        nameLabel.text = model.name
        updateSelectedState()
    }
    
    private func updateSelectedState() {
        nameLabel.textColor = isSelected ? .label : .secondaryLabel
        underlineView.isHidden = !isSelected
    }
}

