//
//  ProductCategoryCollectionViewCell.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 05.11.2023.
//

import UIKit
import Kingfisher

final class ProductCategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = "ProductCategoryCollectionViewCell"
    public var category : ProductCategory? {
        didSet {
            guard let category = category else {return}
            setImage(url: category.image)
            label.text = category.name
        }
    }
    
    private let imageOverlay: UIView = {
        let overlay = UIView()
        overlay.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        return overlay
    }()
    
    private let imageView : UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    private let label : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setUI() {
        self.backgroundColor = .white
        [imageView, imageOverlay, label].forEach { self.addSubview($0) }
        applyConstraints()
        self.isUserInteractionEnabled = true
    }
    
    private func applyConstraints() {
        
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        imageOverlay.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        label.snp.makeConstraints {
            $0.left.bottom.equalTo(imageView).inset(12)
            $0.right.equalToSuperview().offset(-12)
        }
    }
    
    private func setImage(url : String) {
        guard let downloadURL = URL(string: url) else {return}
        let resourse = ImageResource(downloadURL: downloadURL)
        self.imageView.kf.setImage(with: resourse)
    }
}
