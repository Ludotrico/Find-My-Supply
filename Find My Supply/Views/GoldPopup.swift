//
//  GoldController.swift
//  Find My Supply
//
//  Created by Ludovico Veniani on 5/2/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class GoldPopup: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.definesPresentationContext = true
     
        
        configureViewComponents()
        Gold.shared.getProducts()
        
        bringCancelToFront()

        // Do any additional setup after loading the view.
    }
       override func viewWillDisappear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = true
            viewIsDead = true
        
            configureNextColorScheme()
       }
    func configureNextColorScheme() {
        
        let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
        
        if fromStoreController {
            
            if scheme == 0 {
                //STANDARD

                StatusBarColor.shared.isDark = true
                UIView.animate(withDuration: 0.5, animations: {
                     self.setNeedsStatusBarAppearanceUpdate()
                })

            }
            else if scheme == 1 {
                //DARK

                StatusBarColor.shared.isDark = false
                UIView.animate(withDuration: 0.5, animations: {
                     self.setNeedsStatusBarAppearanceUpdate()
                })
            }
            else {
                //LIGHT

                StatusBarColor.shared.isDark = true
                UIView.animate(withDuration: 0.5, animations: {
                     self.setNeedsStatusBarAppearanceUpdate()
                })

            }
        } else {
                    var overriden = false
                    
                    
                    let mapType = UserDefaults.standard.integer(forKey: "mapType")
                        switch mapType {
                        case 0:
                              break
                        case 1:
                            StatusBarColor.shared.isDark = false
                            overriden = true
                        case 2:
                            StatusBarColor.shared.isDark = false
                            overriden = true
                        default:
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
                            }

                        case "L":
                            self.overrideUserInterfaceStyle = .light
                            if !overriden {
                                StatusBarColor.shared.isDark = true
                            }
                        default:
                            self.overrideUserInterfaceStyle = .dark
                            if !overriden {
                                StatusBarColor.shared.isDark = false
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
                       
                            }

                        case 1:
                            self.overrideUserInterfaceStyle = .dark
                                 if !overriden {
                                     StatusBarColor.shared.isDark = false
                            
                                 }
                        case 2:
                            self.overrideUserInterfaceStyle = .light
                                 if !overriden {
                                     StatusBarColor.shared.isDark = true
                            
                                 }

                        default:
                            self.overrideUserInterfaceStyle = .dark
                                 if !overriden {
                                     StatusBarColor.shared.isDark = false

                            
                                 }
                        }
                        UIView.animate(withDuration: 0.5, animations: {
                             self.setNeedsStatusBarAppearanceUpdate()
                        })
                        
                    }
                    

                    
                    

            
            
        }
        
        
        
        
    }
           
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.navigationBar.isHidden = false

       }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        swipeInfoViews()
        
    }
    
    //MARK: VIEWS
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        return view
    }()
    
    let Dscroll = DScrollView()
    let scrollViewContainer = DScrollViewContainer(axis: .vertical, spacing: 0)
    
    let goldItem: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "medallionTP").withRenderingMode(.alwaysTemplate)
        view.contentMode = .scaleAspectFit
        view.sizeToFit()
        view.widthAnchor.constraint(equalToConstant: 30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 30).isActive = true
        return view

    }()
    
    let invisibleRect: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let titleLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "Go Gold"
        lbl.font = UIFont(name: "BrandonGrotesque-Black", size: 28)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 1
        lbl.sizeToFit()
        lbl.translatesAutoresizingMaskIntoConstraints = false
//        lbl.layer.cornerRadius = 10
//        lbl.layer.masksToBounds = true
//        lbl.textAlignment = .center
//        lbl.backgroundColor = UIColor(white: 1, alpha: 0.7)
//        lbl.layer.shadowOpacity = 1
//        lbl.layer.shadowRadius = 5
    
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
    
    let info1Gradient: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "goldGradient").withRenderingMode(.alwaysOriginal)
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.sizeToFit()
        return view
    }()

    
    let info1Img: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "notfi+")
        view.contentMode = .scaleAspectFit
