//
//  StoreInformation.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 3/31/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//
import UIKit
import MapKit
import Nuke
import GoogleMobileAds
import EzPopup

class StoreController: UIViewController, UIScrollViewDelegate, UIGestureRecognizerDelegate{

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor =  Color.shared.theme

        
        view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        
        initializeConstants()
        getProductData()
        
        
        title = currStore.store__chainName
        
      
    
        
        
        
    
        
   
        
        //NotificationCenter.default.addObserver(self, selector: #selector(configureViewComponents), name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        print("===ORIENTATION CHANGE")
        

        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
 
        self.navigationController?.navigationBar.isHidden = false
        
        if !firstVC {
            let mapBtn = UIButton(type: .system)
            mapBtn.setImage(#imageLiteral(resourceName: "map-1").withRenderingMode(.alwaysTemplate), for: .normal)
            
            if scheme == 0 {
                mapBtn.tintColor = .black
            } else if scheme == 1 {
                mapBtn.tintColor = .white
            } else {
                mapBtn.tintColor = .black
            }
            
            
            mapBtn.sizeToFit()
            mapBtn.contentMode = .scaleAspectFit
            mapBtn.addTarget(self, action: #selector(goBackHome), for: .touchUpInside)
            
            let rightBarButtonItem = UIBarButtonItem(customView: mapBtn)
            mapBtn.widthAnchor.constraint(equalToConstant: 30).isActive = true
            mapBtn.heightAnchor.constraint(equalToConstant: 30).isActive = true
            
      

            self.navigationItem.rightBarButtonItem = rightBarButtonItem
            
         
        }
        

        
      

    }
    
  
    func initializeConstants() {
        if let w = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            heightCV = w.frame.height/3
            y = w.frame.height - heightCV
            window = w
        }
        
        
        
    }
    
    
    // MARK: - Views
    let Dscroll = DScrollView()
    let scrollContainer = DScrollViewContainer(axis: .vertical, spacing: 8)
    

    
    
    
    

 

    let storeImageView: UIImageView = {
       let view = UIImageView()
       
        view.backgroundColor = .clear
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.6
        //view.layer.shadowPath = UIBezierPath(rect: view.bounds).cgPath
        view.layer.shadowOffset = .zero
        //view.layer.shadowPath  = CGPath(
        view.widthAnchor.constraint(equalToConstant: view.frame.width).isActive = true
        return view
    }()
    
    let storeImageView2: UIImageView = {
       let view = UIImageView()
        view.image = #imageLiteral(resourceName: "tst")
        view.backgroundColor = .clear
        return view
    }()
    
    let shadow: UIView = {
        let view = UIView()
        view.backgroundColor = .black //Color.shared.theme
        view.layer.cornerRadius = 25
        view.alpha = 0.2
        return view
    }()
    
    

