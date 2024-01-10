//
//  MainTabBarViewController.swift
//  EcoMarket
//
//  Created by Alikhan Tangirbergen on 05.11.2023.
//

import UIKit

final class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.isUserInteractionEnabled = true
        view.backgroundColor = .red
        let vc1 = UINavigationController(rootViewController: MainViewController())
        let vc2 = UINavigationController(rootViewController: CartViewController())
        let vc3 = UINavigationController(rootViewController: HistoryViewController())
        let vc4 = UINavigationController(rootViewController: InfoViewController())
        
        vc1.tabBarItem.image = UIImage(named: "home-03")
        vc2.tabBarItem.image = UIImage(named: "bag-03")
        vc3.tabBarItem.image = UIImage(named: "clock-01")
        vc4.tabBarItem.image = UIImage(named: "help-square-contained")
        
        vc1.title = "Главная"
        vc2.title = "Корзина"
        vc3.title = "История"
        vc4.title = "Инфо"
        
        tabBar.tintColor = UIColor(red: 117/255, green: 219/255, blue: 27/255, alpha: 1)
        navigationController?.navigationBar.prefersLargeTitles = true
        setViewControllers([vc1, vc2, vc3, vc4], animated: true)
    }

}