//        view.layer.shadowRadius = 10
//        view.layer.shadowOpacity = 1
        
        return view
    }()
    
    let info1Stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.clipsToBounds = true
        stack.sizeToFit()
        //stack.spacing = 5
        stack.addBackground(color: UIColor.gray.withAlphaComponent(0.3), cornerRadius: 15)
        return stack
    }()
    
        let info1Title: UILabel = {
            let lbl = UILabel()
            lbl.text = "Get There First"
            lbl.font = UIFont(name: "BrandonGrotesque-Black", size: 35)
            lbl.textColor = .white //Dark mode
            lbl.numberOfLines = 1
            lbl.sizeToFit()
            lbl.adjustsFontSizeToFitWidth = true
            lbl.textAlignment = .center
            lbl.sizeToFit()
            lbl.translatesAutoresizingMaskIntoConstraints = false

        
            return lbl
            
        }()
    
    let info1Text: UILabel = {
        let lbl = UILabel()
        lbl.text = "Push-notifications to notify you when supplies you need get re-stocked"
        lbl.font = UIFont(name: "BrandonGrotesque-Light", size: 20)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false

    
        return lbl
        
    }()
    
    
    let info2Gradient: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "goTealGradient").withRenderingMode(.alwaysOriginal)
        view.contentMode = .scaleToFill
        view.clipsToBounds = true
        view.sizeToFit()
        return view
    }()
    
        let info2Img: UIImageView = {
            let view = UIImageView()
            view.image = #imageLiteral(resourceName: "ads")
            view.contentMode = .scaleAspectFit
    //        view.layer.shadowRadius = 10
    //        view.layer.shadowOpacity = 1
            
            return view
        }()
    
    let info2Stack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .equalCentering
        stack.alignment = .center
        stack.clipsToBounds = true
        stack.sizeToFit()
        //stack.spacing = 5
        stack.addBackground(color: UIColor.gray.withAlphaComponent(0.3), cornerRadius: 15)
        return stack
    }()
    
        let info2Title: UILabel = {
            let lbl = UILabel()
            lbl.text = "Terminate Ads"
            lbl.font = UIFont(name: "BrandonGrotesque-Black", size: 35)
            lbl.textColor = .white //Dark mode
            lbl.numberOfLines = 1
            lbl.adjustsFontSizeToFitWidth = true
            lbl.sizeToFit()
            lbl.translatesAutoresizingMaskIntoConstraints = false

        
            return lbl
            
        }()
    
    let info2Text: UILabel = {
        let lbl = UILabel()
        lbl.text = "Enjoy the complete ad-free experience"
        lbl.font = UIFont(name: "BrandonGrotesque-Light", size: 20)
        lbl.textColor = .white //Dark mode
        lbl.numberOfLines = 0
        lbl.sizeToFit()
        lbl.adjustsFontSizeToFitWidth = true
        lbl.textAlignment = .center
        lbl.translatesAutoresizingMaskIntoConstraints = false

    
        return lbl
        
    }()
    
    
      let info3Gradient: UIImageView = {
          let view = UIImageView()
          view.image = #imageLiteral(resourceName: "greenGradient").withRenderingMode(.alwaysOriginal)
          view.contentMode = .scaleToFill
          view.clipsToBounds = true
          view.sizeToFit()
          return view
      }()
      
          let info3Img: UIImageView = {
              let view = UIImageView()
              view.image = #imageLiteral(resourceName: "customerSupport")
              view.contentMode = .scaleAspectFit
      //        view.layer.shadowRadius = 10
      //        view.layer.shadowOpacity = 1
              
              return view
          }()
      
      let info3Stack: UIStackView = {
          let stack = UIStackView()
          stack.axis = .vertical
          stack.distribution = .equalCentering
          stack.alignment = .center
          stack.clipsToBounds = true
          stack.sizeToFit()
          //stack.spacing = 5
          stack.addBackground(color: UIColor.gray.withAlphaComponent(0.3), cornerRadius: 15)
          return stack
      }()
      
          let info3Title: UILabel = {
              let lbl = UILabel()
              lbl.text = "Customer Support"
              lbl.font = UIFont(name: "BrandonGrotesque-Black", size: 35)
            lbl.sizeToFit()
            lbl.adjustsFontSizeToFitWidth = true
              lbl.textColor = .white //Dark mode
              lbl.numberOfLines = 1
              lbl.sizeToFit()
              lbl.translatesAutoresizingMaskIntoConstraints = false

          
              return lbl
              
          }()
      
      let info3Text: UILabel = {
          let lbl = UILabel()
          lbl.text = "Get our full attention with response times less than 24 hours"
          lbl.font = UIFont(name: "BrandonGrotesque-Light", size: 20)
          lbl.textColor = .white //Dark mode
          lbl.numberOfLines = 0
          lbl.sizeToFit()
          lbl.adjustsFontSizeToFitWidth = true
          lbl.textAlignment = .center
          lbl.translatesAutoresizingMaskIntoConstraints = false

      
          return lbl
          
      }()
    

    
    let pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = 3
       control.isUserInteractionEnabled = false
       //control.backgroundColor = .gray
        control.pageIndicatorTintColor = UIColor.black.withAlphaComponent(0.4)
        control.currentPageIndicatorTintColor = .white
        return control
    }()
    
    let line: UIView = {
        let view = UIView()
        view.backgroundColor = .black
    

        return view
    }()
    
    let big: UIView = {
        let view = UIView()
        view.backgroundColor = .black


        return view
    }()
    
    let Hstack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        //stack.alignment = .center
        //stack.clipsToBounds = true
        //stack.sizeToFit()
        //stack.spacing = 5
        //stack.addBackground(color: Color.shared.gold.withAlphaComponent(0.2), cornerRadius: 0)
        return stack
    }()
    
    let twelveContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    

    
    let twelveInner: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = Color.shared.gold.cgColor
        view.layer.borderWidth = 3
        return view
    }()
    
    let twelveLabel: PaddingLabel = {
        let lbl = PaddingLabel()
        lbl.insets(top: 0, bottom: 0, left: 3, right: 3)
        lbl.text = "Best Value"
        lbl.backgroundColor = Color.shared.gold
        lbl.font = UIFont(name: "BrandonGrotesque-Light", size: 500)
        lbl.lineBreakMode = .byClipping
        lbl.adjustsFontSizeToFitWidth = true
        lbl.sizeToFit()
          lbl.textAlignment  = .center
        lbl.numberOfLines = 0
        lbl.textColor = .black
        lbl.layer.cornerRadius = 10
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true
        lbl.isHidden = true

        return lbl
    }()
    
    let twelveVstack1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        //stack.distribution = .fillEqually
        stack.alignment = .center
        //stack.clipsToBounds = true
        //stack.sizeToFit()
        stack.spacing = 0
        stack.addBackground(color: UIColor.black, cornerRadius: 0)
        return stack
    }()
    
    let twelveVstack2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        //stack.distribution = .fillEqually
        stack.alignment = .bottom
        //stack.clipsToBounds = true
        //stack.sizeToFit()
        stack.spacing = 0
        //stack.addBackground(color: UIColor.green.withAlphaComponent(0.2), cornerRadius: 0)
        return stack
    }()
    
    let twelveNUumberLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "12"
        lbl.sizeToFit()
        lbl.font = UIFont(name: "BrandonGrotesque-Black", size: 500)
        lbl.lineBreakMode = .byClipping
        //lbl.minimumScaleFactor = 0.1
        lbl.textColor = .white
        lbl.adjustsFontSizeToFitWidth = true
        lbl.sizeToFit()
        lbl.textAlignment  = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let twelveMonthLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "12 months"
        lbl.sizeToFit()
        lbl.font = UIFont(name: "BrandonGrotesque-Light", size: 500)
          lbl.lineBreakMode = .byClipping
              //  lbl.minimumScaleFactor = 0.1
        lbl.textColor = .white
        lbl.adjustsFontSizeToFitWidth = true
          lbl.textAlignment  = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let twelvePriceLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "$8.99"
        lbl.sizeToFit()
        lbl.font = UIFont(name: "BrandonGrotesque-Black", size: 500)
          lbl.lineBreakMode = .byClipping
              //  lbl.minimumScaleFactor = 0.1
        lbl.textColor = .white
        lbl.adjustsFontSizeToFitWidth = true
          lbl.textAlignment  = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    
    
    
    let sixContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let sixInner: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = Color.shared.gold.cgColor
        view.layer.borderWidth = 3
        return view
    }()
    
    let sixLabel: PaddingLabel = {
        let lbl = PaddingLabel()
        lbl.insets(top: 0, bottom: 0, left: 3, right: 3)
        lbl.text = "Most Popular"
        lbl.backgroundColor = Color.shared.gold
        lbl.font = UIFont(name: "BrandonGrotesque-Light", size: 500)
        lbl.lineBreakMode = .byClipping
        lbl.adjustsFontSizeToFitWidth = true
        lbl.sizeToFit()
          lbl.textAlignment  = .center
        lbl.numberOfLines = 0
        lbl.textColor = .black
        lbl.layer.cornerRadius = 10
        lbl.layer.masksToBounds = true
        lbl.adjustsFontSizeToFitWidth = true

        return lbl
    }()
    
    let sixVstack1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        //stack.distribution = .fillEqually
        stack.alignment = .center
        //stack.clipsToBounds = true
        //stack.sizeToFit()
        stack.spacing = 0
        stack.addBackground(color: UIColor.black.withAlphaComponent(0.5), cornerRadius: 0)
        return stack
    }()
    
    let sixVstack2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        //stack.distribution = .fillEqually
        stack.alignment = .bottom
        //stack.clipsToBounds = true
        //stack.sizeToFit()
        stack.spacing = 0
        //stack.addBackground(color: UIColor.green.withAlphaComponent(0.2), cornerRadius: 0)
        return stack
    }()
    
    let sixNumberLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "6"
        lbl.sizeToFit()
        lbl.font = UIFont(name: "BrandonGrotesque-Black", size: 500)
        lbl.lineBreakMode = .byClipping
        //lbl.minimumScaleFactor = 0.1
        lbl.textColor = .white
        lbl.adjustsFontSizeToFitWidth = true
        lbl.sizeToFit()
        lbl.textAlignment  = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let sixMonthLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "6 months"
        lbl.sizeToFit()
        lbl.font = UIFont(name: "BrandonGrotesque-Light", size: 500)
          lbl.lineBreakMode = .byClipping
              //  lbl.minimumScaleFactor = 0.1
        lbl.textColor = .white
        lbl.adjustsFontSizeToFitWidth = true
          lbl.textAlignment  = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let sixPriceLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "$4.99"
        lbl.sizeToFit()
        lbl.font = UIFont(name: "BrandonGrotesque-Black", size: 500)
          lbl.lineBreakMode = .byClipping
              //  lbl.minimumScaleFactor = 0.1
        lbl.textColor = .white
        lbl.adjustsFontSizeToFitWidth = true
          lbl.textAlignment  = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    
    
    
    let oneContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    let oneInner: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.layer.borderColor = Color.shared.gold.cgColor
        view.layer.borderWidth = 3
        return view
    }()
    

    
    let oneVstack1: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        //stack.distribution = .fillEqually
        stack.alignment = .center
        //stack.clipsToBounds = true
        //stack.sizeToFit()
        stack.spacing = 0
        stack.addBackground(color: UIColor.black, cornerRadius: 0)
        return stack
    }()
    
    let oneVstack2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        //stack.distribution = .fillEqually
        stack.alignment = .bottom
        //stack.clipsToBounds = true
        //stack.sizeToFit()
        stack.spacing = 0
        //stack.addBackground(color: UIColor.green.withAlphaComponent(0.2), cornerRadius: 0)
        return stack
    }()
    
    let oneNumberLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "1"
        lbl.sizeToFit()
        lbl.font = UIFont(name: "BrandonGrotesque-Black", size: 500)
        lbl.lineBreakMode = .byClipping
        //lbl.minimumScaleFactor = 0.1
        lbl.textColor = .white
        lbl.adjustsFontSizeToFitWidth = true
        lbl.sizeToFit()
        lbl.textAlignment  = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let oneMonthLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "1 month"
        lbl.sizeToFit()
        lbl.font = UIFont(name: "BrandonGrotesque-Light", size: 500)
          lbl.lineBreakMode = .byClipping
              //  lbl.minimumScaleFactor = 0.1
        lbl.textColor = .white
        lbl.adjustsFontSizeToFitWidth = true
          lbl.textAlignment  = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let onePriceLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "$0.99"
        lbl.sizeToFit()
        lbl.font = UIFont(name: "BrandonGrotesque-Black", size: 500)
          lbl.lineBreakMode = .byClipping
              //  lbl.minimumScaleFactor = 0.1
        lbl.textColor = .white
        lbl.adjustsFontSizeToFitWidth = true
          lbl.textAlignment  = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let upgradeBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        return view
    }()
    
    let pricePerMonthLbl: UILabel = {
        let lbl = UILabel()
        lbl.text = "$0.84/mth"
        lbl.sizeToFit()
        lbl.font = UIFont(name: "BrandonGrotesque-Black", size: 500)
          lbl.lineBreakMode = .byClipping
              //  lbl.minimumScaleFactor = 0.1
        lbl.textColor = .white
        lbl.adjustsFontSizeToFitWidth = true
          lbl.textAlignment  = .center
        lbl.numberOfLines = 0
        return lbl
    }()
    
    let btnStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        //stack.distribution = .fillEqually
        stack.alignment = .center
        //stack.clipsToBounds = true
        //stack.sizeToFit()
        stack.spacing = 0
        //stack.addBackground(color: UIColor.white, cornerRadius: 0)
        return stack
    }()
    
    