    let chainNameLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        lbl.text = ""
        lbl.textColor = .black //Dark mode
        lbl.font = UIFont(name: "HelveticaNeue", size: 25)
        lbl.textAlignment = .center
        lbl.sizeToFit()
        return lbl
    }()
    
    let addressLbl: CopyableLabel = {
        let lbl = CopyableLabel()
        lbl.text = ""
        lbl.numberOfLines = 2 //0
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textColor = Color.shared.blue
        lbl.font = UIFont(name: "HelveticaNeue", size: 20)
        lbl.textAlignment = .center
        lbl.isUserInteractionEnabled = true
        lbl.sizeToFit()
        return lbl
    }()
    
    let distanceLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.numberOfLines = 0
        lbl.textColor = .gray
        lbl.font = UIFont(name: "HelveticaNeue", size: 20)
        lbl.textAlignment = .center
        lbl.sizeToFit()
        
        return lbl
    }()
    

    
    let ratingView: UIStackView = {
        let Hstack = UIStackView()
        Hstack.axis =  .horizontal
        Hstack.backgroundColor = .black
        Hstack.alpha = 1
        Hstack.alignment = .center
        Hstack.sizeToFit()
        return Hstack
    }()
    
    let ratingLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.numberOfLines = 0
        lbl.textColor = .gray
        lbl.font = UIFont(name: "HelveticaNeue", size: 20)
        lbl.textAlignment = .left
        lbl.sizeToFit()
        return lbl
    }()
    
    
    
     let Hscroll: UIScrollView = {
         let view = UIScrollView()
         view.alwaysBounceHorizontal = true
         view.isScrollEnabled = true
         view.isPagingEnabled = true
         view.translatesAutoresizingMaskIntoConstraints = false
         view.backgroundColor = .clear
        view.showsHorizontalScrollIndicator = false
         
         //view.frame = CGRect(x: 0,y: 0,width: view.frame.width, height: 150)
         return view
     }()
     
     let whiteRect: UIView = {
         let stack = UIView()
         stack.backgroundColor = .white //Dark mode
         stack.layer.cornerRadius = 20

         return stack
     }()
     
     let info1: UIView = {
         let stack = UIView()
         stack.backgroundColor = .clear
         //stack.layer.cornerRadius = 20
         return stack
     }()
     
     let info2: UIView = {
         let stack = UIView()
         stack.backgroundColor = .clear
         //stack.layer.cornerRadius = 20
         return stack
     }()
     
    
    let openStatusStack: UIStackView = {
        let Hstack = UIStackView()
        Hstack.axis =  .horizontal
        Hstack.backgroundColor = .black
        Hstack.alpha = 1
        Hstack.alignment = .center
        Hstack.spacing = 0
        Hstack.sizeToFit()
        return Hstack
    }()
    
    let openStatusLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.numberOfLines = 0
        lbl.font = UIFont(name: "HelveticaNeue", size: 20)
        lbl.textAlignment = .center
        lbl.sizeToFit()
    
        return lbl
    }()
    
    let hourStatusLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.numberOfLines = 0
        lbl.textColor = .black //Dark mode
        lbl.font = UIFont(name: "HelveticaNeue", size: 20)
        lbl.textAlignment = .left
        lbl.sizeToFit()
        return lbl
    }()
    
    
    
    let weeklyHoursStack: UIStackView = {
        let Hstack = UIStackView()
        Hstack.axis =  .horizontal
        Hstack.backgroundColor = .black
        Hstack.alpha = 1
        Hstack.alignment = .center
        Hstack.sizeToFit()
        return Hstack
    }()
    
    let weeklyHoursLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Weekly hours"
        lbl.numberOfLines = 0
        lbl.textColor = Color.shared.blue
        lbl.font = UIFont(name: "HelveticaNeue", size: 20)
        lbl.textAlignment = .center
        lbl.sizeToFit()
        return lbl
    }()
    
    
    
    
    
     
     
     let pageControl: UIPageControl = {
         let control = UIPageControl()
         control.numberOfPages = 2
        control.isUserInteractionEnabled = false
        //control.backgroundColor = .gray
        control.pageIndicatorTintColor = Color.shared.theme
        control.currentPageIndicatorTintColor = Color.shared.blue
         return control
     }()
    
    let info3: UIView = {
        let stack = UIView()
        stack.backgroundColor = .clear
        stack.layer.cornerRadius = 20
        stack.isHidden = true

        return stack
    }()
    
    let weekdayStack: UIStackView = {
        let Hstack = UIStackView()
        Hstack.axis =  .horizontal
        Hstack.backgroundColor = .black
        Hstack.alpha = 1
        Hstack.alignment = .center
        Hstack.spacing = -10
        //Hstack.sizeToFit()
        return Hstack
    }()
    
    let weekdayLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Monday:\nTuesday:\nWednesday:\nThursday:\nFriday:\nSaturday:\nSunday\n"
        lbl.numberOfLines = 0
        lbl.textColor = .gray
        lbl.font = UIFont(name: "HelveticaNeue", size: 15)
        lbl.textAlignment = .left
        //lbl.sizeToFit()
        return lbl
    }()
    
    let weekdayHoursLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = ""
        lbl.numberOfLines = 0
        lbl.textColor = .gray
        lbl.font = UIFont(name: "HelveticaNeue", size: 15)
        lbl.textAlignment = .right
        //lbl.sizeToFit()
        return lbl
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.tintColor = .black
        spinner.startAnimating()
        spinner.isHidden = true
        return spinner
    }()
    
    let tableView: UITableView = {
        let view = UITableView()
        view.rowHeight = 100
        view.isScrollEnabled = false
        return view
    }()
   
    
    let blackOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    let whiteOverlay: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.alpha = 0
        return view
    }()
    
    
    let nearbyStoresView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.black.withAlphaComponent(1)
        view.layer.cornerRadius = 20
        view.isScrollEnabled = false
        return view
    }()
    
    
    let nearbyStoresCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = UIColor.black.withAlphaComponent(1)
        view.isScrollEnabled = false
        view.isUserInteractionEnabled = true
        
        return view
    }()
    
    
    
    let topStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.clipsToBounds = false
        stack.sizeToFit()
        stack.spacing = 30
        return stack
    }()
    
    let tabView: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "tab")
        view.frame = CGRect(x: 0,y: 0, width: 0, height: 10)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let nearbyStoresLbl: UILabel = {
        let lbl = UILabel()
        lbl.sizeToFit()
        lbl.text = "Nearby Stores in Stock"
        lbl.font = UIFont(name: "HelveticaNeue", size: 25)
        lbl.numberOfLines = 1
        lbl.textColor = .black
        return lbl
    }()
    
    let Vscroll: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        view.isScrollEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.showsVerticalScrollIndicator = true
        return view
    }()
    
    let header: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "tab")
        view.frame = CGRect(x: 0,y: 0, width: view.frame.width, height: 10)
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    let xBtn: UIButton = {
          let button = UIButton()
        var img = #imageLiteral(resourceName: "x-emoji-png")
          button.setImage( img, for: .normal)
          
        button.addTarget(self, action: #selector(handleCloseNearbyStores), for: .touchUpInside)
          button.translatesAutoresizingMaskIntoConstraints = false
          return button
          
      }()
    
    let noNearbyStoresLbl: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.rgb(red: 209, green: 21, blue: 0)
        lbl.textColor = .white
        lbl.text = "No stores nearby currently have this product in stock."
        lbl.font = UIFont.italicSystemFont(ofSize: 15.0)
        //lbl.sizeToFit()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        //lbl.adjustsFontSizeToFitWidth  = true
        lbl.layer.cornerRadius = 10
        return lbl
    }()
    
    let notificationAdded: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = .systemGreen
        lbl.textColor = .white
        lbl.text = "Notification added."
        lbl.font = UIFont.italicSystemFont(ofSize: 15.0)
        //lbl.sizeToFit()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        //lbl.adjustsFontSizeToFitWidth  = true
        lbl.layer.cornerRadius = 10
        return lbl
    }()
    
    let notificationAlreadyAdded: UILabel = {
        let lbl = UILabel()
        lbl.backgroundColor = UIColor.rgb(red: 255, green: 153, blue: 0)
        lbl.textColor = .white
        lbl.text = "Notification has already been added."
        lbl.font = UIFont.italicSystemFont(ofSize: 15.0)
        //lbl.sizeToFit()
        lbl.textAlignment = .center
        lbl.numberOfLines = 0
        //lbl.adjustsFontSizeToFitWidth  = true
        lbl.layer.cornerRadius = 10
        return lbl
    }()
     
     
     // MARK: - Variables

        var currStore = store()
        var distanceAway: String = ""
        var openStatus: String = ""
    var statusColor: UIColor = UIColor()
    var stillLoading = false
    var supply: String = ""
    var products = [product]()
    var height = -1
    var stackWidth = CGFloat(-1)
    var hasHalfStar = false
    var fullStarsRemaining = -1
    var initialCenterY = CGFloat()
    
    var window = UIWindow()
    var heightCV = CGFloat()
    var y = CGFloat()
    var nearbyStores = [nearbyStore]()
    var nearbyStoresInfo = [(openStatus: String, openStatusColor: UIColor, distance: Float)]()
    var firstVC = true
    var currSKU = -1
    var messageInProgress = false
    var secondMessage = false
    var city = ""
    let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
    var isDarkStatusBar = false
  
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return isDarkStatusBar ? .default : .lightContent
    }
    
    
    var adIndexes = [Int]()

     
     
     
     
     
     // MARK: - Selectors
       @objc func showPopup() {
    
           let GC = GoldPopup()
            GC.isPopup = true
            GC.popupWidth = self.view.frame.width*(4/5)
            GC.popupHeight = self.view.frame.height*(4/5)
            GC.fromStoreController = true

            // Init popup view controller with content is your content view controller
            let popupVC = PopupViewController(contentController: GC, popupWidth: GC.popupWidth, popupHeight: GC.popupHeight)
            
            popupVC.backgroundAlpha = 0.4
            popupVC.backgroundColor = Color.shared.darkGold
            popupVC.canTapOutsideToDismiss = true
            popupVC.cornerRadius = 10
            popupVC.shadowEnabled = true
            
            // show it by call present(_ , animated:) method from a current UIViewController
            self.present(popupVC, animated: true)
        
       }
    
    
    
    @objc func openImageController(_ sender: UITapGestureRecognizer) {
        let view = sender.view as! UIImageView
        print("+++ Open image #\(view.tag)")
        let IC = ImageController()
        IC.img.image = view.image
        navigationController?.pushViewController(IC, animated: true)
        
        
    }
    
    
    @objc func goBackHome() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.popToRootViewController(animated: true)
        
        
    }
    
    
    func addSKURegionNotification(sender: UIButton) {
        
        let date = Date()
        let calendar = Calendar.current
        let now = "\(calendar.component(.month, from: date))-\(calendar.component(.day, from: date))-\(calendar.component(.year, from: date)%1000)"
        
        DispatchQueue.global(qos: .userInitiated).async {
            Notifications.shared.initialize(withSKU: self.currSKU, withStoreID: self.currStore.store__id)
            Notifications.shared.date = now
            Notifications.shared.addSKURegionNotification  { (result) in
                switch result{
                case .success(let message):
                    print("=====+ \(message)")
                    if message.first == "#" {
                        //Notif already exists
                        DispatchQueue.main.async {
                  
                                let lbl = UILabel()
                                lbl.backgroundColor = UIColor.rgb(red: 255, green: 153, blue: 0)
                                lbl.textColor = .white
                                lbl.text = "Notification has already been added."
                                lbl.font = UIFont.italicSystemFont(ofSize: 15.0)
                                //lbl.sizeToFit()
                                lbl.textAlignment = .center
                                lbl.numberOfLines = 0
                                //lbl.adjustsFontSizeToFitWidth  = true
                                lbl.layer.cornerRadius = 10
 
                       
                            self.showMessage(label: lbl, sender: sender)
                        }
                    }
                    else {
                        //Added notif
                        DispatchQueue.main.async {
                            let lbl = UILabel()
                               lbl.backgroundColor = .systemGreen
                               lbl.textColor = .white
                               lbl.text = "Notification added."
                               lbl.font = UIFont.italicSystemFont(ofSize: 15.0)
                               //lbl.sizeToFit()
                               lbl.textAlignment = .center
                               lbl.numberOfLines = 0
                               //lbl.adjustsFontSizeToFitWidth  = true
                               lbl.layer.cornerRadius = 10
                            self.showMessage(label: lbl, sender: sender)
                        }
                    }
                case .failure(let error):
                    print("DEBUG: Failed with error \(error)")
                    return
                }
                
            }

            
        }
        
        
        
    }
    
    
    func addSKUStoreNotification(sender: UIButton) {
        
        let date = Date()
        let calendar = Calendar.current
        let now = "\(calendar.component(.month, from: date))-\(calendar.component(.day, from: date))-\(calendar.component(.year, from: date)%1000)"
        
        DispatchQueue.global(qos: .userInitiated).async {
            Notifications.shared.initialize(withSKU: self.currSKU, withStoreID: self.currStore.store__id)
            Notifications.shared.date = now
            Notifications.shared.addSKUStoreNotification  { (result) in
                switch result{
                case .success(let message):
                    print("=====+ \(message)")
                    if message.first == "#" {
                        //Notif already exists
                        DispatchQueue.main.async {
                            let lbl = UILabel()
                            lbl.backgroundColor = UIColor.rgb(red: 255, green: 153, blue: 0)
                            lbl.textColor = .white
                            lbl.text = "Notification has already been added."
                            lbl.font = UIFont.italicSystemFont(ofSize: 15.0)
                            //lbl.sizeToFit()
                            lbl.textAlignment = .center
                            lbl.numberOfLines = 0
                            //lbl.adjustsFontSizeToFitWidth  = true
                            lbl.layer.cornerRadius = 10
                       
                            self.showMessage(label: lbl, sender: sender)
                        }
                    }
                    else {
                        //Added notif
                        DispatchQueue.main.async {
                            
                            let lbl = UILabel()
                            lbl.backgroundColor = .systemGreen
                            lbl.textColor = .white
                            lbl.text = "Notification added."
                            lbl.font = UIFont.italicSystemFont(ofSize: 15.0)
                            //lbl.sizeToFit()
                            lbl.textAlignment = .center
                            lbl.numberOfLines = 0
                            //lbl.adjustsFontSizeToFitWidth  = true
                            lbl.layer.cornerRadius = 10

                            self.showMessage(label: lbl, sender: sender)
                        }
                    }
                case .failure(let error):
                    print("DEBUG: Failed with error \(error)")
                    
                }
                
            }
        }
        
            
        
    }
    
    
    func handleAddNotification(situation: Int, sender: UIButton) {
        let center = UNUserNotificationCenter.current()
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                //Not determined
                print("=====+PROMPT USER")

                let center = UNUserNotificationCenter.current()
                center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                    if let error = error {
                        // Handle the error here.
                        print("DEBUG: Failed with error \(error)")
                    }
                    self.handleAddNotification(situation: situation, sender: sender)
                    return
                    
                    }
            }
            
            else if settings.authorizationStatus == .denied {
                //Denied
                DispatchQueue.main.async {
                    let alert = UIAlertController(title: "Notifications Disabled", message: "To enable, go to Settings -> Notifications -> Find My Supply -> Allow Notifications", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }

                
            }
            else {
                //Accepted
                if situation == 1 {
                    self.addSKUStoreNotification(sender: sender)
                }
                else {
                    self.addSKURegionNotification(sender: sender)
                }
                
                    
   
            

                 
                
            }
            
        }
        



  
        
        
        
       
    }
    
    
    @objc func addNotification(sender: AnyObject) {
        
        let btn = sender as! UIButton
        //self.navigationController?.pushViewController(TESTViewController(), animated: true)
        print("===+ Sender: \(sender.tag)")
        currSKU = products[sender.tag].SKU
        
        
        Stores.shared.storeID = self.currStore.store__id
        Stores.shared.SKU = self.products[sender.tag].SKU
        
        DispatchQueue.global(qos: .userInitiated).async {
            
            Stores.shared.fetchNearbyStores { (result) in
                switch result {
                case .success(let stores):
                    print("===+\(self.nearbyStores)")
                    DispatchQueue.main.async {
                        var actionSheet = UIAlertController()
                        if stores.count > 0 {
                            let nonPlural = "store"
                            actionSheet = UIAlertController(title: "Add Item Notification", message: "Item is in stock in \(stores.count) nearby \((stores.count == 1) ? nonPlural: nonPlural+"s"). Do you wish to view nearby stores or get a restock notification for this store?", preferredStyle: .actionSheet)

                            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                            let nearbyStores = UIAlertAction(title: "View nearby stores", style: .default) { action in
                                self.showNearbyStores(sender: btn)
                            }
                            let addNotification = UIAlertAction(title: "Add notification", style: .default) { action in
                                if UserDefaults.standard.bool(forKey: "isGold") {
                                    self.handleAddNotification(situation: 1, sender: btn)
                                } else {
                                     
                                    self.showPopup()
                                }
                      
                            }

                            actionSheet.addAction(nearbyStores)
                            actionSheet.addAction(addNotification)
                            actionSheet.addAction(cancel)
                        
                        } else {
                            actionSheet = UIAlertController(title: "Add Item Notification", message: "Get notified when this item is restocked in your area or in this specific store?", preferredStyle: .actionSheet)
                            
                            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
                            let addRegionNotification = UIAlertAction(title: "Add area notification ", style: .default) { action in
                                if UserDefaults.standard.bool(forKey: "isGold") {
                                    self.handleAddNotification(situation: 2, sender: btn)
                                } else {
                                     
                                    self.showPopup()
                                }
                            

                            }
                            let addStoreNotification = UIAlertAction(title: "Add store notification", style: .default) { action in
                                if UserDefaults.standard.bool(forKey: "isGold") {
                                    self.handleAddNotification(situation: 1, sender: btn)
                                } else {
                                     
                                    self.showPopup()
                                }

                            }

                            actionSheet.addAction(addRegionNotification)
                            actionSheet.addAction(addStoreNotification)
                            actionSheet.addAction(cancel)
                            self.nearbyStores = stores
                        }
                        
//                        if let popoverController = actionSheet.popoverPresentationController {
//                                       popoverController.sourceView = self.view //to set the source of your alert
//                                       popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0) // you can set this as per your requirement.
//                                       //popoverController.permittedArrowDirections = [] //to hide the arrow of any particular direction
//                                   }
                        

                        if let presenter = actionSheet.popoverPresentationController {
                            let s = sender as! UIView
                            presenter.sourceView = s
                            presenter.sourceRect = s.bounds
                        }
                   
                        self.present(actionSheet, animated: true, completion: nil)
               

                    }
                    
                case .failure(let error):
                    print("DEBUG: Failed with error \(error)")
                }
            }
            
            
        }
        

    }
     
       @objc func changeWeeklyHoursColor(_ sender: UITapGestureRecognizer) {
           print("=====LONG HOLD")
           if sender.state == .began {
                self.becomeFirstResponder()
                   self.weeklyHoursStack.alpha = 0.5
              
               
           }
           if sender.state == .ended {
               UIView.animate(withDuration: 0.2, animations: {
                   self.weeklyHoursStack.alpha = 1
               } )
           }
           
       }
       
       
       @objc func showWeeklyHours(_ sender: UITapGestureRecognizer) {
           print("=====weekly hourssssss")
           if sender.state == .began {
               print("=====.began")
                self.becomeFirstResponder()
               UIView.animate(withDuration: 0.2, animations: {
                   self.weeklyHoursStack.alpha = 1
               } )
               
           }
           else {
               print("=====.other")
               self.weeklyHoursStack.alpha = 0.5
          
               UIView.animate(withDuration: 0.5, animations: {
                   self.weeklyHoursStack.alpha = 1
               } )
           }
           
           info3.isHidden = false
           Hscroll.contentSize = CGSize(width: view.frame.width*3, height: 150)
           UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
               self.Hscroll.contentOffset.x = self.view.frame.width*2
            self.pageControl.numberOfPages = 3
            self.pageControl.currentPage = 3
             
           }, completion: { _ in

           })
        
           
       }
     
       
       func handleRedirect() {
           //let redirection = "http://maps.apple.com/?daddr=4255,Campus+Dr,A116,Irvine,CA"
           //let url = URL(string: redirection)
           
           
           let mapApp = UserDefaults.standard.integer(forKey: "mapApp")
           switch mapApp {
           case 0:
               appleRedirect()
           case 1:
               wazeRedirect()
           case 2:
               googleRedirect()
           default:
               appleRedirect()
           }
           

           
           
       }
       
       
       func wazeRedirect() {
           //let redirection = "https://www.waze.com/ul?ll=40.75889500,-73.98513100&navigate=yes"
           let redirection = "waze://?ll=\(currStore.store__latitude),\(currStore.store__longitude)&navigate=yes"
           let url = URL(string: redirection)
           UIApplication.shared.open(url!, options: [:], completionHandler: nil)
       }
       
       func googleRedirect() {
           //let redirection = "https://www.google.com/maps/dir/?api=1&destination=QVB&destination_place_id=ChIJISz8NjyuEmsRFTQ9Iw7Ear8&travelmode=driving"
           let redirection = "https://www.google.com/maps/dir/?api=1&destination=\(currStore.store__chainName)&destination_place_id=\(currStore.store__googlePlaceID)&travelmode=driving"
           let url = URL(string: redirection)
           UIApplication.shared.open(url!, options: [:], completionHandler: nil)
       }
       
       func appleRedirect() {
           let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: currStore.store__latitude, longitude: currStore.store__longitude))
           let mapItem = MKMapItem(placemark: placemark)
           mapItem.name = currStore.store__chainName
           mapItem.openInMaps(launchOptions: nil)
       }
       
    
    
    @objc func handleCloseNearbyStores() {
        print("====+HANDLE CLOSE")
        closeNearbyStores(UITapGestureRecognizer())
    }
    
    @objc func closeNearbyStores(_ sender: UITapGestureRecognizer) {
        print("====+CLOSE")
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.blackOverlay.alpha = 0
            self.tabView.alpha = 0
            
            if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
                self.nearbyStoresView.frame = CGRect(x: 0, y: window.frame.height, width: self.nearbyStoresView.frame.width, height: self.nearbyStoresView.frame.height)
            }
            
        }, completion: { _ in
            self.blackOverlay.removeFromSuperview()
            self.nearbyStoresView.removeFromSuperview()
            self.header.removeFromSuperview()
            self.xBtn.removeFromSuperview()
        })

        
   

        
    }
    
    
    
    @objc func fullScreenDrag(gestureRecognizer: UIPanGestureRecognizer) {
        let diff = view.center.y - nearbyStoresView.center.y
        let absDiff = abs(diff)
        let minBound = view.frame.height/4
        if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
            let translation = gestureRecognizer.translation(in: self.view)
            if diff <= 0  {
                blackOverlay.alpha = 1 - ((absDiff/minBound)*1)
                
                
                if scheme == 0{
                    nearbyStoresView.backgroundColor = UIColor.white.withAlphaComponent(1 - ((absDiff/minBound)*1))
                }
                else if scheme == 1 {
                    nearbyStoresView.backgroundColor = UIColor.darkGray.withAlphaComponent(1 - ((absDiff/minBound)*1)) //Dark mode
                } else {
                    nearbyStoresView.backgroundColor = UIColor.white.withAlphaComponent(1 - ((absDiff/minBound)*1))
                }
                
                Vscroll.alpha = 1 - ((absDiff/minBound)*1)
                xBtn.alpha = 1 - ((absDiff/minBound)*1)
                tabView.alpha = 1
            }
            nearbyStoresView.center = CGPoint(x: nearbyStoresView.center.x, y: nearbyStoresView.center.y + translation.y)
            //header.center  = CGPoint(x: nearbyStoresView.center.x, y: nearbyStoresView.center.y + translation.y)
            
        }
        else if (gestureRecognizer.state == UIGestureRecognizer.State.ended) || (gestureRecognizer.state == UIGestureRecognizer.State.cancelled) {
            if (absDiff) >= (minBound)  {
                     closeNearbyStores(UITapGestureRecognizer())
            }
            else  {
                UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            
                    self.nearbyStoresView.frame = CGRect(x: 0, y: 0, width: self.nearbyStoresView.frame.width, height: self.nearbyStoresView.frame.height)
                    if self.scheme == 0{
                       self.nearbyStoresView.backgroundColor = UIColor.white.withAlphaComponent(1)   //Dark mode
                    }
                    else if self.scheme == 1 {
                        self.nearbyStoresView.backgroundColor = UIColor.darkGray.withAlphaComponent(1)   //Dark mode //Dark mode
                    } else {
                        self.nearbyStoresView.backgroundColor = UIColor.white.withAlphaComponent(1)   //Dark mode
                    }
                    
                    self.xBtn.alpha = 1
                    self.Vscroll.alpha = 1
                    self.blackOverlay.alpha = 1
                   
                }, completion: nil)
            }
            
        }
        
        
        
        gestureRecognizer.setTranslation(CGPoint(x: 0,y: 0), in: self.view)
        
        
    }
    
    
    
    
    @objc func wasDragged(gestureRecognizer: UIPanGestureRecognizer) {
            let diff = initialCenterY - nearbyStoresView.center.y
            let absDiff = abs(diff)
            let minBound = (window.frame.height/3)/3
            if gestureRecognizer.state == UIGestureRecognizer.State.began || gestureRecognizer.state == UIGestureRecognizer.State.changed {
                let translation = gestureRecognizer.translation(in: self.view)
                print("======CenterY: \(nearbyStoresView.center.y)")
                print("======TranslationY: \(translation.y)\n\n")
                
                    if diff >= 0 {
                        //Case that user is move CV up
                        blackOverlay.alpha = 0.6 + ((absDiff/minBound)*0.6)
                    }
                    else if diff < 0 {
                        //Case that user is moving CV down
                        
                    
                      
                        print("=====Diff: \(diff)")
                        print("=====Alpha: \(1 - ((diff)/(window.frame.height - window.frame.height/3)))")
                        blackOverlay.alpha = 0.6 - ((absDiff/minBound)*0.6)
                        
                        if self.scheme == 0{
                           nearbyStoresView.backgroundColor = UIColor.white.withAlphaComponent(1 - ((absDiff/minBound)*1))  //Dark mode
                        }
                        else if self.scheme == 1 {
                            nearbyStoresView.backgroundColor = UIColor.darkGray.withAlphaComponent(1 - ((absDiff/minBound)*1))  //Dark mode
                        } else {
                            nearbyStoresView.backgroundColor = UIColor.white.withAlphaComponent(1 - ((absDiff/minBound)*1))  //Dark mode
                        }
                        
                        xBtn.alpha = 1 - ((absDiff/minBound)*1)
                        Vscroll.alpha = 1 - ((absDiff/minBound)*1)
                        tabView.alpha = 1
                        
                        
           
                        
                    }

                    nearbyStoresView.center = CGPoint(x: nearbyStoresView.center.x, y: nearbyStoresView.center.y + translation.y)
                
            }
            else if (gestureRecognizer.state == UIGestureRecognizer.State.ended) || (gestureRecognizer.state == UIGestureRecognizer.State.cancelled) {
                print("======Gesture ENDED")
                print("======Height of Window: \(window.frame.height)")
                print("======Height of View: \(window.frame.height/3)")
                print("======Minimum Bounds: \((window.frame.height/3)/3)")
                if (diff) >= (minBound)    {
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                        self.nearbyStoresView.frame = CGRect(x: 0, y: 0, width: self.nearbyStoresView.frame.width, height: self.nearbyStoresView.frame.height)
                       
                    
                

                    }, completion: { _ in
                            self.topStack.removeGestureRecognizer(gestureRecognizer)
                        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.fullScreenDrag))
                        self.tabView.addGestureRecognizer(gesture)
                        self.blackOverlay.alpha = 1
                        
                        
                        self.configureFullScreenNearbyStores()
                    })
                }
                else if (diff) < -(minBound)  {
                         closeNearbyStores(UITapGestureRecognizer())
                }
                else {
                    self.topStack.isUserInteractionEnabled = false
                    UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        if self.scheme == 0{
                           self.nearbyStoresView.backgroundColor = UIColor.white.withAlphaComponent(1)  //Dark mode
                        }
                        else if self.scheme == 1 {
                            self.nearbyStoresView.backgroundColor = UIColor.darkGray.withAlphaComponent(1)  //Dark mode
                        } else {
                            self.nearbyStoresView.backgroundColor = UIColor.white.withAlphaComponent(1)  //Dark mode
                        }
                        
                        self.xBtn.alpha = 1
                        self.blackOverlay.alpha = 0.6
                        self.Vscroll.alpha = 1
                        self.nearbyStoresView.frame = CGRect(x: 0, y: self.y, width: self.nearbyStoresView.frame.width, height: self.nearbyStoresView.frame.height)
                    }, completion: { _ in
                
                        self.topStack.isUserInteractionEnabled = true
                    })
                    
                }
            }
        
        gestureRecognizer.setTranslation(CGPoint(x: 0,y: 0), in: self.view)
    }
    
    
    

    
    func showMessage(label: UILabel, sender: UIButton) {
        

        
        sender.isEnabled = false
        self.view.addSubview(label)
        label.alpha = 1
        
      //     self.noNearbyStoresLbl.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        label.frame = CGRect(x: 0 ,y: self.window.frame.height, width: (self.window.frame.width/4)*3, height: 50)
        label.center.x = view.center.x
     
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                label.frame = CGRect(x: 0, y: self.view.frame.height - 100, width: (self.window.frame.width/4)*3, height: 50)
                label.center.x = self.view.center.x
            }, completion: { _ in
                    UIView.animate(withDuration: 2, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        label.alpha = 0
                    }, completion: { _ in
                        sender.isEnabled = true
                        label.removeFromSuperview()
                        label.alpha = 1

                    })
            })
        
    }
    

    
    @objc func showNearbyStores(sender: UIButton) {
        print("=====SHOW NEARBY stores: \(sender.tag)")
        //navigationController?.pushViewController(TESTViewController(), animated: true)
        
        
        Stores.shared.storeID = self.currStore.store__id
        Stores.shared.SKU = self.products[sender.tag].SKU
    
        DispatchQueue.global(qos: .userInitiated).async {
            
            Stores.shared.fetchNearbyStores { (result) in
                switch result {
                case .success(let stores):

                    
                    self.nearbyStores = stores
                    print("===+\(self.nearbyStores)")
                    DispatchQueue.main.async {
                        if stores.count == 0 {
                            
                            let lbl = UILabel()
                                lbl.backgroundColor = UIColor.rgb(red: 209, green: 21, blue: 0)
                                lbl.textColor = .white
                                lbl.text = "No stores nearby currently have this product in stock."
                                lbl.font = UIFont.italicSystemFont(ofSize: 15.0)
                                //lbl.sizeToFit()
                                lbl.textAlignment = .center
                                lbl.numberOfLines = 0
                                //lbl.adjustsFontSizeToFitWidth  = true
                                lbl.layer.cornerRadius = 10
                          
                            self.showMessage(label: lbl, sender: sender)
                            return
                        }
                        
                        let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeNearbyStores))
                        self.blackOverlay.addGestureRecognizer(tap)
                            
                            
                        self.window.addSubview(self.blackOverlay)
                        self.window.addSubview(self.nearbyStoresView)
                            
                        self.nearbyStoresView.frame = CGRect(x: 0 ,y: self.window.frame.height, width: self.window.frame.width, height: self.window.frame.height)
                          
                        self.configureNearbyStoresView()
                            
                        let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.wasDragged))
                        self.topStack.addGestureRecognizer(gesture)
                        
    
                        
                        self.topStack.isUserInteractionEnabled = false
                        
                        if self.scheme == 0{
                           self.nearbyStoresView.backgroundColor = UIColor.white.withAlphaComponent(1)  //Dark mode
                        }
                        else if self.scheme == 1 {
                            self.nearbyStoresView.backgroundColor = UIColor.darkGray.withAlphaComponent(1)  //Dark mode
                        } else {
                            self.nearbyStoresView.backgroundColor = UIColor.white.withAlphaComponent(1)  //Dark mode
                        }
         
                        self.xBtn.alpha = 1
                        self.Vscroll.alpha = 1
                        self.tabView.alpha = 1
                            gesture.delegate = self
                            
                        self.blackOverlay.frame = self.window.frame
                            
                            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                                self.blackOverlay.alpha = 0.6
                                self.nearbyStoresView.frame = CGRect(x: 0, y: self.y, width: self.nearbyStoresView.frame.width, height: self.nearbyStoresView.frame.height)
                            }, completion: { _ in
                                self.initialCenterY = self.nearbyStoresView.center.y
                                self.topStack.isUserInteractionEnabled = true
                            })
                    }
                    
                case .failure(let error):
                    print("DEBUG: Failed with error \(error)")
                }
            }
            
            
        }

        
        
        
        
    }
    
       @objc func addressTapped(_ sender: UITapGestureRecognizer) {
           print("=====ADRESS Tapped")
           handleRedirect()
       }
       
       
     
     
     // MARK: - Helper functions
    
    
    
    
    func configureFullScreenNearbyStores() {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.tabView.removeFromSuperview()
                
                let gesture = UIPanGestureRecognizer(target: self, action: #selector(self.fullScreenDrag))
            self.topStack.addGestureRecognizer(gesture)
            self.topStack.isUserInteractionEnabled = true
                
            self.nearbyStoresView.addSubview(self.header)
            self.header.anchor(top: nil, left: self.nearbyStoresView.leftAnchor, bottom: nil, right: self.nearbyStoresView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: self.view.frame.width, height: 10)
            self.header.topAnchor.constraint(equalTo: self.nearbyStoresView.topAnchor ,constant: 50).isActive = true
                
            self.nearbyStoresView.addSubview(self.xBtn)
            self.xBtn.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
            self.xBtn.topAnchor.constraint(equalTo: self.nearbyStoresView.topAnchor ,constant: 45).isActive = true
            self.xBtn.leftAnchor.constraint(equalTo: self.nearbyStoresView.leftAnchor ,constant: 10).isActive = true
                
                let tap = UITapGestureRecognizer(target: self, action: #selector(self.closeNearbyStores))
            self.xBtn.addGestureRecognizer(tap)
                
            self.nearbyStoresView.bringSubviewToFront(self.header)
            self.nearbyStoresView.bringSubviewToFront(self.xBtn)
                
            
            self.Vscroll.topAnchor.constraint(equalTo: self.header.bottomAnchor, constant: 10).isActive = true
        }, completion: nil)

    }
    
    
    
    func configureNearbyStoresView() {
        
        nearbyStoresView.addSubview(topStack)
        
        topStack.anchor(top: nearbyStoresView.topAnchor, left: nearbyStoresView.leftAnchor, bottom: nearbyStoresView.bottomAnchor, right: nearbyStoresView.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: view.frame.height)
        
        topStack.addArrangedSubview(tabView)
        tabView.anchor(top: topStack.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 100, height: 10)
        tabView.centerXAnchor.constraint(equalTo: nearbyStoresView.centerXAnchor).isActive = true
 
        
        topStack.addArrangedSubview(Vscroll)
        
        Vscroll.anchor(top: nil, left: nearbyStoresView.leftAnchor, bottom: nearbyStoresView.bottomAnchor, right: nearbyStoresView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 0)
        Vscroll.topAnchor.constraint(equalTo: tabView.bottomAnchor, constant: 10).isActive = true
        
        Vscroll.addSubview(nearbyStoresCollectionView)
        nearbyStoresCollectionView.anchor(top: Vscroll.topAnchor, left: nearbyStoresView.leftAnchor, bottom: nil, right: nearbyStoresView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: nearbyStoresView.frame.width, height: CGFloat(110 * (nearbyStores.count)))
        
        print("===+ Height: \(Vscroll.frame.height)")
        
        let width = view.frame.width
        Vscroll.contentSize = CGSize(width: width, height: CGFloat(110 * (nearbyStores.count)))
        
        
        //print("===+Header heihgt: \(topStack.center.y)")
        //nearbyStoresCollectionView.contentSize = CGSize(width: view.frame.width, height: 500*15)
        
        nearbyStoresCollectionView.delegate = self
        nearbyStoresCollectionView.dataSource = self
        
        //nearbyStoresCollectionView.contentInset = UIEdgeInsets(top: (view.frame.height/3)/10, left: 0, bottom: 0, right: 0)
        
        
        nearbyStoresCollectionView.register(NearbyStoreCell.self, forCellWithReuseIdentifier: "NearbyStoreCell")
        
        //nearbyStoresView.bringSubviewToFront(topStack)
        nearbyStoresView.bringSubviewToFront(nearbyStoresCollectionView)
        
        

    }
    
     
     func configureTest() {
         
         
         
    /*
         
         view.addSubview(whiteRect)
         whiteRect.anchor(top: self.topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 150)
        
        Hscroll.delegate = self
        
        view.addSubview(Hscroll)
        
        
        Hscroll.anchor(top: self.topLayoutGuide.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 150)
        
        Hscroll.addSubview(info1)
        info1.anchor(top: Hscroll.topAnchor, left: Hscroll.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 150)
        
        info1.addSubview(lbl1)
        lbl1.anchor(top: info1.topAnchor, left: info1.leftAnchor, bottom: nil, right: info1.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        
        
        
        Hscroll.addSubview(info2)
        info2.anchor(top: self.topLayoutGuide.bottomAnchor, left: info1.rightAnchor, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 150)
        
        info2.addSubview(lbl2)
        lbl2.anchor(top: info2.topAnchor, left: info2.leftAnchor, bottom: nil, right: info2.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 50, height: 50)
        
        
        
        Hscroll.contentSize = CGSize(width: view.frame.width*2, height: 150)
        
        
        
        view.addSubview(pageControl)
        pageControl.anchor(top: Hscroll.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: -20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10, height: 10)
        */
        
    }
    
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
         UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.pageControl.currentPage = Int(self.Hscroll.contentOffset.x/self.view.frame.size.width)
            if self.pageControl.currentPage != 2 && self.pageControl.numberOfPages == 3 {
            
           
                self.pageControl.numberOfPages = 2
           
           
                self.info3.isHidden = true
                self.Hscroll.contentSize = CGSize(width: self.view.frame.width*2, height: 150)
        }
             }, completion: nil)
    }
    
    

    @objc func configureViewComponents() {
       
     print("===Configuring views!")
        //configureTest()
        configureImageView()
        configureStackViews()
       // configureHorizontalScroll()
        //configureStoreInfo()
       configureTableView()
        //configureScrollView()
         configureDscroll()
        configureColorScheme()

        
        //view.addSubview(shadow)
       // shadow.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 42, paddingLeft: 5, paddingBottom: 00, paddingRight: 0, width: 75, height: 50)
        
        
    }
    
    func configureColorScheme() {
        
        let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
        
        if scheme == 0 {
            //STANDARD
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
           
            
            Dscroll.backgroundColor = .darkGray
            pageControl.pageIndicatorTintColor = .darkGray
            nearbyStoresCollectionView.backgroundColor = .darkGray
            Vscroll.backgroundColor = .darkGray
            
        }
        else if scheme == 1 {
            //DARK
            //UINavigationBar.appearance().barTintColor = .black
            //UINavigationBar.appearance().tintColor = .white
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = .black
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            StatusBarColor.shared.isDark = false
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })

            
            
            Dscroll.backgroundColor = .darkGray
            pageControl.pageIndicatorTintColor = .darkGray
            nearbyStoresCollectionView.backgroundColor = .black
            nearbyStoresView.backgroundColor = .black
            Vscroll.backgroundColor = .black
            
            whiteRect.backgroundColor = .black
            chainNameLbl.textColor = .white
            distanceLbl.textColor = .lightGray
            ratingLbl.textColor = .lightGray
            hourStatusLbl.textColor = .white
            weekdayHoursLbl.textColor = .lightGray
            weekdayLbl.textColor = .lightGray
            tableView.backgroundColor = .black
        }
        else {
            //LIGHT
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })

            
            
            Dscroll.backgroundColor = .lightGray
            pageControl.pageIndicatorTintColor = .lightGray
            nearbyStoresCollectionView.backgroundColor = .white
            nearbyStoresView.backgroundColor = .white
            Vscroll.backgroundColor = .white
            
            
        }
        
        
        
        
    }
    
    func configureStackViews() {
  
        
        Hscroll.delegate = self
        
        

      
        view.addSubview(whiteRect)
        whiteRect.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 150)
        
        
        whiteRect.addSubview(Hscroll)
        Hscroll.anchor(top: whiteRect.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 150)
        
        

        
        
        Hscroll.addSubview(info1)
        info1.anchor(top: Hscroll.topAnchor, left: Hscroll.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 150)
        
        
    
        info1.addSubview(chainNameLbl)
        chainNameLbl.anchor(top: info1.topAnchor,  left: info1.leftAnchor, bottom: nil, right: info1.rightAnchor, paddingTop: 10, paddingLeft: 000, paddingBottom: 0, paddingRight: 0, width: 00, height: 0)
        chainNameLbl.text = currStore.store__chainName

        info1.addSubview(addressLbl)
        addressLbl.anchor(top: chainNameLbl.bottomAnchor,  left: info1.leftAnchor, bottom: nil, right: info1.rightAnchor, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        addressLbl.text = currStore.store__address
        
        
        let labelTap = UITapGestureRecognizer(target: self, action: #selector(self.addressTapped(_:)))
        addressLbl.addGestureRecognizer(labelTap)
        
        

        info1.addSubview(distanceLbl)
        distanceLbl.anchor(top: addressLbl.bottomAnchor,  left: info1.leftAnchor, bottom: nil, right: info1.rightAnchor, paddingTop: 10, paddingLeft: 000, paddingBottom: 0, paddingRight: 0, width: 00, height: 0)
        distanceLbl.text = distanceAway
        

        
        Hscroll.addSubview(info2)
        info2.anchor(top: Hscroll.topAnchor, left: info1.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 150)
        

        
        info2.addSubview(ratingView)
        ratingView.anchor(top: info2.topAnchor,  left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 10, width: 145, height: 30)
        ratingView.centerXAnchor.constraint(equalTo: info2.centerXAnchor).isActive = true
  
        
        ratingView.addArrangedSubview(ratingLbl)
        ratingLbl.anchor(top: nil,  left: ratingView.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        ratingLbl.text = "(\(currStore.store__rating))"
        
        let starView = UIImageView()
        ratingView.addArrangedSubview(starView)
        starView.anchor(top: nil, left: ratingLbl.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width:    20, height: 20 )

        
        fullStarsRemaining = Int(currStore.store__rating)
        hasHalfStar = (currStore.store__rating-Float(Int(currStore.store__rating))==0 ? false : true )
        starView.backgroundColor = .clear


        if fullStarsRemaining != 0 {
            starView.image = #imageLiteral(resourceName: "starFull")
            fullStarsRemaining -= 1
        }
        else if fullStarsRemaining == 0 && hasHalfStar {
            starView.image = #imageLiteral(resourceName: "starHalf-1")
            hasHalfStar = false
        }
        else {
            starView.image = #imageLiteral(resourceName: "starDull-1")
        }


        
        starView.clipsToBounds = true
        starView.contentMode = .scaleAspectFit

       
        let starView2 = UIImageView()
        ratingView.addArrangedSubview(starView2)
        starView2.anchor(top: nil, left: starView.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width:    20, height: 20 )
        starView2.backgroundColor = .clear
        if fullStarsRemaining != 0 {
            starView2.image = #imageLiteral(resourceName: "starFull")
            fullStarsRemaining -= 1
        }
        else if fullStarsRemaining == 0 && hasHalfStar {
            starView2.image = #imageLiteral(resourceName: "starHalf-1")
            hasHalfStar = false
        }
        else {
            starView2.image = #imageLiteral(resourceName: "starDull-1")
        }
        starView2.clipsToBounds = true
        starView2.contentMode = .scaleAspectFit
        
        let starView3 = UIImageView()
        ratingView.addArrangedSubview(starView3)
        starView3.anchor(top: nil, left: starView2.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width:    20, height: 20 )
        starView3.backgroundColor = .clear
        if fullStarsRemaining != 0 {
            starView3.image = #imageLiteral(resourceName: "starFull")
            fullStarsRemaining -= 1
        }
        else if fullStarsRemaining == 0 && hasHalfStar {
            starView3.image = #imageLiteral(resourceName: "starHalf-1")
            hasHalfStar = false
        }
        else {
            starView3.image = #imageLiteral(resourceName: "starDull-1")
        }
        starView3.clipsToBounds = true
        starView3.contentMode = .scaleAspectFit
        
        let starView4 = UIImageView()
        ratingView.addArrangedSubview(starView4)
        starView4.anchor(top: nil, left: starView3.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width:    20, height: 20 )
        starView4.backgroundColor = .clear
        if fullStarsRemaining != 0 {
            starView4.image = #imageLiteral(resourceName: "starFull")
            fullStarsRemaining -= 1
        }
        else if fullStarsRemaining == 0 && hasHalfStar {
            starView4.image = #imageLiteral(resourceName: "starHalf-1")
            hasHalfStar = false
        }
        else {
            starView4.image = #imageLiteral(resourceName: "starDull-1")
        }
        starView4.clipsToBounds = true
        starView4.contentMode = .scaleAspectFit
        
        let starView5 = UIImageView()
        ratingView.addArrangedSubview(starView5)
        starView5.anchor(top: nil, left: starView4.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width:    20, height: 20 )
        starView5.backgroundColor = .clear
        if fullStarsRemaining != 0 {
            starView5.image = #imageLiteral(resourceName: "starFull")
            fullStarsRemaining -= 1
        }
        else if fullStarsRemaining == 0 && hasHalfStar {
            starView5.image = #imageLiteral(resourceName: "starHalf-1")
            hasHalfStar = false
        }
        else {
            starView5.image = #imageLiteral(resourceName: "starDull-1")
        }
        starView5.clipsToBounds = true
        starView5.contentMode = .scaleAspectFit
        
        
        info2.addSubview(openStatusStack)
        openStatusStack.anchor(top: ratingView.bottomAnchor,  left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 0, height: 0)
        openStatusStack.centerXAnchor.constraint(equalTo: info2.centerXAnchor).isActive = true

        openStatusStack.addArrangedSubview(openStatusLbl)
        openStatusLbl.anchor(top: nil,  left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        openStatusLbl.text = openStatus
        openStatusLbl.textColor = statusColor
        
        openStatusStack.addArrangedSubview(hourStatusLbl)
        hourStatusLbl.anchor(top: nil,  left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        let date = Date()
        let currDay =  Calendar.current.component(.weekday, from: date) - 1
        
        
        if currStore.store__openingHours.count == 1 {
            hourStatusLbl.text = ""
            openStatusStack.removeArrangedSubview(hourStatusLbl)
        } else {
        
            let hours = currStore.store__openingHours[currDay]
            if openStatus == "Closed today" {
                hourStatusLbl.text = ""
                openStatusStack.removeArrangedSubview(hourStatusLbl)
            }
            else {
                openStatusLbl.text = openStatus + ":"
                print("===\(hours)")
                var index = hours.index(hours.startIndex, offsetBy: 4)
                let part1 = hours.prefix(upTo: index)  //0830
                
                print("===\(part1)")
                
                index = part1.index(part1.startIndex, offsetBy: 2)  //08
                var hour1 = Int(part1.prefix(upTo: index))!
                print("===hour1 \(hour1)")
                
                index = part1.index(part1.endIndex, offsetBy: -2)  //30
                let minutes1 = part1.suffix(from: index)
                print("===min \(minutes1)")
                
                index = hours.index(hours.endIndex, offsetBy: -4)
                let part2 = hours.suffix(from: index)
                
                index = part2.index(part2.startIndex, offsetBy: 2)  //08
                var hour2 = Int(part2.prefix(upTo: index))!
                
                index = part2.index(part2.endIndex, offsetBy: -2)  //30
                let minutes2 = part2.suffix(from: index)
                
                var suff1 = "am"
                var suff2 = "am"
                
                if hour1 == 0{
                    hour1 = 12
                }
                else {
                    if hour1 > 12 {
                        hour1 -= 12
                        suff1 = "pm"
                    }
                }
                if hour2 == 0 {
                    hour2 = 12
                }
                else {
                    if hour2 > 12 {
                        hour2 -= 12
                        suff2 = "pm"
                    }
                }
                hourStatusLbl.text = "\(hour1):\(minutes1)\(suff1) - \(hour2):\(minutes2)\(suff2)"
                print("===\(hourStatusLbl.text)")
            }
        }
   

        info2.addSubview(weeklyHoursStack)
        weeklyHoursStack.anchor(top: openStatusStack.bottomAnchor,  left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 10, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        weeklyHoursStack.centerXAnchor.constraint(equalTo: info2.centerXAnchor).isActive = true
        
        weeklyHoursStack.addArrangedSubview(weeklyHoursLbl)
        weeklyHoursLbl.anchor(top: nil,  left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 00)
        
            
        let arrowView = UIImageView()
        
        weeklyHoursStack.addArrangedSubview(arrowView)
        arrowView.anchor(top: nil, left: starView4.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width:    23, height: 23 )
        
        arrowView.backgroundColor = .clear
          arrowView.image = UIImage(systemName: "chevron.down")
        arrowView.clipsToBounds = true
        arrowView.contentMode = .scaleAspectFit
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.showWeeklyHours(_:)))
        weeklyHoursStack.addGestureRecognizer(tap)
        
        let hold = UILongPressGestureRecognizer(target: self, action: #selector(self.changeWeeklyHoursColor(_:)))
        weeklyHoursStack.addGestureRecognizer(hold)
        
        
        Hscroll.addSubview(info3)
        info3.anchor(top: Hscroll.topAnchor, left: info2.rightAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 150)
        
        info3.addSubview(weekdayStack)
        weekdayStack.anchor(top: info3.topAnchor,  left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 235, height: 150)
        weekdayStack.centerXAnchor.constraint(equalTo: info3.centerXAnchor).isActive = true
        
        
        weekdayStack.addArrangedSubview(weekdayLbl)
        weekdayLbl.anchor(top: weekdayStack.topAnchor,  left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 85, height: 150)
        
        
        
        weekdayStack.addArrangedSubview(weekdayHoursLbl)
        weekdayHoursLbl.anchor(top: weekdayStack.topAnchor,  left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 90, height: 150)
       
        
        for hours in currStore.store__weekdayText {
            weekdayHoursLbl.text! += hours + "\n"
        }
        
        
        
        
        Hscroll.contentSize = CGSize(width: view.frame.width*2, height: 150)
        
        
        
        view.addSubview(pageControl)
        pageControl.anchor(top: Hscroll.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: -20, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10, height: 10)
        

        view.addSubview(spinner)
        spinner.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 200, height: 200)
        spinner.alpha = 1
        spinner.color = .black
        spinner.transform = CGAffineTransform(scaleX: 2, y: 2)
        
        
        
        
        
        
            
     
              


    
    }
    
    func configureDscroll() {



        Dscroll.backgroundColor = .black //Dark mode
        view.addScrollView(Dscroll, container: scrollContainer, elements: [spinner, storeImageView, whiteRect, tableView])
        
        
        //view.bringSubviewToFront(Vstack1)
//        view.bringSubviewToFront(chainNameLbl)
//        view.bringSubviewToFront(addressLbl)
//        view.bringSubviewToFront(distanceLbl)
        view.bringSubviewToFront(Hscroll)
        view.bringSubviewToFront(pageControl)
        view.bringSubviewToFront(tableView)
        
        Dscroll.alwaysBounceVertical = true
        

        //storeImageView.topAnchor.constraint(equalTo: Dscroll.topAnchor).isActive = true
        
        
        
        
    }
    
    @objc func openStoreImage(){
        let IC = ImageController()
        IC.img.image = storeImageView.image
        navigationController?.pushViewController(IC, animated: true)
    }
  
    @objc func configureImageView() {

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
              if self.stillLoading {
                  self.spinner.isHidden = false
            }
        }

            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                if let data = try? Data(contentsOf: URL(string: (self?.currStore.store__storeImage)!)!) {
                    if let img = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self?.storeImageView.image = img
                            if Int((self?.storeImageView.image?.size.width)!) > Int((self?.storeImageView.image?.size.height)!) {
                                self?.storeImageView.contentMode = .scaleAspectFit
                                //since the width > height we may fit it and we'll have bands on top/bottom
                            } else {
                                self?.storeImageView.contentMode = .scaleAspectFill
                              //width < height we fill it until width is taken up and clipped on top/bottom
                            }


                            let scaleFactor = (self?.view.frame.width)!/(self?.storeImageView.image?.size.width)!

                           let newHeight = scaleFactor * (self?.storeImageView.image?.size.height)!

                           self?.storeImageView.heightAnchor.constraint(equalToConstant: newHeight).isActive = true

                            self?.view.willRemoveSubview(self!.spinner)
                            self?.spinner.isHidden = true
                            self?.stillLoading = false




                        }
                    }
                }
            }

        
        
                
            let tap = UITapGestureRecognizer(target: self, action: #selector(openStoreImage))
        storeImageView.addGestureRecognizer(tap)
        storeImageView.isUserInteractionEnabled = true

 
            view.addSubview(self.storeImageView)



    }

    
    func getProductData() {
        Products.shared.initialize(withSupply: supply, withStoreID: currStore.store__id)
        
        DispatchQueue.global(qos: .userInitiated).async {
            Products.shared.fetchProducts { (result) in
                switch result {
                case .success(let products):
                    DispatchQueue.main.async {
                        self.products = products
                        
                        self.configureViewComponents()
                        print("======\(products)")
                    }
                case .failure(let error):
                    print("===DEBUG: Failed with error \(error)")
                }
                
            }
        }
        
        
        
    }
    
    
    func configureTableView() {
        
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(ProductCell.self, forCellReuseIdentifier: "ProductCell")
        tableView.register(AdCell.self, forCellReuseIdentifier: "AdCell")
        
        tableView.isUserInteractionEnabled = true
        
        tableView.separatorInset = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: 0)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        
        
        if Ads.shared.adsEnabled {
            print("+++Configuring add indexes")
            
            var rowCount = products.count
            var adIndex = 0
            
            while ((adIndex+Random.shared.tableRowStart) <= rowCount) {
                adIndex =  Int.random(in: (adIndex+Random.shared.tableRowStart)...(adIndex+Random.shared.tableRowEnd))
                if adIndex > rowCount {
                    break
                }
                adIndexes.append(adIndex)
                products.insert(product(), at: adIndex)
                rowCount += 1
            }
        }
        
        
        
        
        
        
        
        
        view.addSubview(tableView)
        tableView.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 100, height: CGFloat(products.count*150))
        //tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        //tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        
        let cell = ProductCell()
        stackWidth = cell.stackWidth
    }
    
    
    


}
    


