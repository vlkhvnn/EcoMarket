//
//  OrderConfirmationViewController.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 09.11.2023.
//

import UIKit

class OrderConfirmationViewController: UIViewController {
    
    private var numberTextField = CustomUnderlineTextField()
    
    private var addressTextField = CustomUnderlineTextField()
    
    private var orientirTextField = CustomUnderlineTextField()
    
    private var commentsTextField = CustomUnderlineTextField()
    
    private let totalLabel : UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.text = "Сумма заказа \(CartService.shared.calculateTotalSumma() + 150) тг"
        label.textColor = .black
        return label
    }()
    
    private var confirmButton : UIButton = {
        let button = UIButton()
        button.setTitle("Заказать доставку", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = UIColor.lightGray
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 16
        button.isEnabled = false
        button.addTarget(self, action: #selector(showAlertWithImage), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    private func setUI() {
        navigationItem.title = "Оформление заказа"
        [numberTextField, addressTextField, orientirTextField, commentsTextField, totalLabel, confirmButton].forEach { view.addSubview($0) }
        view.backgroundColor = .white
        numberTextField.placeh = "Номер телефона"
        numberTextField.keyboardType = .numberPad
        addressTextField.placeh = "Адрес"
        orientirTextField.placeh = "Ориентир"
        commentsTextField.placeh = "Комментарии"
        numberTextField.delegate = self
        addressTextField.delegate = self
        orientirTextField.delegate = self
        commentsTextField.delegate = self
        applyConstraints()
    }
    
    private func updateButtonAppearance() {
        guard let numberText = numberTextField.text, !numberText.isEmpty,
              let addressText = addressTextField.text, !addressText.isEmpty,
              let orientirText = orientirTextField.text, !orientirText.isEmpty,
              let commentsText = commentsTextField.text, !commentsText.isEmpty else {
            confirmButton.backgroundColor = UIColor.lightGray // If any field is empty, set the button to a disabled state
            confirmButton.isEnabled = false
            return
        }
        
        confirmButton.backgroundColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1) // All fields are filled, enable the button and change its color
        confirmButton.isEnabled = true
    }
    
    @objc private func showAlertWithImage() {
        let alertController = UIAlertController(title: "Alert with Image", message: "This alert includes an image", preferredStyle: .alert)
        
        // Create a UIImageView with the desired image
        let imageView = UIImageView(frame: CGRect(x: 50, y: 70, width: 100, height: 100)) // Customize the frame as needed
        imageView.image = UIImage(named: "bagHappy") // Set your desired image
        imageView.contentMode = .scaleAspectFit // Set the content mode as per your image requirements
        
        // Add the image view to the alert controller
        alertController.view.addSubview(imageView)
        
        // Create actions for the alert
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(defaultAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    private func applyConstraints() {
        numberTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(24)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        addressTextField.snp.makeConstraints { make in
            make.top.equalTo(numberTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        orientirTextField.snp.makeConstraints { make in
            make.top.equalTo(addressTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        commentsTextField.snp.makeConstraints { make in
            make.top.equalTo(orientirTextField.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(50)
        }
        
        confirmButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(54)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.bottom.equalTo(confirmButton.snp.top).offset(-16)
            make.centerX.equalTo(confirmButton.snp.centerX)
        }
    }
}

extension OrderConfirmationViewController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        updateButtonAppearance() // Update button appearance on text changes
        return true
    }
}
