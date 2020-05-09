//
//  RegisterController.swift
//  findMySupply2
//
//  Created by Ludovico Veniani on 3/27/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import UIKit
import MapKit

class RegisterController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewComponents()
    
        self.navigationController?.navigationBar.isHidden = true
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("+++VIEW DID APPEAR")
        checkIfVerified()
    }
    

    
    
    
    let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.alwaysBounceVertical = true
        view.showsVerticalScrollIndicator = false
        
        return view
    }()
    
    let logoImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        iv.image = #imageLiteral(resourceName: "tpTransp")
        return iv
    }()
    
    lazy var nameContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, UIImage(systemName: "person")!.withTintColor(.white, renderingMode: .alwaysOriginal), nameTextField!)
    }()
    
    lazy var emailContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, UIImage(systemName: "envelope")!.withTintColor(.white, renderingMode: .alwaysOriginal), emailTextField!)
    }()
    
    lazy var usernameContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, UIImage(systemName: "person.fill")!.withTintColor(.white, renderingMode: .alwaysOriginal), usernameTextField!)
    }()
    
    lazy var passwordContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, UIImage(systemName: "lock")!.withTintColor(.white, renderingMode: .alwaysOriginal), passwordTextField!)
    }()
    
    lazy var zipcodeContainerView: UIView = {
        let view = UIView()
        return view.textContainerView(view: view, #imageLiteral(resourceName: "map-1").withTintColor(.white, renderingMode: .alwaysOriginal), zipcodeTextField!)
    }()
    
    
    lazy var nameTextField: UITextField? = {
        let tf = UITextField()
        //tf.textContentType = .name
        return tf.textField(withPlaceolder: "First name", isSecureTextEntry: false, isTextEntry: true)
    }()
    
    lazy var emailTextField: UITextField? = {
        var tf = UITextField()
        //tf.textContentType = .emailAddress
        tf = tf.textField(withPlaceolder: "Email", isSecureTextEntry: false, isTextEntry: true)
        tf.autocapitalizationType = .none
        return tf
    }()
    
    lazy var usernameTextField: UITextField? = {
        var tf = UITextField()
//        tf.textContentType = .username
        tf = tf.textField(withPlaceolder: "Username", isSecureTextEntry: false, isTextEntry: true)
        tf.autocapitalizationType = .none
        return tf
    }()
    
    lazy var passwordTextField: UITextField? = {
        let tf = UITextField()
//        tf.textContentType = .password
        return tf.textField(withPlaceolder: "Password", isSecureTextEntry: true, isTextEntry: true)
    }()
    
    lazy var zipcodeTextField: UITextField? = {
        var tf = UITextField()
        tf = tf.textField(withPlaceolder: "ZIP code", isSecureTextEntry: false, isTextEntry: false)
        tf.delegate = self
        return tf
        
    }()
    
    
    let locationBtn: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "location.fill")?.withTintColor(Color.shared.blue, renderingMode: .alwaysTemplate), for: .normal)
        button.addTarget(self, action: #selector(findLocation), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        return button
    }()
    
    let loginButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Sign up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.setTitleColor(Color.shared.blue, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        button.layer.cornerRadius = 5
        return button
    }()
    
    let haveAccountButton: UIButton = {
        let button = UIButton(type: .system)
        let attributedTitle = NSMutableAttributedString(string: "Already have an account?  ", attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: UIColor.white])
        attributedTitle.append(NSAttributedString(string: "Sign in", attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedString.Key.foregroundColor: Color.shared.gold]))
        button.setAttributedTitle(attributedTitle, for: .normal)
        button.addTarget(self, action: #selector(handleShowLogin), for: .touchUpInside)
        return button
    }()
    
    let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.color = Color.shared.gold
        spinner.startAnimating()
        spinner.alpha = 1
        spinner.isHidden = true
        return spinner
    }()
    
    //MARK: Variables
    
    var checkCount = 0
    var displayMessage = true
    var verified = false
    var locationManager: CLLocationManager!
    var locationEnabled = false
    
    @objc func handleRegister(){
        nameTextField?.resignFirstResponder()
        emailTextField?.resignFirstResponder()
        usernameTextField?.resignFirstResponder()
        passwordTextField?.resignFirstResponder()
        zipcodeTextField?.resignFirstResponder()
        
        

        
        
        var name = ""
        var email = ""
        var usrname = ""
        var psw = ""
        var zip = ""
        
    
        if nameTextField?.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true || emailTextField?.text?.trimmingCharacters(in: .whitespaces).isEmpty  ?? true || usernameTextField?.text?.trimmingCharacters(in: .whitespaces).isEmpty  ?? true || passwordTextField?.text?.isEmpty  ?? true || zipcodeTextField?.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true  {
            if nameTextField?.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true {
                showMessage(label: createLbl(text: "First name is required."))
                return
            }
            if emailTextField?.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true {
                showMessage(label: createLbl(text: "Email is required."))
                return
            }
            if usernameTextField?.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true{
                showMessage(label: createLbl(text: "Username is required."))
                return
            }
            if passwordTextField?.text?.isEmpty ?? true {
                showMessage(label: createLbl(text: "Password is required."))
                return
            }
            if zipcodeTextField?.text?.trimmingCharacters(in: .whitespaces).isEmpty ?? true {
                showMessage(label: createLbl(text: "ZIP code is required."))
                return
            }
        }
        else {
            if let n = nameTextField?.text {
                name = n.trimmingCharacters(in: .whitespaces)
                let characterset = CharacterSet(charactersIn: #"abcdefghijklmnopqrstuvwxyz’ABCDEFGHIJKLMNOPQRSTUVWXYZ"#)
                if n.count > 60 {
                    showMessage(label: createLbl(text: "First name is too long."))
                    return
                }
                else if n.rangeOfCharacter(from: characterset.inverted) != nil {
                    showMessage(label: createLbl(text: "First name cannot contain special characters."))
                    return
                }
            }
            if let e = emailTextField?.text {
                email = e.trimmingCharacters(in: .whitespaces)
                if !e.contains("@") || !e.contains(".") || email.contains(" ") {
                    showMessage(label: createLbl(text: "Email address is invalid."))
                    return
                }
                else if e.count > 100 {
                    showMessage(label: createLbl(text:"Email is too long."))
                    return
                }
            }
            if let u = usernameTextField?.text {
                usrname = u.trimmingCharacters(in: .whitespaces)
                if u.count > 60 {
                    showMessage(label: createLbl(text: "Username is too long."))
                    return
                }
                else if usrname.contains(" ") {
                    showMessage(label: createLbl(text: "Username cannot contain spaces."))
                    return
                }
                
            }
            if let p = passwordTextField?.text {
                psw = p
                if p.count < 5 {
                    showMessage(label: createLbl(text: "Password must be at least 5 characters."))
                    return
                }
                else if p.count > 100  {
                    showMessage(label: createLbl(text: "Password is too long."))
                    return
                }
            }
            if let z = zipcodeTextField?.text {
                zip = z.trimmingCharacters(in: .whitespaces)

                if (zip.count != 5) {
                    showMessage(label: createLbl(text: "ZIP code is invalid."))
                    return
                }
                
                if let _ = Int(zip) {
                } else {
                    showMessage(label: createLbl(text: "ZIP code is invalid."))
                    return
                }
                
            }
        }
        
        let userAuth = UserAuth.shared
        self.loginButton.isEnabled = false
        spinner.isHidden = false
        DispatchQueue.global(qos: .userInitiated).async {
            print("\n\n\n======================START==================\n")
            userAuth.initRegisterUser(withName: name, withEmail: email, withUsername: usrname, withPassword: psw, withZip: zip)
            userAuth.fetchNewSalt { (result) in
                switch result {
                case .success(let s):
                    print("Completed Salt Fetch with salt: \(s)\n")
                        userAuth.salt = s
                        print("Updated Register Obj salt\n")
                   
                    DispatchQueue.global(qos: .userInitiated).async {
                    userAuth.registerToServer { (result) in
                        switch result {
                        case .success(var m):
                            print("Completed RTS Fetch\n")
                            DispatchQueue.main.async {
                                print("Updating Label\n")
                                var registered = false
                                let firstChar = m.removeFirst()
                                if firstChar == "#" {
                                    //Failed to register user
                                    self.showMessage(label: self.createLbl(text: m))
                                }
                                else{
                                    //Registered user!  m = T8023  (T if it is new zipcode, userID)
                                    print("USER DEFUALTS:\n\(userAuth.fName)\n\(userAuth.email)\n\(userAuth.username)\n\(userAuth.salt)\n\(userAuth.password)\n\(firstChar)")
                                    let hashedPsw = (userAuth.password + userAuth.salt).sha256()
                                    UserDefaults.standard.set(false, forKey: "isRegistered")
                                    UserDefaults.standard.set("\(userAuth.fName)", forKey: "fName")
                                    UserDefaults.standard.set("\(userAuth.fName)", forKey: "fName")
                                    UserDefaults.standard.set("\(userAuth.email)", forKey: "email")
                                    UserDefaults.standard.set("\(userAuth.username)", forKey: "username")
                                    UserDefaults.standard.set(Int(m), forKey: "userID")
                                    UserDefaults.standard.set("\(userAuth.salt)", forKey: "salt")
                                    UserDefaults.standard.set("\(hashedPsw)", forKey: "password")
                                    UserDefaults.standard.set(10, forKey: "radius")
                                    UserDefaults.standard.set(0, forKey: "mapType")
                                    UserDefaults.standard.set(0, forKey: "mapApp")
                                    UserDefaults.standard.set(0, forKey: "colorScheme")
                                    UserDefaults.standard.set(10, forKey: "submissionsRemaining")
                                    UserDefaults.standard.set(true, forKey: "firstLaunch")
                                    if firstChar == "T" {
                                        UserDefaults.standard.set(true, forKey: "waitingForScrape")
                                    }
                                    UserDefaults.standard.set(zip, forKey: "zipcode")
                                    UpdateUser.shared.zip = Int(zip)!
                   
                                    
                                                                       
                                    self.showSentEmail()
                                    registered = true
                              
                                    ///self.navigationController?.popToRootViewController(animated: true)
                                    
                                }
                                
                                self.spinner.isHidden = true
                                self.loginButton.isEnabled = true
                               
                                
                                if registered {
                                    self.displayMessage = false
                                    self.checkIfVerified()
                                }
                                
                            }
                        case .failure(let error):
                            print("DEBUG: Failed with error \(error)")
                            DispatchQueue.main.async {
                                self.spinner.isHidden = true
                                self.loginButton.isEnabled = true
                                self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                            }
                        }
                    }
                    }

                case .failure(let error):
                    print("DEBUG: Failed with error \(error)")
                    DispatchQueue.main.async {
                        self.spinner.isHidden = true
                        self.loginButton.isEnabled = true
                         self.showMessage(label: self.createLbl(text: "Oops! A network error occurred, please check your connection and try again."))
                    }
                
                }
            }
            
    
        }
            
            //if message.message.removeFirst() == "#" {

            
        
    }
    
    @objc func sendVerificationEmail() {
        print("=== RESENT")
        spinner.isHidden = false
        DispatchQueue.global(qos: .userInitiated).async {
            UserAuth.shared.sendVerificationEmail { (result) in
                switch result {
                case .success(_):
                    DispatchQueue.main.async {
                        self.showSentEmail()
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
    
    func checkIfVerified() {
        DispatchQueue.global(qos: .userInitiated).asyncAfter(deadline: .now() + 3) {
            self.checkVerification()
        }
        
  
        
    }
    
    
    func checkVerification() {
        if UserDefaults.standard.bool(forKey: "firstLaunch") {

            DispatchQueue.global(qos: .userInitiated).async {
                UserAuth.shared.checkIfVerified { (result) in
                    self.checkCount += 1
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let bool):
                            if bool {
                                UserDefaults.standard.set(true, forKey: "isRegistered")
                                self.navigationController?.popToRootViewController(animated: true)
                                self.verified = true
                            } else if self.displayMessage {

                                self.showSentEmail()
                            }
                            if !self.verified {
                                self.checkIfVerified()
                            }
                            self.displayMessage = false
                            
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
    }
    
    @objc func findLocation() {
        print("++++FIND LOCATION")
        
        locationManager = CLLocationManager()
        locationManager.delegate  = self
        
        enableLocationServices()
    }
    
    func setZipcode() {
        guard let exposedLocation = self.locationManager.location else {
            print("*** Error in \(#function): exposedLocation is nil")
            return
        }
        
        getPlace(for: exposedLocation) { placemark in
            guard let placemark = placemark else { return }
            

            if let country = placemark.country {
                if country != "United States" {
                    DispatchQueue.main.async {
                        let alert = UIAlertController(title: "Domain Error", message: "Oops, it looks like \(country) is not currently supported. We apologize for the inconvenience.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Understood", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                print(country)
            }
            
            if let zip = placemark.postalCode {
                print(zip)
                DispatchQueue.main.async {
                    self.zipcodeTextField?.text = zip
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
        
        
    
    @objc func handleShowLogin(_ sender: UITapGestureRecognizer) {
        print("handling sign up")
        let LC = LoginController()
        LC.verified = verified
        navigationController?.pushViewController(LC, animated: true)
    }
    
    func configureViewComponents() {
        view.backgroundColor = Color.shared.theme
        navigationController?.navigationBar.isHidden = true
        
        view.addSubview(scrollView)
        scrollView.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        scrollView.addSubview(logoImageView)
        logoImageView.anchor(top: scrollView.topAnchor, left: nil, bottom: nil, right: nil, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 150, height: 150)
        logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        scrollView.addSubview(nameContainerView)
        nameContainerView.anchor(top: logoImageView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 30, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        scrollView.addSubview(emailContainerView)
        emailContainerView.anchor(top: nameContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        scrollView.addSubview(usernameContainerView)
        usernameContainerView.anchor(top: emailContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        scrollView.addSubview(passwordContainerView)
        passwordContainerView.anchor(top: usernameContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        scrollView.addSubview(zipcodeContainerView)
        zipcodeContainerView.anchor(top: passwordContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 16, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        zipcodeContainerView.addSubview(locationBtn)
        locationBtn.anchor(top: zipcodeContainerView.topAnchor, left: nil, bottom: zipcodeContainerView.bottomAnchor, right: zipcodeContainerView.rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
        
        scrollView.addSubview(loginButton)
        loginButton.anchor(top: zipcodeContainerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 24, paddingLeft: 32, paddingBottom: 0, paddingRight: 32, width: 0, height: 50)
        
        scrollView.addSubview(haveAccountButton)
        haveAccountButton.anchor(top: loginButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, paddingTop: 0, paddingLeft: 32, paddingBottom: 16, paddingRight: 32, width: 0, height: 50)
        
        
        scrollView.addSubview(spinner)
        spinner.anchor(top: zipcodeContainerView.bottomAnchor, left: nil, bottom: nil, right: nil, paddingTop: 2, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 20, height: 20)
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        let h = logoImageView.frame.height + 60 + 146 + 350
        scrollView.contentSize = CGSize(width: view.frame.width, height: h)
        
        configureColorScheme()
        
    }
    
    func configureColorScheme() {
        StatusBarColor.shared.isDark = false
        UIView.animate(withDuration: 0.5, animations: {
             self.setNeedsStatusBarAppearanceUpdate()
        })
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
    
    func showSentEmail() {
        
//        let label = createLbl(text: "Verification email sent. Tap to resend.")
//        label.backgroundColor = .systemGreen
        
        let label = UIButton()

        label.backgroundColor = .systemGreen
        label.setTitleColor(.white, for: .normal)
        label.setTitle("Verification email sent. Tap to resend.", for: .normal)
        label.titleLabel?.font = UIFont.italicSystemFont(ofSize: 15.0)
        label.addTarget(self, action: #selector(sendVerificationEmail), for: .touchUpInside)


        label.titleLabel?.textAlignment = .center
        label.titleLabel?.numberOfLines = 1
        label.titleLabel?.adjustsFontSizeToFitWidth  = true
        label.layer.cornerRadius = 0
        label.titleLabel?.baselineAdjustment = .alignCenters
        label.titleLabel?.lineBreakMode = .byClipping
        
        
        
        
        self.view.addSubview(label)
        
//
        
        view.bringSubviewToFront(label)

        
        label.alpha = 1
        

        label.frame = CGRect(x: 0 ,y: 0, width: self.view.frame.width, height: 20)
        label.center.x = view.center.x

        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {

            label.frame = CGRect(x: 0, y: UIApplication.shared.statusBarFrame.height ?? 25, width: self.view.frame.width, height: 20)
            label.center.x = self.view.center.x
        }, completion: nil)
        

        
        
    }
    
    

}


extension RegisterController : UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // make sure the result is under 16 characters
        return updatedText.count <= 5
    }
}




extension RegisterController: CLLocationManagerDelegate {
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
            setZipcode()
        case .authorizedWhenInUse:
            print("Location auth status is AUTHORIZED WHEN IN USE")
            locationEnabled = true
            setZipcode()
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
            
        }
        if status == .denied || status == .restricted  {
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Location Services Disabled", message: "To enable, go to Settings -> Privacy -> Location Services -> Find My Supply", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Got it", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }

            locationEnabled = false

            
        }
        else {
            locationEnabled = true
            setZipcode()
            
        }
    }
    
    
    
 
    
    
}
    
