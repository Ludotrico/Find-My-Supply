//
//  ContainerController.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/8/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class ContainerController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        configureHomeController()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //print("+++ CONTAINER WILL APPEAR")
    }
    
    var homeController: HomeController!
    var menuController: MenuController!
    var centerController: UINavigationController!
    var isExpanded = false

    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return StatusBarColor.shared.isDark ? .darkContent : .lightContent
    }
    
    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return .slide
    }
    
    override var prefersStatusBarHidden: Bool {
        return isExpanded
    }
    
    func configureHomeController() {
        homeController = HomeController()
        homeController.delegate = self
        //homeController.view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(closeMenu)))
        
        centerController = UINavigationController(rootViewController: homeController)
        //centerController.navigationBar.isTranslucent = true
        centerController.navigationBar.isHidden = true
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true

        
        view.addSubview(centerController.view)
        addChild(centerController)
        centerController.didMove(toParent: self)
        
        //centerController.navigationBar.tintColor = Color.shared.theme
        
    }
    
    func configureMenuController() {
        if menuController == nil {
            menuController = MenuController()
            menuController.delegate = self
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            menuController.didMove(toParent: self)

            

            
            //print("+++CONFIGURe MENU")
        }
        
    }
    
    @objc func closeMenu() {
        //print("+++++CLOSE MENU")
        
    }
    
    func showMenuController(shouldExpand: Bool, option: Int?) {
        if shouldExpand {
            menuController.view.isHidden = false
            homeController.mapView.isUserInteractionEnabled = false
            homeController.tableView.isUserInteractionEnabled = false
            
            let swipe = UISwipeGestureRecognizer(target: self, action: #selector(handleMenuSwipe(sender: )))
            
               
            let pan = UIPanGestureRecognizer(target: self, action: #selector(handleMenuPan(gestureRecognizer: )))
            swipe.direction = .left
            view.addGestureRecognizer(swipe)
            view.addGestureRecognizer(pan)
            
            
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
                self.centerController.view.frame.origin.x = 250
            }, completion: nil)

        } else {
            view.gestureRecognizers?.forEach(view.removeGestureRecognizer)
            
            homeController.mapView.isUserInteractionEnabled = true
            homeController.tableView.isUserInteractionEnabled = true
            if let menuOption = option{
                self.didSelectMenuOption(option: menuOption)
            } else {  }
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseIn, animations: {
                self.centerController.view.frame.origin.x = 0
            }, completion: { _ in
                self.menuController.view.isHidden = true
            })
            
        }
        animateStatusBar()
        
    }
    
    func didSelectMenuOption(option: Int) {

        
        if option == 0 {
            centerController.pushViewController(ProfileController(), animated: true)
        }
        else if option == 1 {
            if UserDefaults.standard.bool(forKey: "isGold") {
            centerController.pushViewController(NotificationsController(), animated: true)
            } else {
                centerController.pushViewController(GoldController(), animated: true)
            }
        }
        else if option == 2 {
            let SC = SettingsController()
            SC.menuController = menuController
            SC.homeController = homeController
            centerController.pushViewController(SC, animated: true)
        }
        else if option == 3 {
            centerController.pushViewController(GoldController(), animated: true)
        }
        else {
            centerController.pushViewController(ContactUsController(), animated: true)
        }
    }
    
    func animateStatusBar() {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.setNeedsStatusBarAppearanceUpdate()
        }, completion: nil)
    }
    
    @objc func handleMenuSwipe(sender: UISwipeGestureRecognizer) {
        if sender.state == .ended {
            if sender.direction == .left {
                //print("+++SWIPED!")
                isExpanded = false
                showMenuController(shouldExpand: false, option: nil)
                
            }
        }
    }
    
    
    @objc func handleMenuPan(gestureRecognizer: UIPanGestureRecognizer) {
        
        let translation = gestureRecognizer.translation(in: self.view)
        let minBound = 125
        
        //print("+++view origin.x \(centerController.view.frame.origin.x)")
        //print("+++view origin.x \(translation.x)")
        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
         
            if centerController.view.frame.origin.x <= 250 {
                if centerController.view.frame.origin.x == 250 && translation.x > 0 {
                    gestureRecognizer.setTranslation(CGPoint(x: 0,y: 0), in: self.view)
                    return
                }
                else if centerController.view.frame.origin.x <= 0 && translation.x  < 0 {
                    gestureRecognizer.setTranslation(CGPoint(x: 0,y: 0), in: self.view)
                    return
                }
                
                self.centerController.view.center.x += translation.x
            }
            else {
                
            }
            //nearbyStoresView.center = CGPoint(x: nearbyStoresView.center.x, y: nearbyStoresView.center.y + translation.y)

        }
        else if (gestureRecognizer.state == UIGestureRecognizer.State.ended) || (gestureRecognizer.state == UIGestureRecognizer.State.cancelled) {
            
            //print("++++ ENDED w origin.x: \(centerController.view.frame.origin.x)")
            if centerController.view.frame.origin.x <= 125 {
  
                isExpanded = false
                showMenuController(shouldExpand: false, option: nil)
            }
//            else if centerController.view.frame.origin.x < 252 && centerController.view.frame.origin.x > 249 {
//
//            }
            else {
                isExpanded = true
                showMenuController(shouldExpand: true, option: nil)
            }
            
            
        }
        
        
        
        gestureRecognizer.setTranslation(CGPoint(x: 0,y: 0), in: self.view)
        
        
    }
    
    


}


extension ContainerController: HomeControllerDelegate {
    func handleMenuToggle(forMenuOption option: Int?) {
        if !isExpanded {
            configureMenuController()
        }
        
        isExpanded.toggle()
        showMenuController(shouldExpand: isExpanded, option: option)
    }
    

    
    
    
}
