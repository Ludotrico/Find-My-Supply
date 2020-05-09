//
//  HomeController.swift
//  findMySupply2
//
//  Created by Ludovico Veniani on 3/27/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit
import MapKit
import SwiftUI
import CoreLocation
import EzPopup
import GoogleMobileAds

class HomeController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black

        //print(BCryptSwift.generateSalt())
        //showActivityIndicatory()
        

            
        loadInterstitial()
        configureLocationManager()
        
        if let coordinates = self.locationManager.location?.coordinate {
            Location.shared.coordinates = coordinates
        }
        else {
    
        }
        
        authenticateUserAndConfigureView()
        

        configureViewComponents()
        configureMenu()
        configureMenuView()
        configureColorScheme()
        
    

 
        let region = MKCoordinateRegion(center: Location.shared.coordinates, latitudinalMeters: 2000, longitudinalMeters: 2000)
            self.mapView.setRegion(region, animated: false)
        
        
        initialNeedsCentering = false
        
        
        
        tableView.estimatedRowHeight = 50
        
        
        
        

                
        
    }
    

    
    
    override func viewWillAppear(_ animated: Bool) {
        configureColorScheme()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true 
    }



    
    override func viewDidAppear(_ animated: Bool) {
        isSearching = false
        if !zipUpdated && UserDefaults.standard.bool(forKey: "isRegistered"){
            updateUserZip()
            zipUpdated = true
        }

        UIApplication.shared.applicationIconBadgeNumber = 0
        
        enableLocationServices()
        if UserDefaults.standard.bool(forKey: "firstLaunch") {
            configureThemePopup()
            UserDefaults.standard.set(false, forKey: "firstLaunch")
        }
   
        
        

        
            
        //Darkmode
        
    }
    
    
    let whitePadding: UIView = {
        let view = UIView()
        view.backgroundColor = Color.shared.gold//.white
        view.layer.cornerRadius = 20
        return view
    }()
    

    

    func showActivityIndicatory() {
        let activityView = UIActivityIndicatorView(style: .large)
        activityView.center = self.view.center
        self.view.addSubview(activityView)
        activityView.startAnimating()
    }

    // MARK: - Properties
    

    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    var locationEnabled = false
    var tableView: UITableView!
    var showingMenu = false
    var supplies = [supplyOption]()
    var stores = [store]()
    var storeQuantities = [storeQuantity]()
    var calloutIsShowing = false
    var calloutShowing = -1
    var authorized = true
    var supplySearchedFor: String!
    var city = ""
    let supplyList = ["Face Masks", "Gloves", "Hand Sanitizer", "Soap", "Toilet Paper", "Disinfectant Wipes", "Disinfectant Spray"]


    
    let centerMapBtn: UIButton = {
        let button = UIButton(type: .system)
        //var img = UIImage(systemName: "location.fill")
//        button.setImage(#imageLiteral(resourceName: "centerMapBtnGold").withRenderingMode(.alwaysOriginal), for: .normal)
//        button.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)


        button.addTarget(self, action: #selector(handleCenterOnUser), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    let callout: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 100
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 0/255, green: 227/255, blue: 15/255, alpha: 1)
        view.isHidden = true
        view.backgroundColor = UIColor.white.withAlphaComponent(0.9)
        view.layer.borderWidth = 10
        view.layer.borderColor = Color.shared.theme.cgColor
        view.isUserInteractionEnabled = true
        
        return view
    }()
        var t = #imageLiteral(resourceName: "triBlack")
    
     let viewItems: UIButton = {
         let button = UIButton(type: .system)
         button.setTitle("View items", for: .normal)
         button.setTitleColor(Color.shared.blue, for: .normal)
          // button.addTarget(self, action: #selector(redirect), for: .touchUpInside)
         button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 120)
         button.layer.borderColor = Color.shared.blue.cgColor
         button.backgroundColor = .clear
         button.isEnabled = true
         button.addTarget(self, action: #selector(showItems), for: .touchUpInside)
    

         button.layer.cornerRadius = 10
         //button.layer.borderWidth = 10
         
         button.translatesAutoresizingMaskIntoConstraints = false
         return button
     }()
    
    let getDirections: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Get directions", for: .normal)
        button.setTitleColor(Color.shared.blue, for: .normal)
         // button.addTarget(self, action: #selector(redirect), for: .touchUpInside)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 120)
        button.layer.borderColor = Color.shared.blue.cgColor
        button.backgroundColor = .clear
        button.isEnabled = true
        button.addTarget(self, action: #selector(redirect), for: .touchUpInside)
   

        button.layer.cornerRadius = 10
        //button.layer.borderWidth = 10
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var roundRect = #imageLiteral(resourceName: "roundRect")
    
    
    

    let pinView: UIImageView = {
        let view = UIImageView()
        //view.layer.cornerRadius = 100
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isHidden = true
        view.alpha = 1
        
        return view
    }()
        

    let triView: UIImageView = {
        let view = UIImageView()
        //view.layer.cornerRadius = 100
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isHidden = true
        view.alpha = 1


        
        return view
    }()
    
    let rectView: UIImageView = {
        let view = UIImageView()
        //view.layer.cornerRadius = 100
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isHidden = false
        view.alpha = 1
        view.image = #imageLiteral(resourceName: "roundRect")
        return view
    }()
    
    let rectView2: UIImageView = {
        let view = UIImageView()
        //view.layer.cornerRadius = 100
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.isHidden = false
        view.alpha = 1
        view.image = #imageLiteral(resourceName: "roundRect")
        return view
    }()

    let logoViewTarget: UIImageView = {
        let view = UIImageView()
        //view.layer.cornerRadius = 100
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.image = #imageLiteral(resourceName: "target-logo-png-6-transparent")
        view.contentMode = .scaleAspectFit
        view.alpha = 1
        view.transform = CGAffineTransform(scaleX: 8.5, y: 8.5)

        return view
    }()
    
    let logoViewWalmart: UIImageView = {
        let view = UIImageView()
        //view.layer.cornerRadius = 100
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.image = #imageLiteral(resourceName: "Walmart_logo_transparent_png")
        view.contentMode = .scaleAspectFit
        view.alpha = 1
        view.transform = CGAffineTransform(scaleX: 2.8, y: 3)

        return view
    }()
    
    let logoViewCVS: UIImageView = {
        let view = UIImageView()
        //view.layer.cornerRadius = 100
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.image = #imageLiteral(resourceName: "cvs")
        view.contentMode = .scaleAspectFit
        view.alpha = 1
        view.transform = CGAffineTransform(scaleX: 2, y: 2)

        return view
    }()
    
    let distanceLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        lbl.text = ""
        lbl.textColor = .black
        lbl.font = UIFont(name: "HelveticaNeue", size: 30)
        lbl.textAlignment = .center
        lbl.transform = CGAffineTransform(scaleX: 4, y: 4)
        return lbl
    }()
    
    let openStatusLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        lbl.text = ""
        lbl.textColor = .black
        lbl.font = UIFont(name: "HelveticaNeue", size: 30)
        lbl.textAlignment = .center
        lbl.transform = CGAffineTransform(scaleX: 4, y: 4)
        return lbl
    }()
    
    let quantityLbl: UILabel = {
        let lbl = UILabel(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        lbl.text = ""
        lbl.textColor = .black
        lbl.font = UIFont(name: "HelveticaNeue", size: 30)
        lbl.textAlignment = .center
        lbl.transform = CGAffineTransform(scaleX: 4, y: 4)
        return lbl
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = Color.shared.gold
        
        spinner.startAnimating()
        spinner.alpha = 1
        spinner.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        spinner.isHidden = true
        return spinner
    }()
    
    let notifBtn: UIButton = {
        let button = UIButton(type: .system)
        var img = #imageLiteral(resourceName: "notfi+")
        button.setImage( img.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(addNotification), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button

    }()
    
    
    
    
    let menuBtn: UIButton = {
        let button = UIButton(type: .system)
        var img = #imageLiteral(resourceName: "menu-1")
        button.setImage( img.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(openMenu), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    let menuStack: UIStackView = {
        let Vstack = UIStackView()
        //Vstack.alignment = .leading
        Vstack.axis = .vertical
        //Vstack.spacing = 30
        return Vstack
    }()
    
    let Hstack1: UIStackView = {
        let Hstack = UIStackView()
        Hstack.axis = .horizontal
        //Hstack.alignment = .leading
        Hstack.spacing = 15
        Hstack.isUserInteractionEnabled = true
        return Hstack
    }()
    
    let Hstack2: UIStackView = {
        let Hstack = UIStackView()
        Hstack.axis = .horizontal
        Hstack.alignment = .leading
        Hstack.spacing = 15
        return Hstack
    }()
    
    let Hstack3: UIStackView = {
        let Hstack = UIStackView()
        Hstack.axis = .horizontal
        Hstack.alignment = .leading
        Hstack.spacing = 15
        return Hstack
    }()
    
    let profileImg: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image = #imageLiteral(resourceName: "goldProf").withRenderingMode(.alwaysOriginal)
        return view
    }()
    
    let profileLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Profile"
        lbl.font = UIFont(name: "Helvetica-Bold", size: 28)
        lbl.textColor = Color.shared.gold  //Dark mode
        lbl.textAlignment = .left
        return lbl
    }()
    
    let notifIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image =  #imageLiteral(resourceName: "goldBell").withRenderingMode(.alwaysOriginal)
        view.image?.withTintColor(.white)
        return view
    }()
    
    let notifLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Notifications"
        lbl.font = UIFont(name: "Helvetica-Bold", size: 28)
        lbl.textColor = Color.shared.gold  //Dark mode
        lbl.textAlignment = .left
        return lbl
    }()
    
    
    let settingsIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFit
        view.clipsToBounds = true
        view.image =  #imageLiteral(resourceName: "goldGear").withRenderingMode(.alwaysOriginal)
        return view
    }()
    
    let settingsLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Settings"
        lbl.font = UIFont(name: "Helvetica-Bold", size: 28)
        lbl.textColor = Color.shared.gold  //Dark mode
        lbl.textAlignment = .left
        return lbl
    }()
    
    let themePopup: ThemePopup = {
       let view = ThemePopup()
        view.translatesAutoresizingMaskIntoConstraints =  false
        return view
    }()
    
    let newScrape: NewScrapePopup = {
       let view = NewScrapePopup()
        view.translatesAutoresizingMaskIntoConstraints =  false
        return view
    }()
    
    let blur: UIVisualEffectView = {
        let effect = UIBlurEffect(style: .light)
        let blur = UIVisualEffectView(effect: effect)
        blur.translatesAutoresizingMaskIntoConstraints  = false
        blur.alpha = 0
    
        
        return blur
    }()
    
    let go: UIButton = {
        let btn = UIButton()
        btn.setTitle("Let's go", for: .normal)
        btn.setTitleColor(Color.shared.blue, for: .normal)
        btn.backgroundColor = .white
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 25)
        btn.layer.borderColor = UIColor.white.cgColor //Dark mode
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(dismissThemePopup), for: .touchUpInside)
        
        return btn
        
    }()
    
    let go2: UIButton = {
        let btn = UIButton()
        btn.setTitle("Got it", for: .normal)
        btn.setTitleColor(Color.shared.theme, for: .normal)
        btn.backgroundColor = Color.shared.gold
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 25)
        btn.layer.borderColor = Color.shared.gold.cgColor//UIColor.white.cgColor //Dark mode
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(dismissNewScrape), for: .touchUpInside)
        
        return btn
        
    }()
    
    let addZip: UIButton = {
        let btn = UIButton()
        btn.setTitle("Add ZIP code", for: .normal)
        btn.setTitleColor(Color.shared.theme, for: .normal)
        btn.backgroundColor = Color.shared.gold
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 25)
        btn.layer.borderColor = Color.shared.gold.cgColor//UIColor.white.cgColor //Dark mode
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(addNewZipcode), for: .touchUpInside)
        
        return btn
        
    }()
    
    let cancel: UIButton = {
        let btn = UIButton()
        btn.setTitle("Cancel", for: .normal)
        btn.setTitleColor(Color.shared.theme, for: .normal)
        btn.backgroundColor = Color.shared.red
        btn.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 25)
        btn.layer.borderColor = Color.shared.red.cgColor //UIColor.white.cgColor //Dark mode
        btn.layer.borderWidth = 3
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(dismissNewScrape2), for: .touchUpInside)
        
        return btn
        
    }()

    
    let menuView = UIView()
    let menuTableView = UITableView()

 
    var menuIsShowing = false
    
    var stillLoading = false
    
