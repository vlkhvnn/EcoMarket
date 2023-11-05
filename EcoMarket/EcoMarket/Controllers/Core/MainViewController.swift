//
//  MainViewController.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 05.11.2023.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private var productCategories = [ProductCategory]()
    
    let sectionInsets = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
    
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let newCollectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        return newCollectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        let titleLabel = UILabel()
        titleLabel.text = "Эко Маркет"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.sizeToFit()
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        setUI()
    }
    
    private func setUI() {
        [collectionView].forEach { view.addSubview($0)}
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ProductCategoryCollectionViewCell.self, forCellWithReuseIdentifier: ProductCategoryCollectionViewCell.identifier)
        getCategories()
        applyConstraints()
    }
    
    private func getCategories() {
        APIService.shared.fetchProductCategory { apiData in
            self.productCategories = apiData
            self.productCategories.sort { $0.id < $1.id }
            self.collectionView.reloadData()
        }
    }
    
    private func applyConstraints() {
        collectionView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
}

extension MainViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.productCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCategoryCollectionViewCell.identifier, for: indexPath) as? ProductCategoryCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.category = self.productCategories[indexPath.row]
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        return cell
    }
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingSpace = sectionInsets.left + sectionInsets.right + 11
        let availableWidth = collectionView.bounds.width - paddingSpace
        let widthPerItem = availableWidth / 2
        return CGSize(width: widthPerItem, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 11
    }
    
}
