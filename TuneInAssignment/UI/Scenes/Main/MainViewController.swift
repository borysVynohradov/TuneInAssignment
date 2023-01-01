//
//  MainViewController.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 24.12.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    // Outlets
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var containerView: UIView!
    
    // Collection view
    private lazy var collectionViewDataSource = {
        UICollectionViewDiffableDataSource<Int, CategoryCollectionViewCellModel>.make(
            collectionView: collectionView,
            cellType: CategoryCollectionViewCell.self
        )
    }()
    
    private lazy var collectionViewLayout = UICollectionViewCompositionalLayout.horizontalList(interGroupSpacing: 8)
    
    // Dependencies
    var presenter: MainPresenter!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureCollectionView()
        presenter.fetchContents()
    }
}

// MARK: - Configuration
private extension MainViewController {
    func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = collectionViewDataSource
        collectionView.setCollectionViewLayout(collectionViewLayout, animated: false)
    }
}

// MARK: - Presenter output
extension MainViewController: MainPresenterOutput {
    
    var container: UIView { containerView }
    
    func displayItems(_ categories: [CategoryCollectionViewCellModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Int, CategoryCollectionViewCellModel>()
        snapshot.appendSections([0])
        snapshot.appendItems(categories, toSection: 0)

        collectionViewDataSource.apply(snapshot)
    }
    
    func selectDefaultItem(at index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView.selectItem(
            at: indexPath,
            animated: false,
            scrollPosition: .left
        )
        
        collectionView(collectionView, didSelectItemAt: indexPath)
    }
}

// MARK: - UICollectionViewDelegate
extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.selectItem(at: indexPath)
    }
}