//    let transition = SlideInTransition()
    
    var delegate: HomeControllerDelegate?
    
    var viewTap = UIGestureRecognizer(target: self, action: #selector(closeMenu))
    
    var isSearching = false
    
    var initialNeedsCentering = true
    
    var country = ""
    
    var countryNotSupported = false
    
    var zipNotSupported = false
    
    var zipUpdated = false
    
    var interstitial: GADInterstitial?
    

 
    
    
    // MARK: - Selectors
    func loadInterstitial() {
        DispatchQueue.global(qos: .background).async {
            self.interstitial = GADInterstitial(adUnitID: Ads.shared.interstitialTest)
            self.interstitial?.delegate = self
            
            let request = GADRequest()
            self.interstitial?.load(request)
        }
    }
    
    func showInterstitial() {

        DispatchQueue.global(qos: .userInitiated).async {
            while true {
                if let ready = self.interstitial?.isReady {
                    if ready {
                        if Int.random(in: 1...Random.shared.adPopup) == 1 {
                            self.interstitial?.present(fromRootViewController: self)
                        }
                        break
                    }
                }
            }
        }
     

        
    }
    
    @objc func showGoldPopup() -> Bool {
        if (Int.random(in: 1...Random.shared.goldPopup) == 1){
           let GC = GoldPopup()
            GC.isPopup = true
            GC.popupWidth = self.view.frame.width*(4/5)
            GC.popupHeight = self.view.frame.height*(4/5)
            GC.fromStoreController = false

            // Init popup view controller with content is your content view controller
            let popupVC = PopupViewController(contentController: GC, popupWidth: GC.popupWidth, popupHeight: GC.popupHeight)
            
            popupVC.backgroundAlpha = 0.4
            popupVC.backgroundColor = Color.shared.darkGold
            popupVC.canTapOutsideToDismiss = true
            popupVC.cornerRadius = 10
            popupVC.shadowEnabled = true
            
            // show it by call present(_ , animated:) method from a current UIViewController
            self.present(popupVC, animated: true)
            return true
        }
        return false
        
       }
    
    
    
    @objc func addNewZipcode() {
        DispatchQueue.main.async {
            self.dismissNewScrape2()
            self.spinner.isHidden = false
        }
        
        DispatchQueue.global(qos: .userInitiated).async {
            UpdateUser.shared.addNewZipcode { (result) in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        let lbl = self.createLbl(text: "\(UpdateUser.shared.zip) successfully added to the server.")
                        lbl.backgroundColor = .systemGreen
                        
                        self.showMessage(label: lbl)
                        self.zipNotSupported = false
                        self.spinner.isHidden = true
                    }
                    
                case .failure(let error):
                    print("DEBUG: Failed with error \(error)")
                    DispatchQueue.main.async {
                        self.spinner.isHidden = true
                        self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                    }
                 
                }
            }
        }
        
        
        

      
        
    }
    
    @objc func dismissThemePopup() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.blur.alpha = 0

            self.themePopup.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.go.transform = CGAffineTransform(scaleX: 0, y: 0)
            
        }, completion: { _ in
            self.blur.removeFromSuperview()
            self.themePopup.removeFromSuperview()
            self.go.removeFromSuperview()
            
            if UserDefaults.standard.bool(forKey: "waitingForScrape") {
                UserDefaults.standard.set(false, forKey: "waitingForScrape")
                self.configureWaitingForScrape()
            }
        })
        
        DispatchQueue.main.async {
            self.configureColorScheme()
            

            
        }
        
        
    }
    
      @objc func dismissNewScrape2() {
          UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
              self.blur.alpha = 0

              self.newScrape.transform = CGAffineTransform(scaleX: 0, y: 0)
    
          
              self.addZip.transform = CGAffineTransform(scaleX: 0, y: 0)
            self.cancel.transform = CGAffineTransform(scaleX: 0, y: 0)
              
          }, completion: { _ in
              self.blur.removeFromSuperview()
              self.newScrape.removeFromSuperview()
              self.addZip.removeFromSuperview()
              self.cancel.removeFromSuperview()
              

          })

          
      }
    
    @objc func dismissNewScrape() {
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            self.blur.alpha = 0

            self.newScrape.transform = CGAffineTransform(scaleX: 0, y: 0)
  
        
            self.go2.transform = CGAffineTransform(scaleX: 0, y: 0)
            
        }, completion: { _ in
            self.blur.removeFromSuperview()
            self.newScrape.removeFromSuperview()
            self.go2.removeFromSuperview()
            

        })

        
    }
    
    
      func handleAddNotification() {
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
                        self.showMessage(label: self.createLbl(text: "Oops! An unexpected error occurred, please try again."))
                      }
                      self.handleAddNotification()
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
                      self.addSupplyRegionNotification()
                        
                        Gold.shared.sendRegistrationId()
                  
                  
                      
     
              

                   
                  
              }
              
          }
          



    
          
          
          
         
      }
    
    
    @objc func closeMenu() {
        print("+++IN CLOSE MENU, showing: \(menuIsShowing)")
//        if menuIsShowing {
//
//            openMenu()
//        }
        
        
    }
    
    
    @objc func openProfileController() {
        print("+++++OPEN PROFILE")
        navigationController?.pushViewController(ProfileController(), animated: true)
    }
    
    @objc func openNotificationsController() {
        navigationController?.pushViewController(NotificationsController(), animated: true)
        
    }
    
    @objc func openSettingsController() {
        navigationController?.pushViewController(SettingsController(), animated: true)
        
    }
    
    func configureMenuView() {
        menuView.isHidden = true
        menuView.isUserInteractionEnabled = true
        Hstack1.isUserInteractionEnabled = true
        view.addSubview(menuView)

        menuView.translatesAutoresizingMaskIntoConstraints = false

        //menuView.frame = CGRect(x: -250,y: 0, width: 500, height: view.frame.height)
        //menuView.rightAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuView.anchor(top: nil, left: nil, bottom: nil, right: view.leftAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 250, height: view.frame.height)
      //
        menuView.backgroundColor = .black

        //        menuView.addSubview(menuStack)
        //        menuStack.anchor(top: nil, left: menuView.leftAnchor, bottom: menuView.bottomAnchor, right: menuView.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: 0, paddingRight: 20)
        //        menuStack.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 100).isActive = true
        //
        //        menuStack.addArrangedSubview(Hstack1)
        
        menuView.addSubview(Hstack1)
        Hstack1.anchor(top: nil, left: menuView.leftAnchor, bottom: nil, right: menuView.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15, width: menuView.frame.width, height: 30)
        Hstack1.topAnchor.constraint(equalTo: menuView.topAnchor, constant: 100).isActive = true
        var tap = UITapGestureRecognizer(target: self, action: #selector(openProfileController))
        Hstack1.addGestureRecognizer(tap)

        Hstack1.addArrangedSubview(profileImg)
        profileImg.anchor(top: Hstack1.topAnchor, left: Hstack1.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        Hstack1.addArrangedSubview(profileLbl)
        profileLbl.anchor(top: Hstack1.topAnchor, left: profileImg.rightAnchor, bottom: nil, right: Hstack1.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)

        menuView.addSubview(Hstack2)
        Hstack2.anchor(top: nil, left: menuView.leftAnchor, bottom: nil, right: menuView.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
        Hstack2.topAnchor.constraint(equalTo: Hstack1.bottomAnchor, constant: 30).isActive = true


        Hstack2.addArrangedSubview(notifIcon)
        notifIcon.anchor(top: Hstack2.topAnchor, left: Hstack2.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        Hstack2.addArrangedSubview(notifLbl)
        notifLbl.anchor(top: Hstack2.topAnchor, left: notifIcon.rightAnchor, bottom: nil, right: Hstack2.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)

        menuView.addSubview(Hstack3)
        Hstack3.anchor(top: nil, left: menuView.leftAnchor, bottom: nil, right: menuView.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 15)
        Hstack3.topAnchor.constraint(equalTo: Hstack2.bottomAnchor, constant: 30).isActive = true


        Hstack3.addArrangedSubview(settingsIcon)
        settingsIcon.anchor(top: Hstack3.topAnchor, left: Hstack3.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
        Hstack3.addArrangedSubview(settingsLbl)
        settingsLbl.anchor(top: Hstack3.topAnchor, left: notifIcon.rightAnchor, bottom: nil, right: Hstack3.rightAnchor, paddingTop: 0, paddingLeft: 15, paddingBottom: 0, paddingRight: 0)
    }
    
    @objc func openMenu() {
        print("===+ ADDING Menu")
        

        
        delegate?.handleMenuToggle(forMenuOption: nil)
        
       
        //self.navigationController?.pushViewController(MenuController(), animated: true)
//
//        let mc = MenuController()
//       // mc.modalPresentationStyle = .fullScreen
//       // mc.transitioningDelegate = self
//        self.present(mc, animated: true, completion: nil)
        
        
//
//        if menuIsShowing {
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
//                self.view.frame.origin.x = 0
//            }, completion: { _ in
//                self.menuView.isHidden = true
//            })
//        } else {
//            menuView.isHidden = false
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
//                //self.view.frame.origin.x = self.view.frame.origin.x + 250
//                self.view.transform = CGAffineTransform(translationX: 250, y: 0)
//                //self.menuView.frame = CGRect(x: 0,y: 0, width: 250, height: self.view.frame.height)
//                //self.menuView.frame.origin.x = self.menuView.frame.origin.x + 250
//                //self.menuView.frame = CGRect(x: 0,y: 0, width: 250, height: self.view.frame.height)
//                //self.mapView.frame.origin.x = self.mapView.frame.origin.x + 250
//                //self.view.frame = CGRect(x: 250, y: 0, width: self.view.frame.width, height: self.view.frame.height)
//            }, completion: { _ in
//                //self.menuView.frame.offsetBy(dx: 250, dy: 0)
//                //self.menuView.bounds = CGRect(x: 0, y: 0, width: 250, height: self.view.frame.height)
//                self.menuView.frame = CGRect(x: 0,y: 0, width: 250, height: self.view.frame.height)
//                //self.view.frame.origin.x = self.view.frame.origin.x + 250
//                //self.menuView.frame = CGRect(x: 0,y: 0, width: 250, height: self.view.frame.height)
//                //self.menuView.frame = CGRect(x: -250,y: 0, width: 250, height: self.view.frame.height)
//            })
//        }
        

        
      
        
        
        
        
        
        
    }
    

    
    @objc func addNotification() {
        print("===+ ADDING NOTIFICATION")
        
   
        
        var actionSheet = UIAlertController()

        actionSheet = UIAlertController(title: "Add Supply Notification", message: "Do you wish to be notified when this supply is restocked in your area?", preferredStyle: .actionSheet)

        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let addRegionNotification = UIAlertAction(title: "Add area notification ", style: .default) { action in
            if UserDefaults.standard.bool(forKey: "isGold") {
                self.handleAddNotification()
            } else {
        
                let GC = GoldPopup()
                GC.isPopup = true
                GC.popupWidth = self.view.frame.width*(4/5)
                GC.popupHeight = self.view.frame.height*(4/5)
                GC.fromStoreController = false
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
            


            
            

        }

        actionSheet.addAction(addRegionNotification)
        actionSheet.addAction(cancel)

        if let presenter = actionSheet.popoverPresentationController {
            let btn = notifBtn as! UIView
            presenter.sourceView = btn
            presenter.sourceRect = btn.bounds
        }

        self.present(actionSheet, animated: true, completion: nil)
               

        
        
        
        
    }
    
    
    @objc func showItems() {
         print("=========================SHOW ITEMS tapped")
        closeDropMenu()
  
        let storeController = StoreController()
        storeController.currStore = stores[calloutShowing]
        storeController.distanceAway = distanceLbl.text!
        storeController.openStatus = openStatusLbl.text!
        storeController.statusColor = openStatusLbl.textColor
        storeController.supply = supplySearchedFor
        storeController.city = city
        self.navigationController?.pushViewController(storeController, animated: true)
    }
    
    func handleRedirect() {
        //let redirection = "http://maps.apple.com/?daddr=4255,Campus+Dr,A116,Irvine,CA"
        //let url = URL(string: redirection)
        
        
        
        closeDropMenu()
        
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
        let redirection = "waze://?ll=\(stores[calloutShowing].store__latitude),\(stores[calloutShowing].store__longitude)&navigate=yes"
        let url = URL(string: redirection)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    func googleRedirect() {
        //let redirection = "https://www.google.com/maps/dir/?api=1&destination=QVB&destination_place_id=ChIJISz8NjyuEmsRFTQ9Iw7Ear8&travelmode=driving"
        let redirection = "https://www.google.com/maps/dir/?api=1&destination=\(stores[calloutShowing].store__chainName)&destination_place_id=\(stores[calloutShowing].store__googlePlaceID)&travelmode=driving"
        let url = URL(string: redirection)
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    func appleRedirect() {
        let placemark = MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: stores[calloutShowing].store__latitude, longitude: stores[calloutShowing].store__longitude))
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = stores[calloutShowing].store__chainName
        mapItem.openInMaps(launchOptions: nil)
    }
    
    
    
    @objc func redirect() {
         print("=========================GET DIRECTIONS tapped")
        handleRedirect()
    }
        
    @objc func handleMapTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("========+handling MAP tap")
        print("=======+calloutIsShowing\(calloutIsShowing)")
        print("=======+calloutShowing\(calloutShowing)")
        
      
        if calloutIsShowing && !showingMenu{

            callout.isHidden = true
            triView.isHidden = true
            calloutIsShowing =  false
            calloutShowing = -1
            Static.shared.calloutIsShowing = false
        }
            closeDropMenu()
      
        
    }
    
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
        print("===+handling CALLOUT tap")
        
        
        
        
              // let annotationView = sender?.view as! MKAnnotationView
              // let view = annotationView.annotation as! CustomAnnotation
        
        //let views = Bundle.main.loadNibNamed("CustomCalloutView", owner: nil, options: nil)
        //let calloutView = views?[0] as! CustomCalloutView
        //calloutView.lbl1.text = "heHE"

        //let button = UIButton(frame: calloutView.img.frame)
        //button.addTarget(self, action: #selector(redirect), for: .touchUpInside)
        //calloutView.addSubview(button)
        // 3
       
        //annotationView.addSubview(callout)
        //callout.center = CGPoint(x: annotationView.bounds.size.width / 2, y: -callout.bounds.size.height*0.52)

        closeDropMenu()
       
        
 
        
        
        if let view = sender?.view as? MKAnnotationView{
            
            
            
            let annotation = view.annotation as! CustomAnnotation
            let viewCustom = sender?.view as? AnnotationView
            

            let index = (annotation.storeIndex)
            print("===")
            print("===")
            print("===")
            print("===SENDER: \(index!)")


            print("===calloutIsShowing \(calloutIsShowing)")
            print("===calloutShowing \(calloutShowing)")
            
            if calloutIsShowing {
                if callout.frame.intersects(view.frame) {
                    return
                }
//                let pt = sender?.location(in: mapView)
//                 print("===+tap point \(pt)")
//                print("===+callout bounds: \(callout.frame)")
//                if callout.frame.contains(pt!) {
//                     return
//                 }
                
                if index == calloutShowing {
                    UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                        self.callout.isHidden = true
                        self.triView.isHidden = true
                    })
                    calloutIsShowing = false
                    calloutShowing = -1
                    
                    //callout.removeFromSuperview()
                    //viewCustom?.frame = CGRect(x: 0,y: 0,width: 87,height: 87)
                    //annotationView.constraints.forEach{
                    //    annotationView.removeConstraint($0)
                   // }
                    
                    
                    Static.shared.calloutIsShowing = false
                }
                else {
                    DispatchQueue.main.async {
                        /*
                        if annotation.chainName == "Target" {
                            self.logoView.image = #imageLiteral(resourceName: "target-logo-png-6-transparent")
                            view.transform = CGAffineTransform(scaleX: 0, y: 0)
                            view.transform = CGAffineTransform(scaleX: 8, y: 8)
                        }
                        else if annotation.chainName == "Walmart" {
                            self.logoView.image = #imageLiteral(resourceName: "Walmart_logo_transparent_png")
                            view.transform = CGAffineTransform(scaleX: 0, y: 0)
                            self.logoView.transform = CGAffineTransform(scaleX: 5, y: 5)
                        }
 */
                        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.configureCallout(for: view)
                        self.configureCalloutContents(store: self.stores[index!])
                        self.callout.isHidden = false
                        self.triView.isHidden = false
                        self.calloutIsShowing = true
                        self.calloutShowing = index!
                        })
                        
                        if view.center.y <= self.view.frame.height*(1-(8.25/13)) {
                            UIView.animate(withDuration: 0.7, animations: {
                                self.mapView.setCenter(annotation.coordinate, animated: true)
                            } )
                        
                        }
        
                        Static.shared.calloutIsShowing = true
                        //self.mapView.showAnnotations([view.annotation!], animated: true)
                        //self.mapView.isUserInteractionEnabled = false
                    }
                }
            }
            else {
                DispatchQueue.main.async {
                        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        self.configureCallout(for: view)
                        self.configureCalloutContents(store: self.stores[index!])
                        self.callout.isHidden = false
                        self.triView.isHidden = false
                        self.calloutIsShowing = true
                        self.calloutShowing = index!
                    })
                         if view.center.y <= self.view.frame.height*(1-(8.25/13)) {
                            UIView.animate(withDuration: 0.7, animations: {
                            self.mapView.setCenter(annotation.coordinate, animated: true)
                        } )
                    
                    }
    
                    Static.shared.calloutIsShowing = true
                    //self.mapView.showAnnotations([view.annotation!], animated: true)
                    //self.mapView.isUserInteractionEnabled = false
                }
            }
            
            
            
        }
        

        
        
    }
    
    
    
    @objc func handleCenterOnUser() {
        centerMapOnUser()
        DispatchQueue.main.async {
            self.callout.isHidden = true
            self.triView.isHidden = true
            self.calloutIsShowing = false
            self.calloutShowing = -1
        }
    }
    

    
    
    // MARK: - API
    

    

    
    func authenticateUserAndConfigureView() {
        //Check if trying to change password
        print("+++++\(UserDefaults.standard.bool(forKey: "tappedForgotPassword"))")
        if UserDefaults.standard.bool(forKey: "tappedForgotPassword") {
            navigationController?.pushViewController(ForgotPasswordController(), animated: true)
            return
        }
            
        let isRegistered = UserDefaults.standard.bool(forKey: "isRegistered")
        if isRegistered {
            //Authenticate user
            print("=========================registered=========================")

            DispatchQueue.global(qos: .userInitiated).async {

                UserAuth.shared.loginToServer{ (result) in
                    switch result{
                        case .success(let message):
                            let firstChar = message.first
                            if firstChar == "#" {
                                //Failed to register user
                                print("MESSAGE: \(message)")
                                DispatchQueue.main.async {
                                self.navigationController?.pushViewController(LoginController(), animated: true)
                                }
                            }
                            else if firstChar == "T" {
                                UserDefaults.standard.set(true, forKey: "isGold")
                                
                            } else if firstChar == "F" {
                                UserDefaults.standard.set(false, forKey: "isGold")
                            }
                           
                            print("===== ADS Enabled?: \(Ads.shared.adsEnabled)")
                      
                            //Logged in user
                            Gold.shared.updatePrivileges()
                            
                            if !UserDefaults.standard.bool(forKey: "isGold") {
                                DispatchQueue.main.async {
                                    if !self.showGoldPopup() {
                                        self.showInterstitial()
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
        } else {
            //Show register page
            print("unregistered")
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(RegisterController(), animated: true)
            }
        }
    }
        
        
        

    
    // MARK: - Helper Functions
    func configureWaitingForScrape2() {
        
        view.addSubview(blur)
        blur.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        
        view.addSubview(newScrape)
        newScrape.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width-30, height: 300)
        newScrape.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newScrape.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        

        newScrape.text.text = "You're the first user in \(UpdateUser.shared.zip)! This ZIP code is not currently supported, would you like to add it to our servers? We'll email you when the data's available."
        
        
        view.addSubview(addZip)
        addZip.anchor(top: newScrape.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width-30, height: 45)
        addZip.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(cancel)
        cancel.anchor(top: addZip.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width-30, height: 45)
        cancel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        newScrape.transform = CGAffineTransform(scaleX: 0, y: 0)
        addZip.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(scaleX: 0, y: 0))
        cancel.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(scaleX: 0, y: 0))
        
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.newScrape.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.addZip.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(scaleX: 1, y: 1))
            self.cancel.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(scaleX: 1, y: 1))
            self.blur.alpha = 1
        }, completion: nil)
        
        
        
    }
    
    func configureWaitingForScrape() {
        
        view.addSubview(blur)
        blur.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        
        view.addSubview(newScrape)
        newScrape.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width-30, height: 300)
        newScrape.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        newScrape.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        newScrape.text.text = "You’re the first user in \(UpdateUser.shared.zip)! This ZIP code is not currently supported but we’re working hard to provide you reliable data quickly. We'll email you when the data's available."
        
        
        view.addSubview(go2)
        go2.anchor(top: newScrape.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width-30, height: 45)
        go2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        
        newScrape.transform = CGAffineTransform(scaleX: 0, y: 0)
        go2.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(scaleX: 0, y: 0))
        
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.newScrape.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.go2.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(scaleX: 1, y: 1))
            self.blur.alpha = 1
        }, completion: nil)
        
        
        
    }
    
    func configureThemePopup() {
        view.addSubview(blur)
        blur.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        
        view.addSubview(themePopup)
        themePopup.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 200)
        themePopup.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        themePopup.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        view.addSubview(go)
        go.anchor(top: themePopup.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 300, height: 45)
        go.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        themePopup.transform = CGAffineTransform(scaleX: 0, y: 0)
        go.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(scaleX: 0, y: 0))
        
        UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0, options: .curveEaseOut, animations: {
            self.themePopup.transform = CGAffineTransform(scaleX: 1, y: 1)
            self.go.layer.transform = CATransform3DMakeAffineTransform(CGAffineTransform(scaleX: 1, y: 1))
            self.blur.alpha = 1
        }, completion: nil)
        
    }
    
    func configureColorScheme() {
        var overriden = false
        
        print("++ Entering color scheme with \(UserDefaults.standard.integer(forKey: "colorScheme"))")
        
        let mapType = UserDefaults.standard.integer(forKey: "mapType")
            switch mapType {
            case 0:
                mapView.mapType = .standard
//                centerMapBtn.setImage( UIImage(systemName: "location.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
//                centerMapBtn.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//                centerMapBtn.tintColor = .black
                  break
            case 1:
                mapView.mapType = .hybridFlyover
                
                centerMapBtn.setImage(#imageLiteral(resourceName: "centerMapBtnGold").withRenderingMode(.alwaysOriginal), for: .normal)
                centerMapBtn.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                StatusBarColor.shared.isDark = false
                
                menuBtn.setImage(#imageLiteral(resourceName: "menu-1").withRenderingMode(.alwaysOriginal), for: .normal)
                
                
                overriden = true
            case 2:
                mapView.mapType = .satelliteFlyover
                
                centerMapBtn.setImage(#imageLiteral(resourceName: "centerMapBtnGold").withRenderingMode(.alwaysOriginal), for: .normal)
                centerMapBtn.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                StatusBarColor.shared.isDark = false
                
                menuBtn.setImage(#imageLiteral(resourceName: "menu-1").withRenderingMode(.alwaysOriginal), for: .normal)
                
                overriden = true
            default:
                mapView.mapType = .standard
//                centerMapBtn.setImage( UIImage(systemName: "location.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
//                centerMapBtn.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
//                centerMapBtn.tintColor = .black
                  break
            }
        
        UIView.animate(withDuration: 0.5, animations: {
             self.setNeedsStatusBarAppearanceUpdate()
        })
        
        let mapStyle = UserDefaults.standard.string(forKey: "mapStyle")
        if mapStyle != nil {
            //MapStle overrided in settings
            
            
            switch mapStyle {
            case "D":
                self.overrideUserInterfaceStyle = .dark
                if !overriden {
                    StatusBarColor.shared.isDark = false
                   
                    centerMapBtn.setImage(#imageLiteral(resourceName: "centerMapBtnGold").withRenderingMode(.alwaysOriginal), for: .normal)
                    centerMapBtn.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    StatusBarColor.shared.isDark = false
                    
                    menuBtn.setImage(#imageLiteral(resourceName: "menu-1").withRenderingMode(.alwaysOriginal), for: .normal)
                }

            case "L":
                self.overrideUserInterfaceStyle = .light
                if !overriden {
                    StatusBarColor.shared.isDark = true
        
                    centerMapBtn.setImage( UIImage(systemName: "location.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    centerMapBtn.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                    centerMapBtn.tintColor = .black
                    
                    menuBtn.setImage(#imageLiteral(resourceName: "menuNoStroke").withRenderingMode(.alwaysOriginal), for: .normal)
                }
            default:
                self.overrideUserInterfaceStyle = .dark
                if !overriden {
                    StatusBarColor.shared.isDark = false
                   
                    centerMapBtn.setImage(#imageLiteral(resourceName: "centerMapBtnGold").withRenderingMode(.alwaysOriginal), for: .normal)
                    centerMapBtn.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    StatusBarColor.shared.isDark = false
                    
                    menuBtn.setImage(#imageLiteral(resourceName: "menu-1").withRenderingMode(.alwaysOriginal), for: .normal)
                }
            }
            
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
        } else {
            //MapStyle matches color scheme (not overriden)
            let colorScheme = UserDefaults.standard.integer(forKey: "colorScheme")
            switch colorScheme{
            case 0:
                self.overrideUserInterfaceStyle = .dark
                if !overriden {
                    StatusBarColor.shared.isDark = false
                    
                    centerMapBtn.setImage(#imageLiteral(resourceName: "centerMapBtnGold").withRenderingMode(.alwaysOriginal), for: .normal)
                    centerMapBtn.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                    StatusBarColor.shared.isDark = false
                    
                    menuBtn.setImage(#imageLiteral(resourceName: "menu-1").withRenderingMode(.alwaysOriginal), for: .normal)
           
                }
             
                
                
            case 1:
                self.overrideUserInterfaceStyle = .dark
                     if !overriden {
                         StatusBarColor.shared.isDark = false
                         
                         centerMapBtn.setImage(#imageLiteral(resourceName: "centerMapBtnGold").withRenderingMode(.alwaysOriginal), for: .normal)
                         centerMapBtn.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                         StatusBarColor.shared.isDark = false
                         
                         menuBtn.setImage(#imageLiteral(resourceName: "menu-1").withRenderingMode(.alwaysOriginal), for: .normal)
                
                     }
            case 2:
                self.overrideUserInterfaceStyle = .light
                     if !overriden {
                         StatusBarColor.shared.isDark = true
                         
                         centerMapBtn.setImage( UIImage(systemName: "location.fill")?.withRenderingMode(.alwaysTemplate), for: .normal)
                         centerMapBtn.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
                         centerMapBtn.tintColor = .black
                         
                         menuBtn.setImage(#imageLiteral(resourceName: "menuNoStroke").withRenderingMode(.alwaysOriginal), for: .normal)
                
                     }

            default:
                self.overrideUserInterfaceStyle = .dark
                     if !overriden {
                         StatusBarColor.shared.isDark = false
                         
                         centerMapBtn.setImage(#imageLiteral(resourceName: "centerMapBtnGold").withRenderingMode(.alwaysOriginal), for: .normal)
                         centerMapBtn.transform = CGAffineTransform(scaleX: 0.7, y: 0.7)
                         StatusBarColor.shared.isDark = false
                         
                         menuBtn.setImage(#imageLiteral(resourceName: "menu-1").withRenderingMode(.alwaysOriginal), for: .normal)
                
                     }
            }
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
        }
        
        let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
        
        if scheme == 0 {
            callout.backgroundColor = UIColor.white.withAlphaComponent(0.9)
            callout.layer.borderColor = UIColor.black.cgColor
            logoViewTarget.image = #imageLiteral(resourceName: "target-logo-png-6-transparent")
            logoViewTarget.transform = CGAffineTransform(scaleX: 8.5, y: 8.5)
            quantityLbl.textColor = .black
            distanceLbl.textColor = .black
        } else if scheme == 1 {
            callout.backgroundColor = UIColor.black.withAlphaComponent(0.9)
            callout.layer.borderColor = UIColor.white.cgColor
            logoViewTarget.image = #imageLiteral(resourceName: "targBlack")
            logoViewTarget.transform = CGAffineTransform(scaleX: 2, y: 2)
            quantityLbl.textColor = .white
            distanceLbl.textColor = .white
            
            
        } else {
            callout.backgroundColor = UIColor.white.withAlphaComponent(0.9)
            callout.layer.borderColor = UIColor.black.cgColor
            logoViewTarget.image = #imageLiteral(resourceName: "target-logo-png-6-transparent")
            logoViewTarget.transform = CGAffineTransform(scaleX: 8.5, y: 8.5)
            quantityLbl.textColor = .black
            distanceLbl.textColor = .black
            
        }
        
        

        
        
        
        
    }
    
    func showCountryNotSupported() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "Domain Error", message: "Oops, it looks like \(self.country) is not currently supported. We apologize for the inconvenience.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Understood", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func updateUserZip() {
    
        guard let exposedLocation = self.locationManager.location else {
            print("*** Error in \(#function): exposedLocation is nil")
            return
        }
        
        getPlace(for: exposedLocation) { placemark in
            guard let placemark = placemark else { return }
            

            if let country = placemark.country {
                if country != "United States" {
                    self.country = country
                    self.countryNotSupported = true
                    self.showCountryNotSupported()

                    return
                }
                
            }
            
            if let city = placemark.locality {
                print("+++\(city)")
                Notifications.shared.city = city.replacingOccurrences(of: " ", with: "_")
                
            }
            
            
            if let zip = placemark.postalCode {
                UpdateUser.shared.zip = Int(zip)!
                
                DispatchQueue.global(qos: .userInitiated).async {
                    if UserDefaults.standard.bool(forKey: "isRegistered") {
                        UpdateUser.shared.updateUserZip { (result) in
                            switch result {
                            case .success(let m):
                                print("+++\(zip)")
                                if m.first == "T" {
                                    self.zipNotSupported = true
                            
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
                
            }
            print("+++\(Notifications.shared.city)")
        }
    }

        


        


    
    
    
    func getPlace(for location: CLLocation,
                  completion: @escaping (CLPlacemark?) -> Void) {
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            
            guard error == nil else {
                print("*** Error in \(#function): \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("*** Error in \(#function): placemark is nil")
                completion(nil)
                return
            }
            
            completion(placemark)
        }
    }
    

    
    func addSupplyRegionNotification() {
        print("+++\(supplySearchedFor)")
        
        
        let date = Date()
        let calendar = Calendar.current
        let now = "\(calendar.component(.month, from: date))-\(calendar.component(.day, from: date))-\(calendar.component(.year, from: date)%1000)"
        
        
        spinner.isHidden = false
        DispatchQueue.global(qos: .userInitiated).async {
            Notifications.shared.supply = self.supplySearchedFor.replacingOccurrences(of: " ", with: "_")
            Notifications.shared.date = now
            Notifications.shared.addSupplyRegionNotification  { (result) in
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
                       
                            self.showMessage(label: lbl)
                            self.spinner.isHidden = true
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

                            self.showMessage(label: lbl)
                            self.spinner.isHidden = true
                        }
                    }
                case .failure(let error):
                    print("DEBUG: Failed with error \(error)")
                    DispatchQueue.main.async {
                        self.spinner.isHidden = true
                        self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                    }
                    
                }
                
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
        //lbl.adjustsFontSizeToFitWidth  = true
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
    
    
    func closeDropMenu(){
        if showingMenu {
            var indexPaths = [IndexPath]()
            
            for i in 0..<self.supplyList.count{
                let indexPath = IndexPath(row: i, section: 0)
                indexPaths.append(indexPath)
            }
            showingMenu = false
            whitePadding.isHidden = true

            
            self.tableView.deleteRows(at: indexPaths, with: .fade)
        }
    }
    
    
    
    func getTotalQuantity(of store: Int) {
        Stores.shared.storeID = store
        DispatchQueue.global(qos: .userInitiated).async {
            Stores.shared.fetchTotalQuantity { (result) in
                switch result {
                case .success(let sum):
                    DispatchQueue.main.async {
                        if sum == 0 {
                            self.quantityLbl.text = "Limited stock"
                        } else {
                            self.quantityLbl.text = "\(sum) in stock"
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
    
    

    
    
    func configureCalloutContents(store: store) {
        
        
        
        let userPt = MKMapPoint(self.locationManager.location!.coordinate)
        let storePt = MKMapPoint(CLLocationCoordinate2D(latitude: store.store__latitude, longitude:  store.store__longitude))
        distanceLbl.text = "\(ceil(userPt.distance(to: storePt)*0.000621*100)/100) miles away"
        
        
        (openStatusLbl.text, openStatusLbl.textColor) =   Functions.shared.calculateOpenStatus(store: store)
        
        
        getTotalQuantity(of: store.store__id)
    }
    
    
    func configureCallout(for view: MKAnnotationView) {
        
   
        let annotation =  view.annotation as! CustomAnnotation
        if annotation.chainName == "Target" {
            logoViewTarget.isHidden = false
            logoViewWalmart.isHidden = true
            logoViewCVS.isHidden = true
            callout.addSubview(logoViewTarget)
              logoViewTarget.anchor(top: callout.topAnchor, left: callout.leftAnchor, bottom: nil, right: callout.rightAnchor, paddingTop: 150, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 500, height: 100)
            
            
            callout.addSubview(openStatusLbl)
            openStatusLbl.alpha = 1
            
            openStatusLbl.anchor(top: logoViewTarget.bottomAnchor, left: callout.leftAnchor, bottom: nil, right: callout.rightAnchor, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 500, height: 100)
        }
        else if annotation.chainName == "Walmart" {
            
            logoViewWalmart.isHidden = false
            logoViewTarget.isHidden = true
            logoViewCVS.isHidden = true
            callout.addSubview(logoViewWalmart)
              logoViewWalmart.anchor(top: callout.topAnchor, left: callout.leftAnchor, bottom: nil, right: callout.rightAnchor, paddingTop: 150, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 500, height: 100)
            
            
            callout.addSubview(openStatusLbl)
            openStatusLbl.alpha = 1
            
            openStatusLbl.anchor(top: logoViewWalmart.bottomAnchor, left: callout.leftAnchor, bottom: nil, right: callout.rightAnchor, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 500, height: 100)
        }
  
        else if annotation.chainName == "CVS" {
            
            logoViewCVS.isHidden = false
            logoViewWalmart.isHidden = true
            logoViewTarget.isHidden = true
            callout.addSubview(logoViewCVS)
              logoViewCVS.anchor(top: callout.topAnchor, left: callout.leftAnchor, bottom: nil, right: callout.rightAnchor, paddingTop: 150, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 500, height: 100)
            
            
            callout.addSubview(openStatusLbl)
            openStatusLbl.alpha = 1
            
            openStatusLbl.anchor(top: logoViewCVS.bottomAnchor, left: callout.leftAnchor, bottom: nil, right: callout.rightAnchor, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 500, height: 100)
        }
            
            
            

            
            
            callout.addSubview(quantityLbl)
            quantityLbl.alpha = 1
            
            quantityLbl.anchor(top: openStatusLbl.bottomAnchor, left: callout.leftAnchor, bottom: nil, right: callout.rightAnchor, paddingTop: 80, paddingLeft: 0, paddingBottom: 0, paddingRight: 10, width: 500, height: 100)
        

            
            
            callout.addSubview(distanceLbl)
            distanceLbl.alpha = 1
            
            distanceLbl.anchor(top: quantityLbl.bottomAnchor, left: callout.leftAnchor, bottom: nil, right: callout.rightAnchor, paddingTop: 80, paddingLeft: 0, paddingBottom: 70, paddingRight: 10, width: 500, height: 100)
            
            
            callout.addSubview(self.getDirections)
            getDirections.anchor(top: distanceLbl.bottomAnchor, left: callout.leftAnchor , bottom: nil, right: callout.rightAnchor, paddingTop: 115, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 00, height: 0)
            
            
            callout.addSubview(rectView)
                 rectView.anchor(top: distanceLbl.bottomAnchor, left: callout.leftAnchor, bottom: nil, right: callout.rightAnchor, paddingTop: -15, paddingLeft: 100, paddingBottom: 0, paddingRight: 100, width: 300, height: 00)
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(redirect))
            rectView.addGestureRecognizer(tap)
            rectView.transform = CGAffineTransform(scaleX: 0.9, y: 0.5)
            rectView.frame = CGRect(x: 0, y: 0, width: callout.frame.width, height: callout.frame.height*2.0)
            
            callout.addSubview(viewItems)
             viewItems.anchor(top: getDirections.bottomAnchor, left: callout.leftAnchor , bottom: nil, right: callout.rightAnchor, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 00, height: 0)
             
             
             callout.addSubview(rectView2)
            rectView2.anchor(top: getDirections.bottomAnchor, left: callout.leftAnchor, bottom: nil, right: callout.rightAnchor, paddingTop: -30, paddingLeft: 100, paddingBottom: 0, paddingRight: 100, width: 300, height: 00)
             
             let tap2 = UITapGestureRecognizer(target: self, action: #selector(showItems))
             rectView2.addGestureRecognizer(tap2)
             rectView2.transform = CGAffineTransform(scaleX: 0.9, y: 0.5)
             rectView2.frame = CGRect(x: 0, y: 0, width: callout.frame.width, height: callout.frame.height*2.0)
        
        view.addSubview(self.callout)
       
        self.callout.anchor(top: nil, left: nil, bottom: view.topAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 115, paddingRight: 0, width: 1200, height: 0)
         
         self.callout.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         self.callout.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -1050).isActive = true
         self.callout.heightAnchor.constraint(equalToConstant: 0).isActive = true
        // self.callout.widthAnchor.constraint(equalToConstant: 1500).isActive = true
         
         //let tri = self.t?.rotate(radians: .pi)
         self.triView.image = self.t
         
         view.addSubview(self.triView)

         self.triView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
         self.triView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -245).isActive = true
         self.triView.heightAnchor.constraint(equalToConstant: 80).isActive = true
         self.triView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
      
       // mapView.addSubview(getDirections)
        //getDirections.transform = CGAffineTransform(scaleX: 0, y: 4)
 
        
 
         
    }
        
        
    func configureCallout() {
        
        

        
    }
    
    
    func displayStoresOnMap() {
        
        mapView.removeAnnotations(mapView.annotations)
        DispatchQueue.main.async {
            for i in 0..<self.stores.count {
                //print(store)
                let storeAnnotation = CustomAnnotation(coordinate: CLLocationCoordinate2D(latitude: self.stores[i].store__latitude, longitude: self.stores[i].store__longitude))
                storeAnnotation.storeIndex = i
                storeAnnotation.chainName = self.stores[i].store__chainName
                
                //storeAnnotation.image
                self.mapView.addAnnotation(storeAnnotation)

        }
            if self.stores.count > 0 {
                self.centerMapOnStores()
            }
        }
    }
    
    @objc func handleDropDown() {
        showingMenu.toggle()
        
        if showingMenu{
            
            DispatchQueue.main.async {
                var indexPaths = [IndexPath]()
                
                for i in 0..<self.supplyList.count{
                    let indexPath = IndexPath(row: i, section: 0)
                    indexPaths.append(indexPath)
                }
                
                self.tableView.invalidateIntrinsicContentSize()
                self.tableView.insertRows(at: indexPaths, with: .fade)
                self.whitePadding.isHidden = false
            }
            
            
            
            
            
            
            
        } else {
            DispatchQueue.main.async {
                var indexPaths = [IndexPath]()
                
                for i in 0..<self.supplyList.count{
                    let indexPath = IndexPath(row: i, section: 0)
                    indexPaths.append(indexPath)
                }
                
                
                self.tableView.invalidateIntrinsicContentSize()
                self.tableView.deleteRows(at: indexPaths, with: .fade)
                self.whitePadding.isHidden = true
            }
            
            
            
            
            
        }

          
              
        
        
        
        
        
        
        
        
//        showingMenu.toggle()
//
//        if showingMenu{
//            DispatchQueue.global(qos: .userInitiated).async {
//                supplyOptions.shared.fetchOptions { (result) in
//                    switch result {
//                        case .success(let options):
//                            DispatchQueue.main.async {
//                                print(options)
//                                self.supplies = options
//                                var indexPaths = [IndexPath]()
//
//                                for i in 0..<self.supplies.count{
//                                    let indexPath = IndexPath(row: i, section: 0)
//                                    indexPaths.append(indexPath)
//                                }
//
//                                print(indexPaths)
//                                print("\(self.supplies.count)")
//
//
//                                self.tableView.invalidateIntrinsicContentSize()
//                                self.tableView.insertRows(at: indexPaths, with: .fade)
//                                self.whitePadding.isHidden = false
//
//
//
//
//
//
//                        }
//                        case .failure(let error):
//                            print("DEBUG: Failed with error \(error)")
//                    }
//                }
//            }
//        } else {
//            var indexPaths = [IndexPath]()
//
//            for i in 0..<self.supplies.count{
//                let indexPath = IndexPath(row: i, section: 0)
//                indexPaths.append(indexPath)
//            }
//
//
//            self.tableView.invalidateIntrinsicContentSize()
//            self.tableView.deleteRows(at: indexPaths, with: .fade)
//            self.whitePadding.isHidden = true
//
//
//
//
//        }
//
//
//
                

    }
    
    
    

    func configureMenuTableView() {
        

        menuTableView.delegate = self
        menuTableView.dataSource = self
        menuTableView.translatesAutoresizingMaskIntoConstraints = false
        menuTableView.separatorStyle = .none
        menuTableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        menuTableView.separatorColor = Color.shared.theme
        menuTableView.isScrollEnabled = true
        menuTableView.alwaysBounceVertical = true
        menuTableView.showsVerticalScrollIndicator = false
        menuTableView.rowHeight = 50
        menuTableView.backgroundColor = .green   //Dark mode

        menuTableView.register(MenuCell.self, forCellReuseIdentifier: "MenuCell")
    
        
    }
    
    
    
    
    func configureTableView() {
        tableView = TableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        tableView.separatorColor = Color.shared.theme
        tableView.isScrollEnabled = true
        tableView.showsVerticalScrollIndicator = true
        tableView.rowHeight = 40
        tableView.backgroundColor = .clear
       
        
        
        
        
        tableView.register(supplyCell.self, forCellReuseIdentifier: "supplyCell")
        
        view.addSubview(tableView)
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44).isActive = true
        //tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.bounds.width/2).isActive = true
        //tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        //tableView.heightAnchor.constraint(lessThanOrEqualToConstant: 280).isActive = true
        //tableView.heightAnchor.constraint(equalToConstant: 280).isActive = true
        tableView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 44).isActive = true
        
        
    }
    
 
    
    
    
    func configureMenu() {
        view.addSubview(menuBtn)

        //menuBtn.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        menuBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 56).isActive = true
        menuBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32).isActive = true
        menuBtn.heightAnchor.constraint(equalToConstant: 32).isActive = true
        menuBtn.widthAnchor.constraint(equalToConstant: 32).isActive = true

        view.bringSubviewToFront(menuBtn)

        
        
        
    }
    
    
    func centerMapOnStores() {
        
        mapView.showAnnotations(mapView.annotations, animated: true)
        
    }
    
    
    func centerMapOnUser() {
        print("???Center map on user")

        if let coordinates = self.locationManager.location?.coordinate {
            Location.shared.coordinates = coordinates
        }
        else { return }
           print("???GOT LOCATION")
        initialNeedsCentering = false
        let region = MKCoordinateRegion(center: Location.shared.coordinates, latitudinalMeters: 2000, longitudinalMeters: 2000)
        self.mapView.setRegion(region, animated: true)
    
    }
    
    func initialCenterMapOnUser() {
        print("???Initial center map on user")
        

        if let coordinates = self.locationManager.location?.coordinate {
            Location.shared.coordinates = coordinates
        }
        else { return }
           print("???GOT initial LOCATION")
        
        initialNeedsCentering = false
        
        if isSearching { return }
        let region = MKCoordinateRegion(center: Location.shared.coordinates, latitudinalMeters: 2000, longitudinalMeters: 2000)
        self.mapView.setRegion(region, animated: true)
    
    }
    
    func configureMapView() {
        mapView = MKMapView()
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.delegate = self
        mapView.layoutMargins = UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50)
        
        
        
        
        view.addSubview(mapView)
        mapView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)

        
    
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleMapTap(_:)))
        mapView.addGestureRecognizer(tap)
        

        view.addSubview(centerMapBtn)
        

        //centerMapBtn.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 500, height: 100)
        
        centerMapBtn.topAnchor.constraint(equalTo: view.topAnchor, constant: 52).isActive = true
        centerMapBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -25).isActive = true
        centerMapBtn.heightAnchor.constraint(equalToConstant: 40).isActive = true
        centerMapBtn.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        centerMapBtn.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        //centerMapBtn.layer.cornerRadius = 50 / 2
        centerMapBtn.alpha = 0
        
        
        centerMapBtn.fadeIn()
        
        
        

 

    }
    
    
    func configureLocationManager(){
        locationManager = CLLocationManager()
        locationManager.delegate  = self
    }
    
    func configureViewComponents() {
        view.backgroundColor = .black
        

        
        
        centerMapBtn.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        
        configureMapView()
        //configureLocationManager()
        configureTableView()
        configureCallout()

        
        
        view.addSubview(whitePadding)
        
       //whitePadding.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 100, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        whitePadding.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        whitePadding.anchor(top: view.topAnchor, left: nil , bottom: nil, right: nil, paddingTop: 50, paddingLeft: 00, paddingBottom: 0, paddingRight: 000, width: 150, height: 342)
        whitePadding.isHidden = true
       
        view.bringSubviewToFront(tableView)
        
        view.addSubview(spinner)

        self.spinner.anchor(top: tableView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 9.7, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 35, height: 35)
        self.spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        

        
        
        
    }
    
    
    
}


extension HomeController: CLLocationManagerDelegate {
    func enableLocationServices() {
        print("???Enable location services, status: \(CLLocationManager.authorizationStatus())")
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            print("Location auth status is NOT DETERMINED")
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            print("Location auth status is RESTRICTED")
            locationEnabled = true
        case .denied:
            print("Location auth status is DENIED")
            locationManager.requestWhenInUseAuthorization()
            locationEnabled = false
        case .authorizedAlways:
            print("Location auth status is AUTHORIZED ALWAYS")
            locationEnabled = true
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        case .authorizedWhenInUse:
            print("Location auth status is AUTHORIZED WHEN IN USE")
            locationEnabled = true
            locationManager.startUpdatingLocation()
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
        @unknown default:
            print("Location auth status UNKOWN")
            fatalError()
            
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("???Entered did update location")
        //centerMapOnUser()
    }
    

    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("???Entered did change Auth, status: \(status == .denied)")
        //centerMapOnUser()
        if status == .notDetermined {
            initialNeedsCentering = true
        }
        if status == .denied || status == .restricted  {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Location Services Disabled", message: "To enable, go to Settings -> Privacy -> Location Services -> Find My Supply", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            authorized = false
            locationEnabled = false
            initialNeedsCentering = true
            
        }
        else {
            locationEnabled = true
            if !isSearching && initialNeedsCentering{
                print("??? first launch \(UserDefaults.standard.bool(forKey: "firstLaunch"))")
                if UserDefaults.standard.bool(forKey: "firstLaunch") {
                    configureThemePopup()
                    UserDefaults.standard.set(false, forKey: "firstLaunch")
                    
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if !self.isSearching && self.initialNeedsCentering {
                        self.initialCenterMapOnUser()
                    }
            }
                
                DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 2) {
                    self.updateUserZip()
                }
            }
        
            
        }
    }
    
    
    
 
    
    
}
    










extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let button = UIButton(type: .system)
        button.setTitle("Find your supply", for: .normal)
        button.setTitleColor(Color.shared.gold, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.addTarget(self, action: #selector(handleDropDown), for: .touchUpInside)
        button.backgroundColor = Color.shared.theme
        button.alpha = 1
        button.layer.cornerRadius = 20
        button.layer.borderWidth = 3
        //button.layer.shadowColor = .init(srgbRed: 7/255, green: 3/255, blue: 252/255, alpha: 1)
        //button.layer.shadowRadius = 10
        //button.layer.shadowOpacity = 0.1
        //button.layer.shadowOffset = CGSize(width: 10, height: 10)
        button.layer.borderColor =   Color.shared.gold.cgColor   //UIColor.white.cgColor
        
        
        
        
        
        return button
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(supplies.count)
        return showingMenu ? supplyList.count : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "supplyCell", for: indexPath) as! supplyCell
        cell.selectionStyle = .none
        cell.supply.text = supplyList[indexPath.row]//supplies[indexPath.row].supplyName
        cell.supply.textColor = Color.shared.theme
        //cell.supply.layer.frame = CGRect(x: 0,y: 0, width: 100,height: 100)
        cell.supply.layer.cornerRadius = 10


        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       // print(supplies[indexPath.row].supplyName)
        
        
        mapView.removeAnnotations(mapView.annotations)
        
        if !locationEnabled {
            DispatchQueue.main.async {
            let alert = UIAlertController(title: "Location Services Disabled", message: "To enable, go to Settings -> Privacy -> Location Services -> Find My Supply", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            }
        }
        
        isSearching = true
        
        supplySearchedFor = supplyList[indexPath.row].replacingOccurrences(of: " ", with: "_")
        DispatchQueue.main.async {
            self.callout.isHidden = true
            self.triView.isHidden = true
            self.calloutIsShowing = false
            self.calloutShowing = -1
            
            if self.zipNotSupported {
                self.configureWaitingForScrape2()
                
            }
            
            
            
            
            
        }
        
        
        
        if let coordinates = locationManager.location?.coordinate  {
            Location.shared.coordinates = coordinates
            
        }
        else { return }
        
        
        Stores.shared.initialize(withSupply: supplyList[indexPath.row].replacingOccurrences(of: " ", with: "_"), withCoor: Location.shared.coordinates)
        print("===================================START========================================")

        self.spinner.isHidden = false
        DispatchQueue.global(qos: .userInitiated).async {
            Stores.shared.fetchStoresWithSupply { (result) in
                switch result {
                    case .success(let stores):
                        if stores.count == 0{
                            print("No stores found :(")
                               DispatchQueue.main.async {
                                    let lbl = UILabel()
                                    lbl.backgroundColor = UIColor.rgb(red: 209, green: 21, blue: 0)
                                    lbl.textColor = .white
                                    lbl.text = "No stores nearby currently have \(self.supplyList[indexPath.row]) in stock."
                                    lbl.font = UIFont.italicSystemFont(ofSize: 15.0)
                                    //lbl.sizeToFit()
                                    lbl.textAlignment = .center
                                    lbl.numberOfLines = 0
                                    //lbl.adjustsFontSizeToFitWidth  = true
                                    lbl.layer.cornerRadius = 10

                                self.showMessage(label: lbl)
                                self.spinner.isHidden = true
                                
                                self.notifBtn.transform = CGAffineTransform(scaleX: 0, y: 0)
                                UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                              
                                    self.view.addSubview(self.notifBtn)
                                    self.notifBtn.anchor(top: tableView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 30, height: 30)
                                    self.notifBtn.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
                                    
                                    self.notifBtn.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
                                }, completion: { _ in
                                    UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                                        self.notifBtn.transform = CGAffineTransform(scaleX: 1, y: 1)
                                    }, completion: nil)
                                })

                                }
                         
                            
                        } else {
                        DispatchQueue.main.async {
                            //print(stores[0].store__chainName)
                            self.notifBtn.removeFromSuperview()
                            self.stores = stores
                            self.displayStoresOnMap()
                            self.spinner.isHidden = true
                            self.stillLoading = false
                        }
                    }
                        
                    case .failure(let error):
                        print("DEBUG: Failed with error \(error)")
                        DispatchQueue.main.async {
                            self.spinner.isHidden = true
                            self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                        }
                
            
                }
            }
        }
        print("\(Location.shared.coordinates.latitude)")
        handleDropDown()
        
        
    }
}
    
    
    
    
    

 
 


extension HomeController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        print("???viewForAnnotation")
      
        let annotationView = AnnotationView(annotation: annotation, reuseIdentifier: "AnnotationView")
        
        
        if annotation === mapView.userLocation {
            let transform = CGAffineTransform(scaleX: 0.3, y: 0.3)
            annotationView.transform = transform
            annotationView.image = #imageLiteral(resourceName: "userLocGold")
        
//            if authorized {
//                centerMapOnUser()
//                authorized = false
//            }
        }
        else {
        
        
        let transform = CGAffineTransform(scaleX: 0.13, y: 0.13)
        annotationView.transform = transform
        
         let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
         annotationView.addGestureRecognizer(tap)


        print("++++ \(supplySearchedFor)")
        switch supplySearchedFor! {
        case "Face_Masks":
            annotationView.image = #imageLiteral(resourceName: "maskAnn")
        case "Gloves":
            annotationView.image = #imageLiteral(resourceName: "glovesAnn-1")
        case "Hand_Sanitizer":
            annotationView.image = #imageLiteral(resourceName: "sanitAnn")
        case "Soap":
            annotationView.image = #imageLiteral(resourceName: "soapAn")
        case "Toilet_Paper":
            annotationView.image = #imageLiteral(resourceName: "redTPPin")
        case "Disinfectant_Wipes":
            annotationView.image = #imageLiteral(resourceName: "wipesAnn")
        case "Disinfectant_Spray":
            annotationView.image = #imageLiteral(resourceName: "sprayAnn")
        default:
            annotationView.image = #imageLiteral(resourceName: "black user loc")
            
            }

 
        annotationView.canShowCallout = false
        
      
 
        annotationView.centerOffset = CGPoint(x: 0, y: ((annotationView.center.y)) - 22)

            mapView.bringSubviewToFront(annotationView)
     
        }
        return annotationView
  
    }
    
    
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        print("=====The annotation was selected: \(String(describing: view.annotation?.title))")

       

    }
}



extension HomeController: GADInterstitialDelegate {
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("======AD dismissed")
        showGoldPopup()
    }
}
