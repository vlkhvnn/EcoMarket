//
//  CategoryScroll.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 06.11.2023.
//

import UIKit

final class CategoryScroll: UIButton {
    
    public var productCategory : ProductCategory? {
        didSet {
            guard let category = productCategory else { return }
            label.text = category.name
        }
    }
    
    public let label : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 210/255, green: 209/255, blue: 213/255, alpha: 1)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        self.layer.cornerRadius = 14
        self.addSubview(label)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor(red: 210/255, green: 209/255, blue: 213/255, alpha: 1).cgColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.sizeToFit() // Adjust label size based on its content
        let labelWidth = label.frame.size.width
        let viewWidth = labelWidth + 24 // 24 pixels added to the label width
        frame.size = CGSize(width: viewWidth, height: 28)
        let centerY = frame.height / 2
        label.frame = CGRect(x: (viewWidth - labelWidth) / 2, y: centerY - (label.frame.size.height / 2), width: labelWidth, height: label.frame.size.height)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
