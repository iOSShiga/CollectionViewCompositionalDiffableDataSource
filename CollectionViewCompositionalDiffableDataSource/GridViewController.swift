//
//  ViewController.swift
//  CollectionViewCompositionalDiffableDataSource
//
//  Created by Suresh Shiga on 14/02/20.
//  Copyright © 2020 Suresh Shiga. All rights reserved.
//

import UIKit

struct Animal: Hashable {
    let name: String
}

let animals = [
Animal(name: "lion"),
Animal(name: "tiger"),
Animal(name: "crocodile"),
Animal(name: "cat"),
Animal(name: "snake"),
Animal(name: "fox"),
Animal(name: "deer"),
Animal(name: "elephant")
]

class GridViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    private var collectionView: UICollectionView! = nil
    private var dataSource: UICollectionViewDiffableDataSource<Section, Animal>! = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureHierarchy()
        configureDataSource()
    }


}


extension GridViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
       
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(200))
       
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.backgroundColor = .black
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.register(GridCell.self, forCellWithReuseIdentifier: GridCell.reuseIdentifier)
        
        view.addSubview(collectionView)
    }
}


extension GridViewController {
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Animal>(collectionView: collectionView, cellProvider: { (collectionView: UICollectionView, indexPath: IndexPath, animal: Animal) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GridCell.reuseIdentifier, for: indexPath) as? GridCell else {fatalError("Could not implemented cell")}
            cell.imageView.image = UIImage(named: animal.name)
            
            return cell
        })
        
        createSnapShot()
    }
    
    private func createSnapShot() {
        var snapShot = NSDiffableDataSourceSnapshot<Section, Animal>()
        snapShot.appendSections([.main])
        snapShot.appendItems(animals)
        dataSource.apply(snapShot, animatingDifferences: true)
    }
}
