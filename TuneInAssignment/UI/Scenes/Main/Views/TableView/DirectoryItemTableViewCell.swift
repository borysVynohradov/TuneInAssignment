//
//  DirectoryItemTableViewCell.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 29.12.2022.
//

import UIKit
import Nuke

class DirectoryItemTableViewCell: UITableViewCell, ReusableCell {
    typealias CellModel = DirectoryItemTableViewCellModel
    
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subtitleLabel: UILabel!
    @IBOutlet private var itemImageView: UIImageView!
    
    func configure(with model: DirectoryItemTableViewCellModel) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        itemImageView.isHidden = model.imageURL == nil
        
        if let imageURL = model.imageURL {
            Nuke.loadImage(with: imageURL, into: itemImageView)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        Nuke.cancelRequest(for: itemImageView)
        itemImageView.image = nil
        itemImageView.isHidden = false
    }
}
