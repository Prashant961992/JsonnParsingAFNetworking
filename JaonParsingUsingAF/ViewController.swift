//
//  ViewController.swift
//  JaonParsingUsingAF
//
//  Created by Prashant Prajapati on 07/05/17.
//  Copyright © 2017 Prashant Prajapati. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        WebServiceCallClass.fetchCategoryData(nil, completionHandler:
            { (_ data : Any) -> Void in
                print(data)
//        appDel.arrayOfData = (data as AnyObject) as! NSArray
                
//                for i in 0...appDel.arrayOfData.count-1
//                {
//                    let name = ((appDel.arrayOfData.object(at: i) as! NSDictionary).object(forKey: "category") as! NSDictionary).object(forKey: "name") as! String
//                    let id = ((appDel.arrayOfData.object(at: i) as! NSDictionary).object(forKey: "category") as! NSDictionary).object(forKey: "id") as! String
//                    let alias = ((appDel.arrayOfData.object(at: i) as! NSDictionary).object(forKey: "category") as! NSDictionary).object(forKey: "alias") as! String
//                    let arrpost = ((appDel.arrayOfData.object(at: i) as! NSDictionary).object(forKey: "post") as! NSArray)
//                    
//                    appDel.arrOfCategoryname.addObjects(from: [name as Any])
//                    appDel.arrOfCategoryid.addObjects(from: [id as Any])
//                    appDel.arrOfCategoryalias.addObjects(from: [alias as Any])
//                    
//                    appDel.arrofPostCategory.addObjects(from: [arrpost as Any])
//                }
        },
        failureHandler: { (_ error: Error?) -> Void in
            print(error?.localizedDescription as Any)
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

