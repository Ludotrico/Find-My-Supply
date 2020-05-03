//
//  GoldController.swift
//  Find My Supply
//
//  Created by Ludovico Veniani on 5/2/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class GoldController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()

        // Do any additional setup after loading the view.
    }
       override func viewWillDisappear(_ animated: Bool) {
           self.navigationController?.navigationBar.isHidden = true
            viewIsDead = true
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
    let scrollViewContainer = DScrollViewContainer(axis: .vertical, spacing: 10)
    
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
        lbl.text = "Get Gold"
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
            lbl.translatesAutoresizingMaskIntoConstraints = false

        
            return lbl
            
        }()
    
    let info1Text: UILabel = {
        let lbl = UILabel()
        lbl.text = "Push-notifications to notify you when supplies you’re interested in get restocked"
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
        view.alpha = 0.4

        return view
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
    
    //MARK: HELPER FUNCTIONS
    
    func updatePageControl() {
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                
                self.pageControl.currentPage = self.currentPage-1
                
            }, completion: nil)
            
        
    }
    
    @objc func scrollWasTapped() {
        print("+++ TAPPED")
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
        
        pastOffsetX = CGFloat(0)
        
        view.backgroundColor = .black
        
        navigationItem.titleView = goldItem
        
        view.addSubview(invisibleRect)
        invisibleRect.anchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 350)
        
        invisibleRect.addSubview(titleLbl)
        titleLbl.anchor(top: invisibleRect.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 15, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 0, height: 30)
        titleLbl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    
        
        invisibleRect.addSubview(Hscroll)
        Hscroll.anchor(top: invisibleRect.topAnchor, left: invisibleRect.leftAnchor, bottom: nil, right: invisibleRect.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 350)
        Hscroll.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(scrollWasTapped))

        Hscroll.addGestureRecognizer(tap)

        
        Hscroll.addSubview(info1Gradient)
        info1Gradient.frame = CGRect(x: 0,y: 0, width: view.frame.width, height: 350)
        

        
        info1Gradient.addSubview(info1Stack)
        info1Stack.anchor(top: nil, left: info1Gradient.leftAnchor, bottom: info1Gradient.bottomAnchor, right: info1Gradient.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 75, paddingRight: 25, width: 0, height: 115)
        info1Stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        info1Stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        info1Stack.isLayoutMarginsRelativeArrangement = true
        
        info1Stack.addArrangedSubview(info1Title)
        info1Stack.addArrangedSubview(info1Text)
        
        info1Gradient.addSubview(info1Img)
        info1Img.anchor(top: titleLbl.bottomAnchor, left: nil, bottom: info1Stack.topAnchor, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 25, paddingRight: 0, width: 0, height: 0)
        info1Img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //IF you want it to page without it looking like a stack:
        //        info2Stack.anchor(top: nil, left: info2Gradient.leftAnchor, bottom: info2Gradient.bottomAnchor, right: info2Gradient.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 75, paddingRight: 25, width: 20, height: 115)
        //        info2Stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        //        info2Stack.isLayoutMarginsRelativeArrangement = true
                
               
        
        
        
        Hscroll.addSubview(info2Gradient)
        info2Gradient.frame = CGRect(x: view.frame.width,y: 0, width: view.frame.width, height: 350)
        

        
        info2Gradient.addSubview(info2Stack)
        info2Stack.anchor(top: nil, left: info2Gradient.leftAnchor, bottom: info2Gradient.bottomAnchor, right: info2Gradient.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 75, paddingRight: 25, width: 0, height: 115)
        info2Stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        info2Stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        info2Stack.isLayoutMarginsRelativeArrangement = true
        

        
        info2Stack.addArrangedSubview(info2Title)
        info2Stack.addArrangedSubview(info2Text)
        
        info2Gradient.addSubview(info2Img)
        info2Img.anchor(top: titleLbl.bottomAnchor, left: nil, bottom: info2Stack.topAnchor, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0)
        info2Img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        
        
        
        
        
        
        Hscroll.addSubview(info3Gradient)
        info3Gradient.frame = CGRect(x: view.frame.width*2,y: 0, width: view.frame.width, height: 350)
        

        
        info3Gradient.addSubview(info3Stack)
        info3Stack.anchor(top: nil, left: info3Gradient.leftAnchor, bottom: info3Gradient.bottomAnchor, right: info3Gradient.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 75, paddingRight: 25, width: 0, height: 115)
        info3Stack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        info3Stack.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        info3Stack.isLayoutMarginsRelativeArrangement = true
        

        
        info3Stack.addArrangedSubview(info3Title)
        info3Stack.addArrangedSubview(info3Text)
        
        info3Gradient.addSubview(info3Img)
        info3Img.anchor(top: titleLbl.bottomAnchor, left: nil, bottom: info3Stack.topAnchor, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0)
        info3Img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        

        
        
        
        
        view.addSubview(pageControl)
        pageControl.anchor(top: Hscroll.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: -45, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 10, height: 10)
        
        view.addSubview(line)
        line.anchor(top: Hscroll.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 2)
        

        
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height*2)
        Hscroll.contentSize = CGSize(width: Double.greatestFiniteMagnitude, height: 350)
        Hscroll.contentOffset.x = 0
        
        view.addSubview(big)
        
        big.anchor(top: invisibleRect.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: view.frame.width, height: 1000)
        
        
        view.addScrollView(Dscroll, container: scrollViewContainer, elements: [invisibleRect, big ])
        Dscroll.alwaysBounceVertical = true
        
        
        configureColorScheme()
        
        view.bringSubviewToFront(pageControl)
        invisibleRect.bringSubviewToFront(titleLbl)
        view.bringSubviewToFront(titleLbl)
     
    }
    
    func configureColorScheme() {

        
        if scheme == 0 {
            //STANDARD
            view.backgroundColor = .black
            
            goldItem.tintColor = .black
            
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            

            
            
            
            
            
            
            
        }
        else if scheme == 1 {
            //DARK
            
            view.backgroundColor = .black
            
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
            view.backgroundColor = .black
            
            goldItem.tintColor = .black
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            StatusBarColor.shared.isDark = true
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
                    info1TitleCopy.textColor = .white //Dark mode
                    info1TitleCopy.numberOfLines = 1
                    info1TitleCopy.sizeToFit()
                    info1TitleCopy.translatesAutoresizingMaskIntoConstraints = false



                let info1TextCopy = UILabel()
                    info1TextCopy.text = "Push-notifications to notify you when supplies you’re interested in get re-stocked"
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
            info1GradientCopy.frame = CGRect(x: pastOffsetX + self.view.frame.width*3,y: 0, width: view.frame.width, height: 350)
            

            
            info1GradientCopy.addSubview(info1StackCopy)
            info1StackCopy.anchor(top: nil, left: info1GradientCopy.leftAnchor, bottom: info1GradientCopy.bottomAnchor, right: info1GradientCopy.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 75, paddingRight: 25, width: 0, height: 115)
            info1StackCopy.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            info1StackCopy.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
            info1StackCopy.isLayoutMarginsRelativeArrangement = true
            
            info1StackCopy.addArrangedSubview(info1TitleCopy)
            info1StackCopy.addArrangedSubview(info1TextCopy)
            
            info1GradientCopy.addSubview(info1ImgCopy)
            info1ImgCopy.anchor(top: titleLbl.bottomAnchor, left: nil, bottom: info1StackCopy.topAnchor, right: nil, paddingTop: 25, paddingLeft: 0, paddingBottom: 25, paddingRight: 0, width: 0, height: 0)
            info1ImgCopy.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            
       
            
        case 2:
            let info2GradientCopy: UIImageView
            let info2StackCopy: UIStackView
            let info2TitleCopy: UILabel
            let info2TextCopy: UILabel
            let info2ImgCopy: UIImageView
            
            
            (info2GradientCopy, info2StackCopy, info2TitleCopy, info2TextCopy, info2ImgCopy) = createTileSubviews(tile: 2)
            
            Hscroll.addSubview(info2GradientCopy)
            info2GradientCopy.frame = CGRect(x: pastOffsetX + self.view.frame.width*3,y: 0, width: view.frame.width, height: 350)
            

            
            info2GradientCopy.addSubview(info2StackCopy)
            info2StackCopy.anchor(top: nil, left: info2GradientCopy.leftAnchor, bottom: info2GradientCopy.bottomAnchor, right: info2GradientCopy.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 75, paddingRight: 25, width: 0, height: 115)
            info2StackCopy.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            info2StackCopy.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
            info2StackCopy.isLayoutMarginsRelativeArrangement = true
            

            
            info2StackCopy.addArrangedSubview(info2TitleCopy)
            info2StackCopy.addArrangedSubview(info2TextCopy)
            
            info2GradientCopy.addSubview(info2ImgCopy)
            info2ImgCopy.anchor(top: titleLbl.bottomAnchor, left: nil, bottom: info2StackCopy.topAnchor, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0)
            info2ImgCopy.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        case 3:
            let info3GradientCopy: UIImageView
            let info3StackCopy: UIStackView
            let info3TitleCopy: UILabel
            let info3TextCopy: UILabel
            let info3ImgCopy: UIImageView
            
            
            (info3GradientCopy, info3StackCopy, info3TitleCopy, info3TextCopy, info3ImgCopy) = createTileSubviews(tile: 3)
            
            Hscroll.addSubview(info3GradientCopy)
            info3GradientCopy.frame = CGRect(x: pastOffsetX + self.view.frame.width*3,y: 0, width: view.frame.width, height: 350)
            

            
            info3GradientCopy.addSubview(info3StackCopy)
            info3StackCopy.anchor(top: nil, left: info3GradientCopy.leftAnchor, bottom: info3GradientCopy.bottomAnchor, right: info3GradientCopy.rightAnchor, paddingTop: 0, paddingLeft: 25, paddingBottom: 75, paddingRight: 25, width: 0, height: 115)
            info3StackCopy.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            info3StackCopy.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
            info3StackCopy.isLayoutMarginsRelativeArrangement = true
            

            
            info3StackCopy.addArrangedSubview(info3TitleCopy)
            info3StackCopy.addArrangedSubview(info3TextCopy)
            
            info3GradientCopy.addSubview(info3ImgCopy)
            info3ImgCopy.anchor(top: titleLbl.bottomAnchor, left: nil, bottom: info3StackCopy.topAnchor, right: nil, paddingTop: 20, paddingLeft: 0, paddingBottom: 20, paddingRight: 0, width: 0, height: 0)
            info3ImgCopy.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        default:
            print("+++something went wrong")
            
        }
    }
    
    



}


extension GoldController:UIScrollViewDelegate {
    
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
    }

        

}
