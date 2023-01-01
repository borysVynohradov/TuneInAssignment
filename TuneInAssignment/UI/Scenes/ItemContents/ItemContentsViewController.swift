//
//  ItemContentsViewController.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 01.01.2023.
//

import UIKit

class ItemContentsViewController: UIViewController {
    
    // Outlets
    @IBOutlet private var tableView: UITableView!
    @IBOutlet private var activityIndicatorView: UIActivityIndicatorView!
    
    // Table view
    private lazy var dataSource = {
        MainTableViewDataSource(tableView: tableView)
    }()
    
    // Dependencies
    var presenter: ItemContentsPresenterInput!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        presenter.fetchContents()
    }
}

// MARK: - Configuration
private extension ItemContentsViewController {
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = dataSource
    }
}

// MARK: - Presenter output
extension ItemContentsViewController: ItemContentsPresenterOutput {
    func updateActivityIndicator(isActive: Bool) {
        isActive ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
    }
    
    func displayItems(_ items: [String : [DirectoryItemTableViewCellModel]]) {
        var snapshot = NSDiffableDataSourceSnapshot<String, DirectoryItemTableViewCellModel>()
        snapshot.appendSections(Array(items.keys).sorted(by: <))
        items.forEach { snapshot.appendItems($0.value, toSection: $0.key) }
        
        dataSource.shouldDisplayHeaders = snapshot.sectionIdentifiers.count > 1
        dataSource.apply(snapshot, animatingDifferences: false) { [weak self] in
            self?.tableView.setContentOffset(.zero, animated: false)
        }
    }
}

// MARK: - UITableViewDelegate
extension ItemContentsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let snapshot = dataSource.snapshot()
        let section = snapshot.sectionIdentifiers[indexPath.section]
        let item = dataSource.snapshot().itemIdentifiers(inSection: section)[indexPath.item]
        
        presenter.openItem(item)
    }
}
