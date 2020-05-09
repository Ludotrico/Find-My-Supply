//
//  ImageController.swift
//  findMySupply3
//
//  Created by Ludovico Veniani on 4/11/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit

class ImageController: UIViewController {

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
        
        
        setZoomScale(for: scrollView.bounds.size)
        scrollView.zoomScale = scrollView.minimumZoomScale
        recenterImage()

        
  

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
          self.navigationController?.navigationBar.isHidden = false
          

          let mapBtn = UIButton(type: .system)
          mapBtn.setImage(#imageLiteral(resourceName: "map-1").withRenderingMode(.alwaysTemplate), for: .normal)
          
        let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
        
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

    var scrollView: UIScrollView!


    var img = UIImageView()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = Color.shared.gold
        
        spinner.startAnimating()
        spinner.alpha = 1
        spinner.transform = CGAffineTransform(scaleX: 1.25, y: 1.25)
        spinner.isHidden = true
        return spinner
    }()
   
    

    func configureViewComponents() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.contentSize = img.bounds.size
        scrollView.delegate = self
        scrollView.addSubview(img)
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        view.addSubview(scrollView)
        img.frame = scrollView.frame
        img.contentMode = .scaleAspectFit
        
        

        
        configureColorScheme()
    }
    
    func configureColorScheme() {
        let scheme = UserDefaults.standard.integer(forKey: "colorScheme")
        
        if scheme == 0 {
            view.backgroundColor = .darkGray
            scrollView.backgroundColor = .darkGray
            
            navigationController?.navigationBar.isTranslucent = true
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
            StatusBarColor.shared.isDark = true
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
            spinner.color = Color.shared.gold
            
        } else if scheme == 1 {
            view.backgroundColor = .black
            scrollView.backgroundColor = .black
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .white
            navigationController?.navigationBar.barTintColor = .black
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
            StatusBarColor.shared.isDark = false
            UIView.animate(withDuration: 0.5, animations: {
                 self.setNeedsStatusBarAppearanceUpdate()
            })
            
        } else {
            view.backgroundColor = .white
            scrollView.backgroundColor = .white
            
            navigationController?.navigationBar.isTranslucent = false
            navigationController?.navigationBar.tintColor = .black
            navigationController?.navigationBar.barTintColor = .white
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor:UIColor.black]
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
    
    func recenterImage() {
        let scrollSize = scrollView.bounds.size
        let imageSize = img.frame.size
        let horizSpace = (imageSize.width < scrollSize.width) ? (scrollSize.width - imageSize.width)/2.0 : 0
        let vertSpace = (imageSize.height < scrollSize.height) ? (scrollSize.height - imageSize.height)/2.0 : 0
        
        let extra = (navigationController?.navigationBar.bounds.size.height)! + CGFloat(20)
        
        scrollView.contentInset = UIEdgeInsets(top: vertSpace-extra, left: horizSpace, bottom: vertSpace, right: horizSpace)
        
        
    }
    
    func setZoomScale(for scrollSize: CGSize) {
        let imgSize = img.bounds.size
        let widthScale = scrollSize.width / imgSize.width
        let heightScale = scrollSize.height / imgSize.height
        
        let minScale = min(widthScale, heightScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.maximumZoomScale = 100000
        
    }
    

}

extension ImageController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return img
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        recenterImage()
    }
    
    
}
