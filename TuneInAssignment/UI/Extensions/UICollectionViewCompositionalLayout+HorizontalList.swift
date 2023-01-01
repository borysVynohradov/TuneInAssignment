//
//  UICollectionViewCompositionalLayout+HorizontalList.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 29.12.2022.
//

import UIKit

extension UICollectionViewCompositionalLayout {
    static func horizontalList(interGroupSpacing: CGFloat) -> UICollectionViewCompositionalLayout {
        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.scrollDirection = .horizontal
        
        return UICollectionViewCompositionalLayout(
            sectionProvider: { _, _ in
                let item = NSCollectionLayoutItem(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .estimated(100),
                        heightDimension: .fractionalHeight(1)
                    )
                )
                
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: NSCollectionLayoutSize(
                        widthDimension: .estimated(100),
                        heightDimension: .fractionalHeight(1)
                    ),
                    subitems: [item]
                )
                
                let section = NSCollectionLayoutSection(group: group)
                section.interGroupSpacing = interGroupSpacing

                return section
            },
            configuration: config
        )
    }
}
