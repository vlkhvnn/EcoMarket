//
//  CustomAlert.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 09.11.2023.
//

import UIKit

class CustomAlert: UIView {
    
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
        label.text = "Дата и время \(Date().formatted())"
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
    
    var exitController: (() -> ())
    
    init(exitButton: @escaping (() -> ())) {
        self.exitController = exitButton
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 16
        [imageView, orderNumber, dateAndTimeLabel, goToShoppingButton].forEach { self.addSubview($0)}
        goToShoppingButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func didTapBack() {
        exitController()
        CartService.shared.clearCart()
        if let window = UIApplication.shared.keyWindow {
            if let rootViewController = window.rootViewController {
                // Check if the root view controller is a tab bar controller
                if let tabBarController = rootViewController as? MainTabBarController {
                    // Switch to the MainTabBarController
                    tabBarController.selectedIndex = 0 // Change the index as needed to navigate to the desired tab
                }
            }
        }
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
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(24)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
        
        dateAndTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(orderNumber.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
        }
    }
}
