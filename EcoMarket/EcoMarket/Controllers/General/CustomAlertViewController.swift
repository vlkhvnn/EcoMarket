//
//  CustomAlertViewController.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 09.11.2023.
//

import UIKit

class CustomAlertViewController: UIViewController {
    
    private let imageView : UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "bagHappy")
        img.contentMode = .scaleAspectFill
        return img
    }()
    
    private let orderNumber : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        label.text = "Заказ №343565657 оформлен"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()

    private let dateAndTimeLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = UIColor(red: 172/255, green: 171/255, blue: 173/255, alpha: 1)
        label.text = "Дата и время \(Date())"
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private var goToShoppingButton : UIButton = {
        let button = UIButton()
        button.setTitle("Перейти в магазин", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        view.backgroundColor = .white
        [imageView, orderNumber, dateAndTimeLabel, goToShoppingButton].forEach { view.addSubview($0)}
        
    }
    
    private func applyConstraints() {
        
        goToShoppingButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-24)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(54)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(36)
            make.centerX.equalToSuperview()
            make.height.equalTo(200)
            make.width.equalTo(163)
        }
        
        orderNumber.snp.makeConstraints { make in
            <#code#>
        }
    }
    
}
