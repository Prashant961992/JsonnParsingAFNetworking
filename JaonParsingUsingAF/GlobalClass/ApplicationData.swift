//
//  ApplicationData.swift
//  VGL Swift
//
//  Created by Chetna Ranipa on 10/10/17.
//  Copyright © 2017 Chetna Ranipa. All rights reserved.
//

import UIKit

class ApplicationData: NSObject {
    static let sharedInstance = ApplicationData()
    
    var DeviceInfo = NSMutableDictionary()
    var arrQueryData = NSArray()
    var arrSubjectData = NSArray()
    var arrOfmapListdata = NSArray()
    
    func MainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    func getUserdefault(filename : String) -> NSDictionary {
        let documentsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = documentsDir.appending(filename)
        return NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as! NSDictionary
    }
    
    func saveUserdefault(filename : String, arrayObject : NSDictionary)  {
        let documentsDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let filePath = documentsDir.appending(filename)
        NSKeyedArchiver.archiveRootObject(arrayObject, toFile: filePath)
    }

    func checkDictionary(dic1 : NSDictionary) -> NSMutableDictionary {
        let Arr : NSArray = dic1.allKeys as NSArray
        var dic : NSMutableDictionary = dic1.mutableCopy() as! NSMutableDictionary
        for i in 0..<Arr.count {
            let key = Arr.object(at: i)
            let data = dic.value(forKey: key as! String ) as Any
            let value = dic.value(forKey: key as! String)
            if (value == nil || value is NSNull) {
                dic.setValue("", forKey: key as! String)
            } else if data is NSDictionary {
                let dict : NSMutableDictionary = dic.object(forKey: key) as! NSMutableDictionary
                dic[Arr[i]] = dict
                dic = checkDictionary(dic1: dict)
            } else if data is NSMutableArray {
                let Arr12 : NSMutableArray = dic.value(forKey: key as! String) as! NSMutableArray
                for j in 0..<Arr12.count {
                    let data1 = Arr12.object(at: j) as Any
                    if data1 is NSDictionary {
                        let dict : NSMutableDictionary = data1 as! NSMutableDictionary
                        Arr12.replaceObject(at: j, with: dict)
                        dic = self.checkDictionary(dic1: dict)
                    }
                }
            }
        }
        return dic
    }
    
    func checkAndReplaceWithDashDictionary(dic1 : NSDictionary) -> NSMutableDictionary {
        let Arr : NSArray = dic1.allKeys as NSArray
        var dic : NSMutableDictionary = dic1.mutableCopy() as! NSMutableDictionary
        for i in 0..<Arr.count {
            let key = Arr.object(at: i)
            let data = dic.value(forKey: key as! String ) as Any
            let value = dic.value(forKey: key as! String)
            if (value == nil || value is NSNull) {
                dic.setValue("-", forKey: key as! String)
            } else if data is NSDictionary {
                let dict : NSMutableDictionary = dic.object(forKey: key) as! NSMutableDictionary
                dic[Arr[i]] = dict
                dic = checkDictionary(dic1: dict)
            } else if data is NSMutableArray {
                let Arr12 : NSMutableArray = dic.value(forKey: key as! String) as! NSMutableArray
                for j in 0..<Arr12.count {
                    let data1 = Arr12.object(at: j) as Any
                    if data1 is NSDictionary {
                        let dict : NSMutableDictionary = data1 as! NSMutableDictionary
                        Arr12.replaceObject(at: j, with: dict)
                        dic = self.checkDictionary(dic1: dict)
                    }
                }
            }
        }
        return dic
    }
    
    func userIdget() -> String {
        
        if let strUserID = UserDefaults.standard.string(forKey: "CONSUMER_NUMBER") {
            return strUserID
        } else {
            return "0"
        }
    }
    
    func alertView(title : String , msg : String, view : UIViewController)  {
        let alert = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        view.present(alert, animated: true, completion: nil)
    }
    
    func getDateTimeFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss"
        return dateFormatter
    }
    
    func getDateFormatter() -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMM yyyy"
        return dateFormatter
    }
  
//    func payPalConfiguration(viewController : UIViewController, navigation : UINavigationController) {
//        let payPalConfig = PayPalConfiguration()
//        payPalConfig.acceptCreditCards = true
//        payPalConfig.merchantName = "Awesome Shirts, Inc."
//        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
//        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
//
//        // Setting the languageOrLocale property is optional.
//        //
//        // If you do not set languageOrLocale, then the PayPalPaymentViewController will present
//        // its user interface according to the device's current language setting.
//        //
//        // Setting languageOrLocale to a particular language (e.g., @"es" for Spanish) or
//        // locale (e.g., @"es_MX" for Mexican Spanish) forces the PayPalPaymentViewController
//        // to use that language/locale.
//        //
//        // For full details, including a list of available languages and locales, see PayPalPaymentViewController.h.
//
//        payPalConfig.languageOrLocale = Locale.preferredLanguages[0]
//
//        // Setting the payPalShippingAddressOption property is optional.
//        //
//        // See PayPalConfiguration.h for details.
//
//        payPalConfig.payPalShippingAddressOption = .payPal;
//
//        print("PayPal iOS SDK Version: \(PayPalMobile.libraryVersion())")
//        let item1 = PayPalItem(name: "Old jeans with holes", withQuantity: 1, withPrice: NSDecimalNumber(string: "50.00"), withCurrency: "USD", withSku: "Hip-0037")
//
//        let items = [item1]
//        let subtotal = PayPalItem.totalPrice(forItems: items)
//
//        // Optional: include payment details
//        let shipping = NSDecimalNumber(string: "5.00")
//        let tax = NSDecimalNumber(string: "2.50")
//        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
//        let total = subtotal.adding(shipping).adding(tax)
//        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "Donate", intent: .sale)
//
//        payment.items = items
//        payment.paymentDetails = paymentDetails
//
//        if (payment.processable) {
//            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: viewController as! PayPalPaymentDelegate)
//            navigation.present(paymentViewController!, animated: true, completion: nil)
//        }
//        else {
//            // This particular payment will always be processable. If, for
//            // example, the amount was negative or the shortDescription was
//            // empty, this payment wouldn't be processable, and you'd want
//            // to handle that here.
//            print("Payment not processalbe: \(payment)")
//        }
//    }

}


