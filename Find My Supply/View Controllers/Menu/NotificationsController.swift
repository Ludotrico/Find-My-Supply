//
//  NotificationsController.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/7/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit
import Nuke

class NotificationsController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
        if scheme == 0 {
            view.backgroundColor = .darkGray
        }
        else if scheme == 1 {
            view.backgroundColor =  .black
        } else {
            view.backgroundColor =  .white
            spinner.color = .black
            
        }
        
        
        view.addSubview(spinner)
        spinner.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: 100)
        spinner.isHidden = false
        
        
        
        configureViewComponents()

        // Do any additional setup after loading the view.
    }
    
      override func viewWillDisappear(_ animated: Bool) {
          self.navigationController?.navigationBar.isHidden = true
      }
      
      override func viewWillAppear(_ animated: Bool) {
   
          self.navigationController?.navigationBar.isHidden = false
      }
    
    
    //MARK: Views
    
    let notifItem: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(systemName: "bell.fill")
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view

    }()
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    
    let tableView: UITableView = {
        let view = UITableView()
        view.isScrollEnabled = false
        view.rowHeight = 100
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
        
        
    }()
    
    let noNotifsLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "No notifications have been added yet."
        lbl.textColor = .black //Dark mode
        lbl.textAlignment = .center
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        return lbl
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        spinner.isHidden = true
        spinner.color = Color.shared.gold
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    let spinner2: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.startAnimating()
        spinner.isHidden = true
        spinner.color = .black
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    //MARK: Variables
    var areaNotifications =  [notification]()
    var storeNotifications = [notification]()
    
    //MARK: Selectors
    @objc func deleteNotification(sender: AnyObject) {
        let btn = sender as! UIButton
        
        print("+++DELETE \(btn.tag)")
        
        var index = btn.tag
        if (index - 100000) < 0 {
            
            //case that its an area notif
            print("+++DELETE Area\(index)")
            
            

            
//            areaNotifications.remove(at: index)
            let indexPath = IndexPath(item: index, section: 0)
//
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData()
            
            handleDelete(indexPath: indexPath, sender: sender)


        }
        else {
            index -= 100000
            print("+++DELETE Store\(index)")
            
//            storeNotifications.remove(at: index)
            let indexPath = IndexPath(item: index, section: 1)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//            tableView.reloadData()
            handleDelete(indexPath: indexPath, sender: sender)

        }
        
    }
    
    
    
    //MARK: Helper Functions
    @objc func openImageController(_ sender: UITapGestureRecognizer) {
        let view = sender.view as! UIImageView
        print("+++ Open image #\(view.tag)")
        let IC = ImageController()
        IC.img.image = view.image
        navigationController?.pushViewController(IC, animated: true)
        
        
    }
    
    
    
    
    func deleteSKUStoreNotification(notif: notification, indexPath: IndexPath) {
        Notifications.shared.productID = notif.product__id!
        Notifications.shared.storeID = notif.store__id!
        Notifications.shared.date = notif.date!
        
        DispatchQueue.main.async {
            self.spinner2.isHidden = false
        }
        DispatchQueue.global(qos: .userInitiated).async {
            Notifications.shared.deleteSKUStoreNotification { (result) in
                switch result {
                case .success( _):
                    DispatchQueue.main.async {
                        self.storeNotifications.remove(at: indexPath.row)
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                        self.tableView.reloadData()
                        self.tableView.endUpdates()
                        
                        self.spinner2.isHidden = true
                    }
                case .failure(let error):
                    print("DEBUG: Failed with error \(error)")
                    DispatchQueue.main.async {
                        self.spinner2.isHidden = true
                        self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                    }
                }
                
            }
            
        }
        
        
    }
    
    
    func deleteSKURegionNotification(notif: notification, indexPath: IndexPath) {
        Notifications.shared.radius = notif.radius!
        Notifications.shared.productID = notif.product__id!
        Notifications.shared.date = notif.date!
        Notifications.shared.city = notif.city!.replacingOccurrences(of: " ", with: "_")
        
        DispatchQueue.main.async {
            self.spinner2.isHidden = false
        }
        DispatchQueue.global(qos: .userInitiated).async {
            Notifications.shared.deleteSKURegionNotification { (result) in
                switch result {
                case .success( _):
                    DispatchQueue.main.async {
                        self.areaNotifications.remove(at: indexPath.row)
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                        self.tableView.reloadData()
                        self.tableView.endUpdates()
                        self.spinner2.isHidden = true
                    }
                case .failure(let error):
                    print("DEBUG: Failed with error \(error)")
                    DispatchQueue.main.async {
                        self.spinner2.isHidden = true
                        self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                    }
                }
                
            }
            
        }
        
        
    }
    
    
    func deleteSupplyRegionNotification(notif: notification, indexPath: IndexPath) {
        Notifications.shared.supply = notif.supplyName!.replacingOccurrences(of: " ", with: "_")
        Notifications.shared.radius = notif.radius!
        print("#######\(notif.radius!)")
        Notifications.shared.date = notif.date!
        Notifications.shared.city = notif.city!.replacingOccurrences(of: " ", with: "_")
        
        DispatchQueue.main.async {
            self.spinner2.isHidden = false
        }
        DispatchQueue.global(qos: .userInitiated).async {
            Notifications.shared.deleteSupplyRegionNotification { (result) in
                switch result {
                case .success( _):
                    DispatchQueue.main.async {
                        self.areaNotifications.remove(at: indexPath.row)
                        self.tableView.deleteRows(at: [indexPath], with: .automatic)
                        self.tableView.reloadData()
                        self.tableView.endUpdates()
                        self.spinner2.isHidden = true
                    }
                case .failure(let error):
                    print("DEBUG: Failed with error \(error)")
                    DispatchQueue.main.async {
                        self.spinner2.isHidden = true
                        self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                    }
                }
                
            }
            
        }
        
        
    }
    
    
    
    func removeNotification(indexPath: IndexPath) {
        tableView.beginUpdates()
        
       
        if indexPath.section == 0 {
            let notif = areaNotifications[indexPath.row]
            
            if notif.supplyName != nil {
                deleteSupplyRegionNotification(notif: notif, indexPath: indexPath)
            }
            else {
                deleteSKURegionNotification(notif: notif, indexPath: indexPath)
            }
            
        }
        else {
            let notif = storeNotifications[indexPath.row]
            
            if notif.product__id != nil {
                deleteSKUStoreNotification(notif: notif, indexPath: indexPath)
            }
            
            
        }

        
        
    }
    
    func createLbl(text: String) -> UILabel {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.rgb(red: 209, green: 21, blue: 0)
        lbl.textColor = .white
        lbl.text = text
        lbl.font = UIFont.italicSystemFont(ofSize: 15.0)
        //lbl.sizeToFit()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        lbl.adjustsFontSizeToFitWidth  = true
        lbl.layer.cornerRadius = 10
        return lbl
    }
    
    
    func showMessage(label: UILabel) {
        

        self.view.addSubview(label)
        label.alpha = 1
        
      //     self.noNearbyStoresLbl.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        label.frame = CGRect(x: 0 ,y: self.view.frame.height, width: (self.view.frame.width/4)*3, height: 50)
        label.center.x = view.center.x
     
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                label.frame = CGRect(x: 0, y: self.view.frame.height - 100, width: (self.view.frame.width/4)*3, height: 50)
                label.center.x = self.view.center.x
            }, completion: { _ in
                    UIView.animate(withDuration: 2, delay: 2, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        label.alpha = 0
                    }, completion: { _ in
                        
                        label.removeFromSuperview()
                        label.alpha = 1
                    })
            })
        
    }
    
    
    
    
    func handleDelete(indexPath: IndexPath, sender: AnyObject) {
        let alert = UIAlertController(title: "Delete Notification", message: "Are you sure you want to delete this notification?", preferredStyle: .actionSheet)

        let DeleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in
            self.removeNotification(indexPath: indexPath)
        }
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)

        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)

        if let presenter = alert.popoverPresentationController {
            let s = sender as! UIView
            presenter.sourceView = s
            presenter.sourceRect = s.bounds
        }
        self.present(alert, animated: true, completion: nil)
        
        
    }
    
    
    func configureNoNotifsView() {
        scrollView.addSubview(noNotifsLbl)
        noNotifsLbl.anchor(top: scrollView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        noNotifsLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
    }
    
    
    func configureTableView() {
        scrollView.addSubview(tableView)
        
    
        let tableHeight = (125*(areaNotifications.count + storeNotifications.count)) + 57
        tableView.anchor(top: scrollView.topAnchor, left: scrollView.leftAnchor, bottom: scrollView.bottomAnchor, right: scrollView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: CGFloat(tableHeight))
        
        tableView.delegate = self
        tableView.dataSource = self
    
        tableView.separatorStyle = .none
        tableView.register(NotificationCell.self, forCellReuseIdentifier: "NotificationCell")
        scrollView.addSubview(tableView)
        
        
    }
    
    func configureViewComponents() {
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        getNotifications()
        
        view.backgroundColor = .darkGray   //Dark mode
        
        navigationItem.titleView = notifItem
        
        view.addSubview(spinner2)
        spinner2.anchor(top: nil, left: nil, bottom: view.bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 40, height: 40)
        spinner2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        configureColorScheme()
        
      
    }
    
    func configureColorScheme() {
        let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
        
        if scheme == 0 {
            //STANDARD
            view.backgroundColor = .darkGray
            tableView.backgroundColor = .darkGray
            
            notifItem.tintColor = .black
            
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
             noNotifsLbl.textColor = .black
            
            spinner2.color = .systemRed
            
    
            
        }
        else if scheme == 1 {
            //DARK
            view.backgroundColor = .black
            tableView.backgroundColor = .black
            
            notifItem.tintColor = .white
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = .black
            StatusBarColor.shared.isDark = false
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
             noNotifsLbl.textColor = .white
            spinner2.color = .systemRed
            

        }
        else {
            //LIGHT
            view.backgroundColor = .white
            tableView.backgroundColor = .white
            
            notifItem.tintColor = .black
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            noNotifsLbl.textColor = .black
            
            spinner2.color = .systemRed
            

            
            
        }
    }
    
    
    func getNotifications() {
        DispatchQueue.global(qos: .userInitiated).async {
            Notifications.shared.getAreaNotifications { (result) in
                switch result {
                case .success(let notifs):
                    print("+++\(notifs)")
                    DispatchQueue.main.async {
                        self.areaNotifications = notifs
                    }
                    
                    DispatchQueue.global(qos: .userInitiated).async {
                        Notifications.shared.getStoreNotifications { (result) in
                            switch result {
                            case .success(let notifs):
                                print("+++\(notifs)")
                                
                                DispatchQueue.main.async {
                                    self.storeNotifications = notifs
                                    
                                    if notifs.count == 0 && self.areaNotifications.count == 0 {
                                        self.configureNoNotifsView()
                                    } else {
                                    self.configureTableView()
                                    }
                                    self.spinner.removeFromSuperview()
                                }
                                
                            case .failure(let error):
                                print("DEBUG: Failed with error \(error)")
                                DispatchQueue.main.async {
                                    self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                                }
                            }
                        }
                    }
                    
                case .failure(let error):
                    print("DEBUG: Failed with error \(error)")
                    DispatchQueue.main.async {
                        self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                    }
                    
                }
            }
        }
        

    }
    
    @objc func test() {
        print("+++DELETE")
        
    }
    
    
}


