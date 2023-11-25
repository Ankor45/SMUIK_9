//
//  ViewController.swift
//  SMUIK_9
//
//  Created by Andrei Kovryzhenko on 25.11.2023.
//

import UIKit

class ViewController: UIViewController {

    private let layout = UICollectionViewFlowLayout()
    private lazy var collectionView = UICollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Collection"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        setUpCollectionView()
        setUpLayout()
    }
    
    private func setUpLayout() {
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 350, height: 400)
        layout.sectionInsetReference = .fromLayoutMargins
    }

    private func setUpCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        view.addSubview(collectionView)
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = .systemGray5
        cell.layer.cornerRadius = 12
        return cell
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: 0)
        
        targetContentOffset.pointee = offset
    }
}

