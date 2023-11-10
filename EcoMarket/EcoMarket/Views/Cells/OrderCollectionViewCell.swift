//
//  OrderCollectionViewCell.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 10.11.2023.
//

import UIKit

class OrderCollectionViewCell: UICollectionViewCell {
    static let identifier = "OrderCollectionViewCell"
    
    var order : OrderModel? {
        didSet {
            guard let order = order else {return}
            numberLabel.text = "Заказ №\(order.order_number)"
            priceLabel.text = "\(order.total_amount)"
            timeLabel.text = "\(order.created_at!.formatted())"
        }
    }
    
    private let circle : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 22
        view.backgroundColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1)
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
         label.textColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1)
         return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    private func setUI() {
        circle.addSubview(imageView)
        self.layer.cornerRadius = 16
        self.backgroundColor =  UIColor(red: 248/255, green: 248/255, blue: 248/255, alpha: 1)
        [circle, numberLabel, timeLabel, priceLabel].forEach { self.addSubview($0)}
        applyConstraints()
    }
    
    private func applyConstraints() {
        circle.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(13)
            make.bottom.equalToSuperview().offset(-14)
            make.width.equalTo(43)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(24)
            make.height.equalTo(24)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.left.equalTo(circle.snp.right).offset(8)
            make.top.equalToSuperview().offset(15)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(circle.snp.right).offset(8)
            make.top.equalTo(numberLabel.snp.bottom).offset(2)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(17)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
