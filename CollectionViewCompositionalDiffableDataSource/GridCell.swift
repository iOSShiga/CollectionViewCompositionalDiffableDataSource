//
//  GridCell.swift
//  CollectionViewCompositionalDiffableDataSource
//
//  Created by Suresh Shiga on 14/02/20.
//  Copyright © 2020 Suresh Shiga. All rights reserved.
//

import UIKit

final class GridCell: UICollectionViewCell {
    
    static let reuseIdentifier = "grid-cell-reuse-identifier"
    let imageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not implemented")
    }
}

extension GridCell {
    private func configure() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10.0
        imageView.layer.masksToBounds = true
        contentView.addSubview(imageView)
        
        let inset:CGFloat = 10.0
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: inset),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -inset),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: inset),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -inset)
        ])
    }
}