//    let upgradeBtn: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("Upgrade", for: .normal)
//        button.titleLabel?.font = UIFont.systemFont(ofSize: 500)
//        button.setTitleColor(UIColor.black, for: .normal)
//        button.titleLabel?.adjustsFontSizeToFitWidth = true
//        button.titleLabel?.numberOfLines = 1
//        button.backgroundColor = Color.shared.gold
//        button.addTarget(self, action: #selector(handleUpgrade), for: .touchUpInside)
//        button.layer.cornerRadius = 20
//        button.titleLabel?.lineBreakMode = .byClipping
//        return button
//    }()
    
    let upgradeBtn: PaddingLabel = {
        let lbl = PaddingLabel()
        lbl.text = "Upgrade"
        lbl.sizeToFit()
        lbl.font = UIFont(name: "BrandonGrotesque-Black", size: 500)
          lbl.lineBreakMode = .byClipping
              //  lbl.minimumScaleFactor = 0.1
        lbl.textColor = .black
        lbl.adjustsFontSizeToFitWidth = true
          lbl.textAlignment  = .center
        lbl.numberOfLines = 0
        lbl.backgroundColor = Color.shared.gold
        lbl.layer.cornerRadius = 20
        lbl.layer.masksToBounds = true
        
        return lbl
    }()
    
    
    let cancelBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "xbtn").withRenderingMode(.alwaysOriginal), for: .normal)
        

        button.addTarget(self, action: #selector(dismissPopup), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
        
    }()
    
    
    //MARK: VARIABLES
    let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
    var userHasSwiped = false
    var currentPage = 1
    var pastOffsetX = CGFloat()
    var negativeSet = Set<CGFloat>()
    var positiveSet = Set<CGFloat>()
    var absoluteIndex = 0
    var viewIsDead = false
    
    let factor = CGFloat(5/8)
    lazy var h = view.frame.height * (6/11)
    lazy var pricingHeight = view.frame.height * (2.5/11)
    lazy var pricingInternalHeigh = pricingHeight*(3/5)
    lazy var upgradeHeight = view.frame.height * (2.5/11)
    
    var twelveTapped = false
    var sixTapped = true
    var oneTapped = false
    
    var isIpad = false
    
    var isPopup = false
    var popupHeight = CGFloat()
    var popupWidth = CGFloat()
    
    var fromStoreController = true
    

    
    
    //MARK: Selectors
    
    func bringCancelToFront() {
        DispatchQueue.global(qos: .userInitiated).async {
            while true {
                DispatchQueue.main.async {
                    self.view.bringSubviewToFront(self.cancelBtn)
                }
                sleep(2)
                
            }
            
        }

    }
    
    @objc func dismissPopup() {
        print("&&&&&DISMISS")
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.2, options: .curveEaseIn, animations: {
            

            self.dismiss(animated: true, completion: nil)
        }, completion: nil)
        
    }
    
    @objc func handleUpgrade() {
        print("=====UPgrading $$$$")

        
        if twelveTapped {
            Gold.shared.purchase(subscription: .twelveMonths)
        } else if sixTapped {
            Gold.shared.purchase(subscription: .sixMonths)
        } else {
            Gold.shared.purchase(subscription: .oneMonth)
        }
   
        DispatchQueue.global(qos: .userInitiated).async {
            while !self.viewIsDead {
                if UserDefaults.standard.bool(forKey: "isGold") {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        let success = self.createLbl(text: "Congratulations! You are now a GOLD user.")
                        success.backgroundColor = .black
                        success.textColor = Color.shared.gold
                        self.showMessage(label: success)
                    }
                    break
                }
                
                sleep(3)
            }
            
            
            
        }
        
        
    }
    
    
    
    
    
    @objc func twelveTap() {
 
   
        sixTapped = false
        oneTapped = false
        
        twelveInner.layer.borderWidth = 5
        sixInner.layer.borderWidth = 0
        oneInner.layer.borderWidth = 0
        
        
        twelveLabel.isHidden = false
        sixLabel.isHidden = true
        
        twelveVstack1.subviews[0].backgroundColor = UIColor.black.withAlphaComponent(0.5)
        sixVstack1.subviews[0].backgroundColor = UIColor.black.withAlphaComponent(1)
        oneVstack1.subviews[0].backgroundColor = UIColor.black.withAlphaComponent(1)
        
        pricePerMonthLbl.text =   isIpad ?   "$0.73/month" : "$0.73/mth"
        
        
        if twelveTapped {
            //Show purchase popup
             print("++++++ 12 tapped")
            handleUpgrade()
        }
        twelveTapped = true
        
        
        
        
    }
    
    @objc func sixTap() {

        twelveTapped = false
        oneTapped = false
        
        twelveInner.layer.borderWidth = 0
        sixInner.layer.borderWidth = 5
        oneInner.layer.borderWidth = 0
        
        twelveLabel.isHidden = true
        sixLabel.isHidden = false
        
        twelveVstack1.subviews[0].backgroundColor = UIColor.black.withAlphaComponent(1)
        sixVstack1.subviews[0].backgroundColor = UIColor.black.withAlphaComponent(0.5)
        oneVstack1.subviews[0].backgroundColor = UIColor.black.withAlphaComponent(1)
        pricePerMonthLbl.text =   isIpad ?   "$0.84/month" : "$0.84/mth"

        
        if sixTapped {
            //Show purchase popup
             print("++++++ 6 tapped")
            handleUpgrade()
        }
        sixTapped = true
        
        
        
    }
    
    @objc func oneTap() {

        
        twelveTapped = false
        sixTapped = false
 
        
        twelveInner.layer.borderWidth = 0
        sixInner.layer.borderWidth = 0
        oneInner.layer.borderWidth = 5
        
        twelveLabel.isHidden = true
        sixLabel.isHidden = true
        
        twelveVstack1.subviews[0].backgroundColor = UIColor.black.withAlphaComponent(1)
        sixVstack1.subviews[0].backgroundColor = UIColor.black.withAlphaComponent(1)
        oneVstack1.subviews[0].backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        pricePerMonthLbl.text =   isIpad ?   "$0.99/month" : "$0.99/mth"

        
        if oneTapped {
            //Show purchase popup
             print("++++++ 1 tapped")
            handleUpgrade()
        }
        oneTapped = true
    }
    
    
    
    
    
    
    
    
    
    //MARK: HELPER FUNCTIONS
    

    
    func updatePageControl() {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                
                self.pageControl.currentPage = self.currentPage-1
                
            }, completion: nil)
            
        
    }
    
    @objc func scrollWasTapped() {
        print("+++ TAPPED")
        view.bringSubviewToFront(cancelBtn)
        userHasSwiped = true
        updatePageControl()
    }
    
    func swipeInfoViews() {
        //info3.isHidden = false
        //Hscroll.contentSize = CGSize(width: view.frame.width*3, height: 150)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            if self.userHasSwiped {
                return
            }

            
            UIView.animate(withDuration: 0.8, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {

                self.Hscroll.isUserInteractionEnabled = false
                self.Hscroll.contentOffset.x = self.Hscroll.contentOffset.x + self.view.frame.width
                
                
                

              
            }, completion: { _ in
                
 
                print("+++ Completion!")
                self.Hscroll.isUserInteractionEnabled = true
                
                self.createNewTile()
                self.view.bringSubviewToFront(self.cancelBtn)

                self.currentPage += 1
                if self.currentPage == 4 {
                    self.currentPage = 1
                }
                
                self.pastOffsetX += self.view.frame.width
                
                
                if !self.userHasSwiped && !self.viewIsDead {
                
                    self.swipeInfoViews()
            }
                }
                
            )
        }
    }
    
    func configureViewComponents() {
        if UIDevice.current.userInterfaceIdiom == .pad {
            pricePerMonthLbl.text = "$0.84/month"
            isIpad = true
        }
        
        if isPopup {
            view.frame = CGRect(x: 0, y: 0, width: popupWidth, height: popupHeight)
            print("+++++WIDTh: \(view.frame.width)")
        }
        
   
        pastOffsetX = CGFloat(0)
        
        
        navigationItem.titleView = goldItem
        
        view.addSubview(invisibleRect)
        invisibleRect.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: self.h)
        
        invisibleRect.addSubview(titleLbl)
        titleLbl.anchor(top: invisibleRect.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        titleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
        
        invisibleRect.addSubview(Hscroll)
        Hscroll.anchor(top: invisibleRect.topAnchor, left: invisibleRect.leftAnchor, bottom: nil, right: invisibleRect.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: self.h)
        Hscroll.delegate = self
        
        var tap = UITapGestureRecognizer(target: self, action: #selector(scrollWasTapped))

        Hscroll.addGestureRecognizer(tap)
        
        
        view.addSubview(pageControl)
        pageControl.anchor(top: Hscroll.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: -pricingHeight*(3/10), paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10, height: 10)

        
        Hscroll.addSubview(info1Gradient)
        info1Gradient.frame = CGRect(x: 0,y: 0, width: view.frame.width, height: self.h)
        

        
        info1Gradient.addSubview(info1Stack)
        info1Stack.anchor(top: nil, left: info1Gradient.leftAnchor, bottom: pageControl.topAnchor, right: info1Gradient.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: pricingHeight*(1/10), paddingRight: 20, width: 0, height: 100)
        info1Stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        info1Stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        info1Stack.isLayoutMarginsRelativeArrangement = true
        
        info1Stack.addArrangedSubview(info1Title)
        info1Stack.addArrangedSubview(info1Text)
        
        info1Gradient.addSubview(info1Img)
        info1Img.anchor(top: titleLbl.bottomAnchor, left: nil, bottom: info1Stack.topAnchor, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        info1Img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //IF you want it to page without it looking like a stack:
        //        info2Stack.anchor(top: nil, left: info2Gradient.leftAnchor, bottom: info2Gradient.bottomAnchor, right: info2Gradient.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 75, paddingRight: 25, width: 20, height: 115)
        //        info2Stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        //        info2Stack.isLayoutMarginsRelativeArrangement = true
                
               
        
        
        
        Hscroll.addSubview(info2Gradient)
        info2Gradient.frame = CGRect(x: view.frame.width,y: 0, width: view.frame.width, height: self.h)
        

        
        info2Gradient.addSubview(info2Stack)
        info2Stack.anchor(top: nil, left: info2Gradient.leftAnchor, bottom: pageControl.topAnchor, right: info2Gradient.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: pricingHeight*(1/10), paddingRight: 25, width: 0, height: 100)
        info2Stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        info2Stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        info2Stack.isLayoutMarginsRelativeArrangement = true
        

        
        info2Stack.addArrangedSubview(info2Title)
        info2Stack.addArrangedSubview(info2Text)
        
        info2Gradient.addSubview(info2Img)
        info2Img.anchor(top: titleLbl.bottomAnchor, left: nil, bottom: info2Stack.topAnchor, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        info2Img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        
        
        
        
        Hscroll.addSubview(info3Gradient)
        info3Gradient.frame = CGRect(x: view.frame.width*2,y: 0, width: view.frame.width, height: self.h)
        

        
        info3Gradient.addSubview(info3Stack)
        info3Stack.anchor(top: nil, left: info3Gradient.leftAnchor, bottom: pageControl.topAnchor, right: info3Gradient.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: pricingHeight*(1/10), paddingRight: 20, width: 0, height: 100)
        info3Stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        info3Stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        info3Stack.isLayoutMarginsRelativeArrangement = true
        

        
        info3Stack.addArrangedSubview(info3Title)
        info3Stack.addArrangedSubview(info3Text)
        
        info3Gradient.addSubview(info3Img)
        info3Img.anchor(top: titleLbl.bottomAnchor, left: nil, bottom: info3Stack.topAnchor, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
        info3Img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        

        
        
        
        

        
        view.addSubview(line)
        line.anchor(top: Hscroll.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 2)
        

        
        //scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height*2)
        Hscroll.contentSize = CGSize(width: Double.greatestFiniteMagnitude, height: Double(self.h))
        Hscroll.contentOffset.x = 0
        
        
        view.addSubview(Hstack)
        Hstack.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: pricingHeight)
        Hstack.layoutMargins = UIEdgeInsets(top: 2.5, left: 2.5, bottom: 2.5, right: 2.5)
        Hstack.isLayoutMarginsRelativeArrangement = true
        
        
        Hstack.addArrangedSubview(twelveContainer)
        twelveContainer.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        Hstack.addArrangedSubview(sixContainer)
        sixContainer.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        Hstack.addArrangedSubview(oneContainer)
        oneContainer.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)

        

        
        
        
        twelveContainer.addSubview(twelveInner)
        twelveInner.anchor(top: twelveContainer.topAnchor, left: twelveContainer.leftAnchor, bottom: twelveContainer.bottomAnchor, right: twelveContainer.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        twelveContainer.addSubview(twelveLabel)
        twelveLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: (view.frame.width/3)*(3/4), height: pricingHeight*(2/10))
        //twelveLabel.frame = CGRect(x: 0, y: h, width: twelveContainer.frame.width*(3/4), height: 30)
        twelveLabel.centerXAnchor.constraint(equalTo: twelveContainer.centerXAnchor).isActive = true
        twelveLabel.bottomAnchor.constraint(equalTo: twelveContainer.topAnchor, constant: (pricingHeight*(2/10)*0.5)+2.5).isActive = true
        
        twelveContainer.addSubview(twelveVstack1)
        twelveVstack1.anchor(top: twelveContainer.topAnchor, left: twelveContainer.leftAnchor, bottom: twelveContainer.bottomAnchor, right: twelveContainer.rightAnchor, paddingTop: 2.5, paddingLeft: 2.5, paddingBottom: 2.5, paddingRight: 2.5)
        //twelveVstack1.layoutMargins = UIEdgeInsets(top: pricingHeight*(1/5), left: 10, bottom: pricingHeight*(1/5), right: 10)
        twelveVstack1.isLayoutMarginsRelativeArrangement = true
        tap = UITapGestureRecognizer(target: self, action: #selector(twelveTap))
        twelveVstack1.addGestureRecognizer(tap)
        
        
        
        twelveContainer.bringSubviewToFront(twelveVstack1)
        twelveContainer.bringSubviewToFront(twelveLabel)
        
        twelveVstack1.addArrangedSubview(twelveVstack2)
        twelveVstack2.anchor(top: twelveVstack1.topAnchor, left: twelveVstack1.leftAnchor, bottom: twelveVstack1.bottomAnchor, right: twelveVstack1.rightAnchor, paddingTop: pricingHeight*(1/8), paddingLeft: pricingHeight*(1/8), paddingBottom: pricingHeight*(1/8), paddingRight: pricingHeight*(1/8), width: 0, height: 0)

        
        twelveVstack2.addArrangedSubview(twelveNUumberLbl)
        twelveNUumberLbl.anchor(top: nil, left: twelveVstack2.leftAnchor, bottom: nil, right: twelveVstack2.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: twelveVstack2.frame.width, height: pricingHeight*(3/8))
        
        twelveVstack2.addArrangedSubview(twelveMonthLbl)
        twelveMonthLbl.anchor(top: nil, left: twelveVstack2.leftAnchor, bottom: nil, right: twelveVstack2.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: twelveVstack2.frame.width, height: pricingHeight*(1.5/8))
        
        twelveVstack2.addArrangedSubview(twelvePriceLbl)
        twelvePriceLbl.anchor(top: nil, left: twelveVstack2.leftAnchor, bottom: nil, right: twelveVstack2.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: twelveVstack2.frame.width, height: pricingHeight*(1/8))
        
        
        
        
        
        
        
        sixContainer.addSubview(sixInner)
        sixInner.anchor(top: sixContainer.topAnchor, left: sixContainer.leftAnchor, bottom: sixContainer.bottomAnchor, right: sixContainer.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
        sixContainer.addSubview(sixLabel)
        sixLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: (view.frame.width/3)*(3/4), height: pricingHeight*(2/10))
        //sixLabel.frame = CGRect(x: 0, y: h, width: sixContainer.frame.width*(3/4), height: 30)
        sixLabel.centerXAnchor.constraint(equalTo: sixContainer.centerXAnchor).isActive = true
        sixLabel.bottomAnchor.constraint(equalTo: sixContainer.topAnchor, constant: (pricingHeight*(2/10)*0.5)+2.5).isActive = true
        
        sixContainer.addSubview(sixVstack1)
        sixVstack1.anchor(top: sixContainer.topAnchor, left: sixContainer.leftAnchor, bottom: sixContainer.bottomAnchor, right: sixContainer.rightAnchor, paddingTop: 2.5, paddingLeft: 2.5, paddingBottom: 2.5, paddingRight: 2.5)
        //sixVstack1.layoutMargins = UIEdgeInsets(top: pricingHeight*(1/5), left: 10, bottom: pricingHeight*(1/5), right: 10)
        sixVstack1.isLayoutMarginsRelativeArrangement = true
        
        tap = UITapGestureRecognizer(target: self, action: #selector(sixTap))
        sixVstack1.addGestureRecognizer(tap)
        
        
        sixContainer.bringSubviewToFront(sixVstack1)
        sixContainer.bringSubviewToFront(sixLabel)
        
        sixVstack1.addArrangedSubview(sixVstack2)
        sixVstack2.anchor(top: sixVstack1.topAnchor, left: sixVstack1.leftAnchor, bottom: sixVstack1.bottomAnchor, right: sixVstack1.rightAnchor, paddingTop: pricingHeight*(1/8), paddingLeft: pricingHeight*(1/8), paddingBottom: pricingHeight*(1/8), paddingRight: pricingHeight*(1/8), width: 0, height: 0)

        
        sixVstack2.addArrangedSubview(sixNumberLbl)
        sixNumberLbl.anchor(top: nil, left: sixVstack2.leftAnchor, bottom: nil, right: sixVstack2.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: sixVstack2.frame.width, height: pricingHeight*(3/8))
        
        sixVstack2.addArrangedSubview(sixMonthLbl)
        sixMonthLbl.anchor(top: nil, left: sixVstack2.leftAnchor, bottom: nil, right: sixVstack2.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: sixVstack2.frame.width, height: pricingHeight*(1.5/8))
        
        sixVstack2.addArrangedSubview(sixPriceLbl)
        sixPriceLbl.anchor(top: nil, left: sixVstack2.leftAnchor, bottom: nil, right: sixVstack2.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: sixVstack2.frame.width, height: pricingHeight*(1/8))
        

        
        
        
        sixContainer.addSubview(oneInner)
        oneInner.anchor(top: oneContainer.topAnchor, left: oneContainer.leftAnchor, bottom: oneContainer.bottomAnchor, right: oneContainer.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 0)
        
//        oneContainer.addSubview(oneLabel)
//        oneLabel.anchor(top: nil, left: nil, bottom: nil, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: oneContainer.frame.width*(3/4), height: 30)
//        //oneLabel.frame = CGRect(x: 0, y: h, width: oneContainer.frame.width*(3/4), height: 30)
//        oneLabel.centerXAnchor.constraint(equalTo: oneContainer.centerXAnchor).isActive = true
//        oneLabel.bottomAnchor.constraint(equalTo: oneContainer.topAnchor, constant: 17.5).isActive = true
        
        oneContainer.addSubview(oneVstack1)
        oneVstack1.anchor(top: oneContainer.topAnchor, left: oneContainer.leftAnchor, bottom: oneContainer.bottomAnchor, right: oneContainer.rightAnchor, paddingTop: 2.5, paddingLeft: 2.5, paddingBottom: 2.5, paddingRight: 2.5)
        //oneVstack1.layoutMargins = UIEdgeInsets(top: pricingHeight*(1/5), left: 10, bottom: pricingHeight*(1/5), right: 10)
        oneVstack1.isLayoutMarginsRelativeArrangement = true
        
        tap = UITapGestureRecognizer(target: self, action: #selector(oneTap))
        oneVstack1.addGestureRecognizer(tap)
        
        
        
        oneContainer.bringSubviewToFront(oneVstack1)
        //oneContainer.bringSubviewToFront(oneLabel)
        
        oneVstack1.addArrangedSubview(oneVstack2)
        oneVstack2.anchor(top: oneVstack1.topAnchor, left: oneVstack1.leftAnchor, bottom: oneVstack1.bottomAnchor, right: oneVstack1.rightAnchor, paddingTop: pricingHeight*(1/8), paddingLeft: pricingHeight*(1/8), paddingBottom: pricingHeight*(1/8), paddingRight: pricingHeight*(1/8), width: 0, height: 0)

        
        oneVstack2.addArrangedSubview(oneNumberLbl)
        oneNumberLbl.anchor(top: nil, left: oneVstack2.leftAnchor, bottom: nil, right: oneVstack2.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: oneVstack2.frame.width, height: pricingHeight*(3/8))
        
        oneVstack2.addArrangedSubview(oneMonthLbl)
        oneMonthLbl.anchor(top: nil, left: oneVstack2.leftAnchor, bottom: nil, right: oneVstack2.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: oneVstack2.frame.width, height: pricingHeight*(1.5/8))
        
        oneVstack2.addArrangedSubview(onePriceLbl)
        onePriceLbl.anchor(top: nil, left: oneVstack2.leftAnchor, bottom: nil, right: oneVstack2.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: oneVstack2.frame.width, height: pricingHeight*(1/8))
        
        oneContainer.bringSubviewToFront(oneVstack1)
        
        
        
        
        

        twelveInner.layer.borderWidth = 0
        sixInner.layer.borderWidth = 5
        oneInner.layer.borderWidth = 0
        

        view.addSubview(upgradeBackground)
        upgradeBackground.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: upgradeHeight)
        
        upgradeBackground.addSubview(pricePerMonthLbl)
        pricePerMonthLbl.anchor(top: upgradeBackground.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 8, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: oneVstack2.frame.width, height: pricingHeight*(1/8) )
        pricePerMonthLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
       
        btnStack.isLayoutMarginsRelativeArrangement = true

        upgradeBackground.addSubview(btnStack)
        btnStack.anchor(top: pricePerMonthLbl.bottomAnchor, left: view.leftAnchor, bottom: upgradeBackground.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: view.frame.width/6, paddingBottom: 24, paddingRight: view.frame.width/6, width: 0, height: 0)
        btnStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //btnStack.layoutMargins = UIEdgeInsets(top: 8, left: oneVstack2.frame.width/2, bottom: 0, right: oneVstack2.frame.width/2)
        
        btnStack.addArrangedSubview(upgradeBtn)
        upgradeBtn.anchor(top: btnStack.topAnchor, left: btnStack.leftAnchor, bottom: btnStack.bottomAnchor, right: btnStack.rightAnchor, paddingTop: 2, paddingLeft: 0, paddingBottom: 5   , paddingRight: 0, width: btnStack.frame.width, height: btnStack.frame.height)
        upgradeBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        tap = UITapGestureRecognizer(target: self, action: #selector(handleUpgrade))
        btnStack.addGestureRecognizer(tap)
        
        
        
        
        view.addSubview(cancelBtn)
        cancelBtn.anchor(top: view.topAnchor, left: nil, bottom: nil, right: view.rightAnchor, paddingTop: 5, paddingLeft: 0, paddingBottom: 0, paddingRight: 5, width: 15, height: 15)
       
        
        
        
        
        view.addScrollView(Dscroll, container: scrollViewContainer, elements: [invisibleRect, Hstack, upgradeBackground ])
        Dscroll.alwaysBounceVertical = true
        Dscroll.showsVerticalScrollIndicator = false
        
        
        configureColorScheme()
        
        view.bringSubviewToFront(pageControl)
        invisibleRect.bringSubviewToFront(titleLbl)
        view.bringSubviewToFront(titleLbl)
        view.bringSubviewToFront(oneVstack1)
        view.bringSubviewToFront(cancelBtn)
        
        twelveLabel.layer.cornerRadius = (pricingHeight*(2/10))/2
        sixLabel.layer.cornerRadius = (pricingHeight*(2/10))/2
        
     
    }
    
    func configureColorScheme() {

        
        if scheme == 0 {
            //STANDARD
            view.backgroundColor = Color.shared.darkGold
            
            goldItem.tintColor = Color.shared.gold
            
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = .black
            StatusBarColor.shared.isDark = false
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            

            
            
            
            
            
            
            
        }
        else if scheme == 1 {
            //DARK
            
            view.backgroundColor = Color.shared.darkGold
            
            goldItem.tintColor = Color.shared.gold
            
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = .black
            StatusBarColor.shared.isDark = false
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            


            
            
        }
        else {
            //LIGHT
            view.backgroundColor = Color.shared.darkGold
            
            goldItem.tintColor = Color.shared.gold
            
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = .black
            StatusBarColor.shared.isDark = false
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
   

            
            
        }
    }
    
    @objc func goBackHome() {
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    

    func createTileSubviews(tile: Int) ->   (UIImageView, UIStackView, UILabel, UILabel, UIImageView){
        switch tile {
        case 1:
              let info1GradientCopy = UIImageView()
                info1GradientCopy.image = #imageLiteral(resourceName: "goldGradient").withRenderingMode(.alwaysOriginal)
                info1GradientCopy.contentMode = .scaleToFill
                info1GradientCopy.clipsToBounds = true
                info1GradientCopy.sizeToFit()
             
            

                
                let info1ImgCopy = UIImageView()
                    info1ImgCopy.image = #imageLiteral(resourceName: "notfi+")
                    info1ImgCopy.contentMode = .scaleAspectFit
      
 
                
                let info1StackCopy = UIStackView()
                    info1StackCopy.axis = .vertical
                    info1StackCopy.distribution = .equalCentering
                    info1StackCopy.alignment = .center
                    info1StackCopy.clipsToBounds = true
                    info1StackCopy.sizeToFit()
                    info1StackCopy.addBackground(color: UIColor.gray.withAlphaComponent(0.3), cornerRadius: 15)

                
                let info1TitleCopy = UILabel()
                    info1TitleCopy.text = "Get There First"
                    info1TitleCopy.font = UIFont(name: "BrandonGrotesque-Black", size: 35)
                    info1TitleCopy.adjustsFontSizeToFitWidth = true
              
                    info1TitleCopy.textColor = .white //Dark mode
                    info1TitleCopy.numberOfLines = 1
                    info1TitleCopy.sizeToFit()
                    info1TitleCopy.translatesAutoresizingMaskIntoConstraints = false



                let info1TextCopy = UILabel()
                    info1TextCopy.text = "Push-notifications to notify you when supplies you need get re-stocked"
                    info1TextCopy.font = UIFont(name: "BrandonGrotesque-Light", size: 20)
                    info1TextCopy.textColor = .white //Dark mode
                    info1TextCopy.numberOfLines = 0
                    info1TextCopy.sizeToFit()
                    info1TextCopy.adjustsFontSizeToFitWidth = true
                    info1TextCopy.textAlignment = .center
                    info1TextCopy.translatesAutoresizingMaskIntoConstraints = false
            return (info1GradientCopy, info1StackCopy, info1TitleCopy, info1TextCopy, info1ImgCopy)

        case 2:
             let info2GradientCopy = UIImageView()
               info2GradientCopy.image = #imageLiteral(resourceName: "goTealGradient").withRenderingMode(.alwaysOriginal)
               info2GradientCopy.contentMode = .scaleToFill
               info2GradientCopy.clipsToBounds = true
               info2GradientCopy.sizeToFit()
            
           

               
               let info2ImgCopy = UIImageView()
                   info2ImgCopy.image = #imageLiteral(resourceName: "ads")
                   info2ImgCopy.contentMode = .scaleAspectFit
     

               
               let info2StackCopy = UIStackView()
                   info2StackCopy.axis = .vertical
                   info2StackCopy.distribution = .equalCentering
                   info2StackCopy.alignment = .center
                   info2StackCopy.clipsToBounds = true
                   info2StackCopy.sizeToFit()
                   info2StackCopy.addBackground(color: UIColor.gray.withAlphaComponent(0.3), cornerRadius: 15)

               
               let info2TitleCopy = UILabel()
                   info2TitleCopy.text = "Terminate Ads"
                   info2TitleCopy.font = UIFont(name: "BrandonGrotesque-Black", size: 35)
                   info2TitleCopy.adjustsFontSizeToFitWidth = true
                   info2TitleCopy.textColor = .white //Dark mode
                   info2TitleCopy.numberOfLines = 1
                   info2TitleCopy.sizeToFit()
                   info2TitleCopy.translatesAutoresizingMaskIntoConstraints = false



               let info2TextCopy = UILabel()
                   info2TextCopy.text = "Enjoy the complete ad-free experience"
                   info2TextCopy.font = UIFont(name: "BrandonGrotesque-Light", size: 20)
                   info2TextCopy.textColor = .white //Dark mode
                   info2TextCopy.numberOfLines = 0
                   info2TextCopy.sizeToFit()
                   info2TextCopy.adjustsFontSizeToFitWidth = true
                   info2TextCopy.textAlignment = .center
                   info2TextCopy.translatesAutoresizingMaskIntoConstraints = false
           return (info2GradientCopy, info2StackCopy, info2TitleCopy, info2TextCopy, info2ImgCopy)
        case 3:
             let info3GradientCopy = UIImageView()
               info3GradientCopy.image = #imageLiteral(resourceName: "greenGradient").withRenderingMode(.alwaysOriginal)
               info3GradientCopy.contentMode = .scaleToFill
               info3GradientCopy.clipsToBounds = true
               info3GradientCopy.sizeToFit()
            
           

               
               let info3ImgCopy = UIImageView()
                   info3ImgCopy.image = #imageLiteral(resourceName: "customerSupport")
                   info3ImgCopy.contentMode = .scaleAspectFit


               
               let info3StackCopy = UIStackView()
                   info3StackCopy.axis = .vertical
                   info3StackCopy.distribution = .equalCentering
                   info3StackCopy.alignment = .center
                   info3StackCopy.clipsToBounds = true
                   info3StackCopy.sizeToFit()
                   info3StackCopy.addBackground(color: UIColor.gray.withAlphaComponent(0.3), cornerRadius: 15)

               
               let info3TitleCopy = UILabel()
                   info3TitleCopy.text = "Customer Support"
                   info3TitleCopy.font = UIFont(name: "BrandonGrotesque-Black", size: 35)
                   info3TitleCopy.textColor = .white //Dark mode
                   info3TitleCopy.numberOfLines = 1
                    info3TitleCopy.adjustsFontSizeToFitWidth = true
                   info3TitleCopy.sizeToFit()
                   info3TitleCopy.translatesAutoresizingMaskIntoConstraints = false



               let info3TextCopy = UILabel()
                   info3TextCopy.text = "Get our full attention with response times less than 24 hours"
                   info3TextCopy.font = UIFont(name: "BrandonGrotesque-Light", size: 20)
                   info3TextCopy.textColor = .white //Dark mode
                   info3TextCopy.numberOfLines = 0
                   info3TextCopy.sizeToFit()
                   info3TextCopy.adjustsFontSizeToFitWidth = true
                   info3TextCopy.textAlignment = .center
                   info3TextCopy.translatesAutoresizingMaskIntoConstraints = false
           return (info3GradientCopy, info3StackCopy, info3TitleCopy, info3TextCopy, info3ImgCopy)
            
        default:
            print("+++something went wrong")
             return (UIImageView(), UIStackView(), UILabel(), UILabel(), UIImageView())
        }
        
        
    }
    
    func createNewTile() {
        switch self.currentPage {
        case 1:
            
            let info1GradientCopy: UIImageView
            let info1StackCopy: UIStackView
            let info1TitleCopy: UILabel
            let info1TextCopy: UILabel
            let info1ImgCopy: UIImageView
            
            
            (info1GradientCopy, info1StackCopy, info1TitleCopy, info1TextCopy, info1ImgCopy) = createTileSubviews(tile: 1)
            
            Hscroll.addSubview(info1GradientCopy)
            info1GradientCopy.frame = CGRect(x: pastOffsetX + self.view.frame.width*3,y: 0, width: view.frame.width, height: self.h)
            

            
            info1GradientCopy.addSubview(info1StackCopy)
            info1StackCopy.anchor(top: nil, left: info1GradientCopy.leftAnchor, bottom: pageControl.topAnchor, right: info1GradientCopy.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: pricingHeight*(1/10), paddingRight: 20, width: 0, height: 100)
            info1StackCopy.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            info1StackCopy.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
            info1StackCopy.isLayoutMarginsRelativeArrangement = true
            
            info1StackCopy.addArrangedSubview(info1TitleCopy)
            info1StackCopy.addArrangedSubview(info1TextCopy)
            
            info1GradientCopy.addSubview(info1ImgCopy)
            info1ImgCopy.anchor(top: titleLbl.bottomAnchor, left: nil, bottom: info1StackCopy.topAnchor, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
            info1ImgCopy.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
       
            
        case 2:
            let info2GradientCopy: UIImageView
            let info2StackCopy: UIStackView
            let info2TitleCopy: UILabel
            let info2TextCopy: UILabel
            let info2ImgCopy: UIImageView
            
            
            (info2GradientCopy, info2StackCopy, info2TitleCopy, info2TextCopy, info2ImgCopy) = createTileSubviews(tile: 2)
            
            Hscroll.addSubview(info2GradientCopy)
            info2GradientCopy.frame = CGRect(x: pastOffsetX + self.view.frame.width*3,y: 0, width: view.frame.width, height: self.h)
            

            
            info2GradientCopy.addSubview(info2StackCopy)
            info2StackCopy.anchor(top: nil, left: info2GradientCopy.leftAnchor, bottom: pageControl.topAnchor, right: info2GradientCopy.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: pricingHeight*(1/10), paddingRight: 20, width: 0, height: 100)
            info2StackCopy.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            info2StackCopy.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
            info2StackCopy.isLayoutMarginsRelativeArrangement = true
            

            
            info2StackCopy.addArrangedSubview(info2TitleCopy)
            info2StackCopy.addArrangedSubview(info2TextCopy)
            
            info2GradientCopy.addSubview(info2ImgCopy)
            info2ImgCopy.anchor(top: titleLbl.bottomAnchor, left: nil, bottom: info2StackCopy.topAnchor, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
            info2ImgCopy.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        case 3:
            let info3GradientCopy: UIImageView
            let info3StackCopy: UIStackView
            let info3TitleCopy: UILabel
            let info3TextCopy: UILabel
            let info3ImgCopy: UIImageView
            
            
            (info3GradientCopy, info3StackCopy, info3TitleCopy, info3TextCopy, info3ImgCopy) = createTileSubviews(tile: 3)
            
            Hscroll.addSubview(info3GradientCopy)
            info3GradientCopy.frame = CGRect(x: pastOffsetX + self.view.frame.width*3,y: 0, width: view.frame.width, height: self.h)
            

            
            info3GradientCopy.addSubview(info3StackCopy)
            info3StackCopy.anchor(top: nil, left: info3GradientCopy.leftAnchor, bottom: pageControl.topAnchor, right: info3GradientCopy.rightAnchor, paddingTop: 0, paddingLeft: 20, paddingBottom: pricingHeight*(1/10), paddingRight: 20, width: 0, height: 100)
            info3StackCopy.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            info3StackCopy.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
            info3StackCopy.isLayoutMarginsRelativeArrangement = true
            

            
            info3StackCopy.addArrangedSubview(info3TitleCopy)
            info3StackCopy.addArrangedSubview(info3TextCopy)
            
            info3GradientCopy.addSubview(info3ImgCopy)
            info3ImgCopy.anchor(top: titleLbl.bottomAnchor, left: nil, bottom: info3StackCopy.topAnchor, right: nil, paddingTop: 10, paddingLeft: 0, paddingBottom: 10, paddingRight: 0, width: 0, height: 0)
            info3ImgCopy.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        default:
            print("+++something went wrong")
            
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
     
            UIView.animate(withDuration: 3 , delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                
                label.frame = CGRect(x: 0, y: self.view.frame.height - 100, width: (self.view.frame.width/4)*3, height: 50)
                label.center.x = self.view.center.x
            }, completion: { _ in
                    UIView.animate(withDuration: 5, delay: 10, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                        label.alpha = 0
                    }, completion: { _ in
                        
                        label.removeFromSuperview()
                        label.alpha = 1
                    })
            })
        
    }
    
    



}


extension GoldPopup:UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //        if !self.userHasSwiped {
        //            return
        //        }
        
        userHasSwiped = true
        
        let currentOffset = self.Hscroll.contentOffset.x
        //Case user swiped Right
        if  (self.Hscroll.contentOffset.x - self.pastOffsetX) < 0 {
            print("+++SWIPED RIGHT")
            
            absoluteIndex -= 1
            if absoluteIndex == -1 {
                absoluteIndex = 0
                currentPage = 1
            } else {
        
                self.currentPage -= 1
                
                if self.currentPage == 0 {
                    self.currentPage = 3
                }
            }
            
            
            self.pastOffsetX -= self.view.frame.width
            print("+Now at \(self.pastOffsetX)")
        }
        else if  (self.Hscroll.contentOffset.x - self.pastOffsetX) > 0 {
            print("+++SWIPED LEFT")
            print("+Was at \(self.pastOffsetX)")
            
            if !self.positiveSet.contains(currentOffset + self.view.frame.width*3) {
                print("+++++Add tile to the RIGHT")
                self.positiveSet.insert(currentOffset + self.view.frame.width*3)
                
                createNewTile()
                view.bringSubviewToFront(cancelBtn)
                
            }
            self.currentPage += 1
            absoluteIndex += 1
            
            if self.currentPage == 4 {
                self.currentPage = 1
            }
            
            self.pastOffsetX += self.view.frame.width
            print("+Now at \(self.pastOffsetX)")
            
        }
        updatePageControl()
        view.bringSubviewToFront(cancelBtn)
    }

        

}
