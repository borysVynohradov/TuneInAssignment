//
//  UICollectionViewDiffableDataSource.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 30.12.2022.
//

import UIKit

// Simple single-type UICollectionViewDiffableDataSource
extension UICollectionViewDiffableDataSource {
    static func make<T: UICollectionViewCell & ReusableCell>(
        collectionView: UICollectionView,
        cellType: T.Type
    ) -> UICollectionViewDiffableDataSource<Int, T.CellModel> {
        if let nibName = T.nibName {
            collectionView.register(
                UINib(nibName: nibName, bundle: .main),
                forCellWithReuseIdentifier: T.reuseIdentifier
            )
        } else {
            collectionView.register(
                T.self,
                forCellWithReuseIdentifier: T.reuseIdentifier
            )
        }
        

        return .init(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, model in
                let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: T.reuseIdentifier,
                    for: indexPath
                ) as! T
                
                cell.configure(with: model)
                
                return cell
            }
        )
    }
}