extension NotificationsController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let cell = tableView.cellForRow(at: indexPath) as! NotificationCell
            handleDelete(indexPath: indexPath, sender: cell.deleteBtn)
//            if indexPath.section == 0 {
//                areaNotifications.remove(at: indexPath.row)
//            }
//            else {
//                storeNotifications.remove(at: indexPath.row)
//            }
//            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return areaNotifications.count
        }
        return storeNotifications.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        125
    }
    

    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Pending Area Notifications"
        }
        return "Pending Store Notifications"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("++++++Item\(indexPath.row)")
        
        if indexPath.section == 0 {

            
            let notif = areaNotifications[indexPath.row]
            

            let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
            cell.deleteBtn.addTarget(self, action: #selector(deleteNotification(sender:)), for: .touchUpInside)
            cell.deleteBtn.tag = indexPath.row
            
            let options = ImageLoadingOptions(
                failureImage: #imageLiteral(resourceName: "image-not-foundBIG")
                //Big: #imageLiteral(resourceName: "image-not-foundBIG")
            )
            
            
            
            if notif.product__name != nil {
                //Case that it is SKU notif
                if notif.store__chainName != nil {
                    cell.productName.text = notif.product__name!
                    Nuke.loadImage(with: URL(string: notif.product__imageLink!)!, options: options, into: cell.notifImage)
                    cell.titleStackLbl.text = notif.store__chainName!
                    cell.addressLbl.text = notif.store__address!
                    cell.dateLbl.text = notif.date?.replacingOccurrences(of: "-", with: "/")
                } else {
                    cell.productName.text = notif.product__name!
                    Nuke.loadImage(with: URL(string: notif.product__imageLink!)!, options: options, into: cell.notifImage)
                    cell.titleStackLbl.text = "\(notif.radius!) mile radius from \(notif.city!)"
                    cell.dateLbl.text = notif.date?.replacingOccurrences(of: "-", with: "/")
                }
                
            }
            else {
                cell.productName.text = notif.supplyName!
                let supply = notif.supplyName!
                print("+++\(supply)")
                switch supply{
                case "Face Masks":
                    cell.notifImage.image = #imageLiteral(resourceName: "mask")
                case "Gloves":
                    cell.notifImage.image = #imageLiteral(resourceName: "glove")
                case "Hand Sanitizer":
                    cell.notifImage.image = #imageLiteral(resourceName: "sanit")
                case "Soap":
                    cell.notifImage.image = #imageLiteral(resourceName: "soap")
                case "Toilet Paper":
                    cell.notifImage.image = #imageLiteral(resourceName: "TP")
                case "Disinfectant Wipes":  
                    cell.notifImage.image = #imageLiteral(resourceName: "wipe")
                case "Disinfectant Spray":
                    cell.notifImage.image = #imageLiteral(resourceName: "spray")
                default:
                    cell.notifImage.image = #imageLiteral(resourceName: "image-not-found")
                    
                    }
                cell.titleStackLbl.text = "\(notif.radius!) mile radius from \(notif.city!)"
                cell.dateLbl.text = notif.date?.replacingOccurrences(of: "-", with: "/")
            }
            
            cell.notifImage.tag = indexPath.row
            let tap = UITapGestureRecognizer(target: self, action: #selector(openImageController(_:)))
            cell.notifImage.addGestureRecognizer(tap)
            
            
             return cell
            
            
        }
        else {

            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationCell
            cell.deleteBtn.addTarget(self, action: #selector(deleteNotification(sender:)), for: .touchUpInside)
            
            cell.deleteBtn.tag = indexPath.row + 100000
            
            let notif = storeNotifications[indexPath.row]
            
            
            let options = ImageLoadingOptions(
                failureImage: #imageLiteral(resourceName: "image-not-foundBIG")
                //Big: #imageLiteral(resourceName: "image-not-foundBIG")
            )
            
            
            
            if notif.product__name != nil {
                //Case that it is SKU notif
                if notif.store__chainName != nil {
                    cell.productName.text = notif.product__name!
                    Nuke.loadImage(with: URL(string: notif.product__imageLink!)!, options: options, into: cell.notifImage)
                    cell.titleStackLbl.text = notif.store__chainName!
                    cell.addressLbl.text = notif.store__address!
                    cell.dateLbl.text = notif.date?.replacingOccurrences(of: "-", with: "/")
                } else {
                    cell.productName.text = notif.product__name!
                    Nuke.loadImage(with: URL(string: notif.product__imageLink!)!, options: options, into: cell.notifImage)
                    cell.titleStackLbl.text = "\(notif.radius!) mile radius from \(notif.city!)"
                    cell.dateLbl.text = notif.date?.replacingOccurrences(of: "-", with: "/")
                }
                
            }
            else {
                cell.productName.text = notif.supplyName!
                let supply = notif.supplyName!
                switch supply{
                case "Face Masks":
                    cell.notifImage.image = #imageLiteral(resourceName: "mask")
                case "Gloves":
                    cell.notifImage.image = #imageLiteral(resourceName: "glove")
                case "Hand Sanitizer":
                    cell.notifImage.image = #imageLiteral(resourceName: "sanit")
                case "Soap":
                    cell.notifImage.image = #imageLiteral(resourceName: "soap")
                case "Toilet Paper":
                    cell.notifImage.image = #imageLiteral(resourceName: "TP")
                case "Disinfectant Wipes":
                    cell.notifImage.image = #imageLiteral(resourceName: "wipe")
                case "Disinfectant Spray":
                    cell.notifImage.image = #imageLiteral(resourceName: "spray")
                default:
                    cell.notifImage.image = #imageLiteral(resourceName: "image-not-found")
                    
                    }
                
                cell.titleStackLbl.text = "\(notif.radius!) mile radius from \(notif.city!)"
                cell.dateLbl.text = notif.date?.replacingOccurrences(of: "-", with: "/")
            }
            
            
            cell.notifImage.tag = indexPath.row
            let tap = UITapGestureRecognizer(target: self, action: #selector(openImageController(_:)))
            cell.notifImage.addGestureRecognizer(tap)
            return cell
        }
        
        

        
    
     
    }
    
    
    
    
}