extension StoreController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        
        
        
        return 150
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return products.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            if Ads.shared.adsEnabled {
                if adIndexes.count > 0 {
                    if indexPath.row == adIndexes[0] {
                        let cell = tableView.dequeueReusableCell(withIdentifier: "AdCell") as! AdCell
                        cell.bannerAd.rootViewController = self
                        cell.bannerAd.load(GADRequest())
                        cell.cancelBtn.addTarget(self, action: #selector(showPopup), for: .touchUpInside)
                        adIndexes.remove(at: 0)
                        return cell
                    } }
            }
            
            
            
            
            
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell") as! ProductCell
            let product = products[indexPath.row]
            cell.productName.text = product.name

            print("===height of NAME: \(cell.productName.intrinsicContentSize.height)")

            if product.minQuantity == 0 {
                cell.stockStatusLbl.text = "Limited stock"
                cell.stockStatusLbl.textColor = UIColor.rgb(red: 255, green: 153, blue: 0)
            }
            else if product.minQuantity == -1 {
                cell.stockStatusLbl.text = "Out of stock"
                cell.stockStatusLbl.textColor = UIColor.rgb(red: 255, green: 0, blue: 0)
                cell.quantityLbl.text = ""
            }
            else {
                cell.stockStatusLbl.text = "In stock"
                cell.stockStatusLbl.textColor = .systemGreen
                if currStore.store__chainName == "Target" {
                    cell.quantityLbl.text = ""
                    cell.quantityLbl.removeFromSuperview()
                } else {
                    cell.quantityLbl.text = "Qty: " + product.quantity
                }
            }

            
            if currStore.store__chainName == "CVS" {
                cell.priceLbl.text = ""
                cell.priceLbl.removeFromSuperview()
            } else {
                print("===\((product.price - Float(Int(product.price))))")
                if (product.price - Float(Int(product.price))) == 0.0 {
                    cell.priceLbl.text = "$\(product.price)0"
                }
                else {
                    cell.priceLbl.text = "$\(product.price)"
                }
            }
            /*
            print("=====frame \(cell.productName.frame.height)")

            let lines = Int(cell.productName.layer.frame.height)/Fonts.shared.productNameFontHeight
            print("=====LINES \(lines)")
            if lines == 2 {
                 cell.rowHeight = 120
            }
            else if lines == 3 {
                 cell.rowHeight = 140
            }
            else if lines == 4 {
                 cell.rowHeight = 160
            }
            else {
                cell.rowHeight = 100
            }

          */


            if cell.quantityLbl.text?.count == 0 {
                print("===GOT HEREË")
                cell.addSubview(cell.notificationBtn)
                cell.notificationBtn.tag = indexPath.row
                cell.notificationBtn.addTarget(self, action: #selector(addNotification(sender:)), for: .touchUpInside)

                cell.notificationBtn.anchor(top: cell.topAnchor, left: nil, bottom: nil, right: cell.rightAnchor, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 30, height: 30)
            } else {
                cell.notificationBtnFake.isHidden = true
            }
            



            cell.nearbyStoresBtn.addTarget(self, action: #selector(showNearbyStores(sender:)), for: .touchUpInside)
            cell.nearbyStoresBtn.tag = indexPath.row

            cell.productImage.tag = indexPath.row
            let tap = UITapGestureRecognizer(target: self, action: #selector(openImageController(_:)))
            cell.productImage.addGestureRecognizer(tap)


            let options = ImageLoadingOptions(
                failureImage: #imageLiteral(resourceName: "image-not-foundBIG")
                //Big: #imageLiteral(resourceName: "image-not-foundBIG")
            )
            Nuke.loadImage(with: URL(string: products[indexPath.row].imageLink)!, options: options, into: cell.productImage)

            return cell
            
            
    }
        
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            print("====SELECTED ROW")
    }
     
    
    
}




extension UIImage {
    func resizableImageWithStretchingProperties(
    X X: CGFloat, width widthProportion: CGFloat,
    Y: CGFloat, height heightProportion: CGFloat) -> UIImage {

        let selfWidth = self.size.width
        let selfHeight = self.size.height

        // insets along width
        let leftCapInset = X*selfWidth*(1-widthProportion)
        let rightCapInset = (1-X)*selfWidth*(1-widthProportion)

        // insets along height
        let topCapInset = Y*selfHeight*(1-heightProportion)
        let bottomCapInset = (1-Y)*selfHeight*(1-heightProportion)

        return self.resizableImage(
            withCapInsets: UIEdgeInsets(top: topCapInset, left: leftCapInset,
                bottom: bottomCapInset, right: rightCapInset),
            resizingMode: .stretch)
    }
}

 



extension StoreController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearbyStores.count
    }
    
    
    internal func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

    
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NearbyStoreCell", for: indexPath) as!  NearbyStoreCell
        let store = nearbyStores[indexPath.row]
        cell.cityLbl.text = store.store__city
        if store.store__chainName == "CVS" {
            cell.chainLogo.image = #imageLiteral(resourceName: "cvs")
            cell.chainLogo.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } else if store.store__chainName == "Walmart" {
            cell.chainLogo.image = #imageLiteral(resourceName: "Walmart_logo_transparent_png")
        } else {
            
            //fucker
            let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
            if scheme == 0 {
                  cell.chainLogo.image = #imageLiteral(resourceName: "targBlack")
            }
            else if scheme == 1 {
                  cell.chainLogo.image = #imageLiteral(resourceName: "targBlack")
            } else {
                  cell.chainLogo.image = #imageLiteral(resourceName: "targBlack")
            }
          
        }
        
        
        if store.minQuantity == 0 {
            cell.quantityLbl.text = "Limited stock"
        } else {
            cell.quantityLbl.text = "Qty: " + store.quantity
        }
        
        let openStatus: String
        let statusColor: UIColor
        (openStatus, statusColor)  = Functions.shared.calculateOpenStatus(store: store)
        
        cell.openStatusLbl.text = openStatus
        cell.openStatusLbl.textColor = statusColor
        
        let userPt = MKMapPoint(Location.shared.coordinates)
        let storePt = MKMapPoint(CLLocationCoordinate2D(latitude: store.store__latitude, longitude:  store.store__longitude))
        let dist = ceil(userPt.distance(to: storePt)*0.000621*100)/100
        cell.distanceLbl.text = "\(dist) miles"
        
        if nearbyStoresInfo.count != nearbyStores.count {
            nearbyStoresInfo.append((openStatus, statusColor, Float(dist)))
        }
        
        print("====+ distance: \(ceil(userPt.distance(to: storePt)*0.000621*100)/100)")
        
        
        let options = ImageLoadingOptions(
            failureImage: #imageLiteral(resourceName: "image-not-found")
        )
        Nuke.loadImage(with: URL(string: nearbyStores[indexPath.row].store__storeImage)!, options: options, into: cell.storeImage)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storeController = StoreController()
        storeController.currStore = nearbyStores[indexPath.row].convertToStore()
        storeController.distanceAway = "\(nearbyStoresInfo[indexPath.row].distance) miles away"
        storeController.openStatus = nearbyStoresInfo[indexPath.row].openStatus
        storeController.statusColor = nearbyStoresInfo[indexPath.row].openStatusColor
        storeController.supply = supply
        storeController.firstVC = false
        self.navigationController?.pushViewController(storeController, animated: true)
        closeNearbyStores(UITapGestureRecognizer())
    }
    
    
}
