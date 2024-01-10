//
//  OrderCollectionViewCell.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 10.11.2023.
//

import UIKit

final class OrderCollectionViewCell: UICollectionViewCell {
    static let identifier = "OrderCollectionViewCell"
    
    var order : OrderModel? {
        didSet {
            guard let order = order else {return}
            numberLabel.text = "Заказ №\(order.order_number)"
            priceLabel.text = "\(order.total_amount) тг"
            timeLabel.text = "\(order.created_at!.formatted())"
        }
    }
    
    private let circle : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22
        view.backgroundColor = Colors.shared.green
        return view
    }()
    
    private let imageView : UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleToFill
        img.tintColor = .white
        img.image = UIImage(named: "bag-03")?.withRenderingMode(.alwaysTemplate)
        return img
    }()
    
    private let numberLabel : UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private let timeLabel : UILabel = {
        let label = UILabel()
         label.font = .systemFont(ofSize: 14, weight: .regular)
         label.textColor = .darkGray
         return label
    }()
    
    private let priceLabel : UILabel = {
        let label = UILabel()
         label.font = .systemFont(ofSize: 20, weight: .bold)
         label.textColor = Colors.shared.green
         return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        circle.addSubview(imageView)
        self.layer.cornerRadius = 16
        self.backgroundColor =  Colors.shared.lightGray
        [circle, numberLabel, timeLabel, priceLabel].forEach { self.addSubview($0)}
    }
    
    private func setupConstraints() {
        circle.snp.makeConstraints {
            $0.left.equalToSuperview().offset(12)
            $0.top.equalToSuperview().offset(13)
            $0.bottom.equalToSuperview().offset(-14)
            $0.width.equalTo(43)
        }
        
        imageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        numberLabel.snp.makeConstraints {
            $0.left.equalTo(circle.snp.right).offset(8)
            $0.top.equalToSuperview().offset(15)
        }
        
        timeLabel.snp.makeConstraints {
            $0.left.equalTo(circle.snp.right).offset(8)
            $0.top.equalTo(numberLabel.snp.bottom).offset(2)
        }
        
        priceLabel.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-12)
            $0.top.equalToSuperview().offset(17)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
