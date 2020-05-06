//
//  Gold.swift
//  Find My Supply
//
//  Created by Ludovico Veniani on 5/4/20.
//  Copyright © 2020 Ludovico Veniani. All rights reserved.
//

import Foundation
import StoreKit

class Gold: NSObject {
    
    public override init() {}
    
    static let shared = Gold()
    
    var subscriptions = [SKProduct]()
    
    let paymentQueue = SKPaymentQueue.default()
    
    
    func getProducts() {
        let products: Set = [GoldSubscription.twelveMonths.rawValue,
                             GoldSubscription.sixMonths.rawValue,
                             GoldSubscription.oneMonth.rawValue]
        
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
    }
    
    func purchase(subscription: GoldSubscription) {
        guard let subscriptionToPurchase = subscriptions.filter({  $0.productIdentifier == subscription.rawValue }).first else {return}
        
        let payment = SKPayment(product: subscriptionToPurchase)
        paymentQueue.add(payment)
        
        paymentQueue.add(self)
    }
    
    func restorePurchases() {
        paymentQueue.restoreCompletedTransactions()
    }
    
    
}

extension Gold: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print("===IN reQ")
        self.subscriptions = response.products
//        for product in response.products {
//            print("===\(product.localizedTitle)")
//        }
    }
    
    
}

extension Gold: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                break
            case .purchased:
    
                print("=====Finished purchasing \(transaction.payment.productIdentifier)")
                
                //Verify Recipt
                if let appStoreReceiptURL = Bundle.main.appStoreReceiptURL,
                    FileManager.default.fileExists(atPath: appStoreReceiptURL.path) {

                    do {
                        let receiptData = try Data(contentsOf: appStoreReceiptURL, options: .alwaysMapped)
                        print(receiptData)

                        let receiptString = receiptData.base64EncodedString(options: [])

                        // Read receiptData
                        UpdateUser.shared.recipt = receiptString
                        DispatchQueue.global(qos: .userInitiated).async {
                            UpdateUser.shared.verifyRecipt { (result) in
                                switch result {
                                case .success(let status):
                                    if status {
                                        print("=====verified recipt")
                                        UserDefaults.standard.set(true, forKey: "isGold")
                                    } else {
                                        print("=====Unverified recipt")
                                        
                                    }
                                case .failure(let error):
                                    print("DEBUG: Failed with error \(error)")
                                }
                            }
                            //Finish transaction
                            queue.finishTransaction(transaction)
                            
                        }
                    }
                    catch { print("======Couldn't read receipt data with error: " + error.localizedDescription) }
                } else {
                    print("=====An error has occurred")
                }
                
                
                
                
             
                
            case .restored:
                print("====restored")
                
                queue.finishTransaction(transaction)
                
                
            default:
                queue.finishTransaction(transaction)
                print("=====Exited purchasing \(transaction.payment.productIdentifier)")

                
            }
        }
    }
    
    
}


