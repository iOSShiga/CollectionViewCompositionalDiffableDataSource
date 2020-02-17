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
    Animal(name: "bear"),
    Animal(name: "bull"),
    Animal(name: "camel"),
    Animal(name: "chipmunk"),
    Animal(name: "dog"),
    Animal(name: "dolphin"),
    Animal(name: "eagle"),
    Animal(name: "gorilla"),
    Animal(name: "hippo"),
    Animal(name: "macaw"),
    Animal(name: "owl"),
    Animal(name: "panda"),
    Animal(name: "shark"),
    Animal(name: "sheep"),
    Animal(name: "squirrel"),
    Animal(name: "woodpecker"),
    Animal(name: "lion"),
    Animal(name: "tiger"),
    Animal(name: "crocodile"),
    Animal(name: "cat"),
    Animal(name: "snake"),
    Animal(name: "fox"),
    Animal(name: "deer"),
    Animal(name: "elephant"),
    Animal(name: "buffalo"),
    Animal(name: "leopard"),
    Animal(name: "giraffe"),
    Animal(name: "kangaaroo"),
    Animal(name: "cougar"),
    Animal(name: "sealion"),
    Animal(name: "jauar"),
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
        
        self.navigationItem.title = "Album"

        configureHierarchy()
        configureDataSource()
    }


}


extension GridViewController {
    
    private func createLayout() -> UICollectionViewLayout {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
       
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
       
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        
        return layout
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.delegate = self
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
            cell.backgroundColor = .black
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


extension GridViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        
        configureContextmenu()
    }
    
    
    func configureContextmenu() -> UIContextMenuConfiguration {
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { (action) -> UIMenu? in
            
            let viewMenu = UIAction(title: "View", image: UIImage(systemName: "square.and.arrow.up"), identifier: UIAction.Identifier(rawValue: "view")) { (_) in
                print("button clicked...")
            }
            
            let rotate = UIAction(title: "Rotate", image: UIImage(systemName: "arrow.counterclockwise"), identifier: nil, state: .off) { (action) in
                print("rotate clicked")
            }
            
            
            let delete = UIAction(title: "Delete", image: UIImage(systemName: "trash"), identifier: nil, discoverabilityTitle: nil, attributes: .destructive, state: .off) { (action) in
                print("delete clicked.")
            }
            
            let editMenu = UIMenu(title: "Edit...", children: [rotate, delete])
            
            return UIMenu(title: "Options", image: nil, identifier: nil, options: UIMenu.Options.displayInline, children: [viewMenu, editMenu])
        }

       return configuration
    }
}

