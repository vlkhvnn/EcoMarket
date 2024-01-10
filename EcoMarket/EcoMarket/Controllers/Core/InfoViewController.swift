//
//  InfoViewController.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 05.11.2023.
//

import UIKit

final class InfoViewController: UIViewController {
    
    private let imageView : UIImageView = {
       let img = UIImageView()
        img.image = UIImage(named: "background")
        img.contentMode = .scaleToFill
        return img
    }()
    
    private let nameLabel : UILabel = {
       let label = UILabel()
        label.text = "Эко Маркет"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        return label
    }()
    
    private let descriptionLabel : UILabel = {
       let label = UILabel()
        label.text = "Фрукты, овощи, зелень, сухофрукты а так же сделанные из натуральных ЭКО продуктов (варенье, салаты, соления, компоты и т.д.) можете заказать удобно, качественно и по доступной цене. Готовы сотрудничать взаимовыгодно с магазинами. Наши цены как на рынке. Мы заинтересованы в экономии ваших денег и времени. Стоимость доставки 150 сом и ещё добавлен для окраину города. При отказе подтвержденного заказа более 2-х раз Клиент заносится в чёрный список!!"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.textColor = Colors.shared.gray
        return label
    }()
    
    private let callview = CustomInfo()
    
    private let whatsAppView = CustomInfo()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupConstraints()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        [imageView, nameLabel, descriptionLabel, callview, whatsAppView].forEach { view.addSubview($0) }
        callview.imageName = "phone"
        callview.text = "Позвонить"
        whatsAppView.imageName = "whatsapp"
        whatsAppView.text = "WhatsApp"
    }
    
    private func setupConstraints() {
        
        imageView.snp.makeConstraints {
            $0.top.right.left.equalToSuperview()
            $0.height.equalTo(270)
        }
        
        nameLabel.snp.makeConstraints {
            $0.top.equalTo(imageView.snp.bottom).offset(16)
            $0.left.equalToSuperview().offset(16)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.left.right.equalTo(view).inset(16)
            $0.top.equalTo(nameLabel.snp.bottom).offset(8)
        }
        
        callview.snp.makeConstraints {
            $0.right.left.equalToSuperview().inset(16)
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(36)
            $0.height.equalTo(54)
        }
        
        whatsAppView.snp.makeConstraints {
            $0.right.left.equalToSuperview().inset(16)
            $0.top.equalTo(callview.snp.bottom).offset(12)
            $0.height.equalTo(54)
        }
    }
}
