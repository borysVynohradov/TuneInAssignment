//
//  MainTableViewDataSource.swift
//  TuneInAssignment
//
//  Created by Borys Vynohradov on 30.12.2022.
//

import UIKit

class MainTableViewDataSource: UITableViewDiffableDataSource<String, DirectoryItemTableViewCellModel> {
    var shouldDisplayHeaders: Bool = true
    
    init(tableView: UITableView) {
        tableView.register(
            UINib(nibName: DirectoryItemTableViewCell.nibName!, bundle: .main),
            forCellReuseIdentifier: DirectoryItemTableViewCell.reuseIdentifier
        )

        super.init(
            tableView: tableView,
            cellProvider: { tableView, indexPath, model in
                let cell = tableView.dequeueReusableCell(
                    withIdentifier: DirectoryItemTableViewCell.reuseIdentifier,
                    for: indexPath
                ) as! DirectoryItemTableViewCell
                
                cell.configure(with: model)
                
                return cell
            }
        )
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        shouldDisplayHeaders ? snapshot().sectionIdentifiers[section] : nil
    }
}
