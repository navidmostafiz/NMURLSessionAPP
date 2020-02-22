//
//  ViewController.swift
//  NMURLSessionAPP
//
//  Created by Navid on 2/22/20.
//  Copyright © 2020 UnitedStar. All rights reserved.
//

import UIKit

class PostViewController: UIViewController {

    @IBOutlet weak var userIDTF: UITextField!
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var bodyTF: UITextField!

    @IBOutlet weak var requestHeadersTA: UITextView!
    @IBOutlet weak var responseHeaderTA: UITextView!
    @IBOutlet weak var responseBodyTA: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func closePostButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func postButtonClicked(_ sender: UIButton) {
        guard let userID = userIDTF.text else { return }
             guard let title = titleTF.text else { return }
             guard let body = bodyTF.text else { return }
             print("post button clicked!")
             callPostAPICall(userID:userID, title:title, body:body)
    }
    
}


extension PostViewController {
    
    private func callPostAPICall(userID:String, title:String, body:String){
        if let apiURL = URL(string: "https://jsonplaceholder.typicode.com/posts/") {
            var request = URLRequest(url: apiURL)
            request.httpMethod = "POST"
            
            let parameters: [String:Any] = [
                "userID": userID,
                "title": title,
                "body": body
            ]
            let jsonData = try? JSONSerialization.data(withJSONObject: parameters)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { (data, httpresponse, error) in
                guard let data = data else {
//                    DispatchQueue.main.sync {
//                        responseBodyTA.text = error!
//                    }
                    print(error as Any)
                    return
                }
                
                if (httpresponse as? HTTPURLResponse) != nil {
//                    DispatchQueue.main.sync {
//                        self.responseHeaderTA.text = String(response.statusCode)
//                    }
//                    print(response)
                }
                
                do {
                    let jsonData = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
                    DispatchQueue.main.sync {

                        for (key, value) in jsonData {
                            if key != "id" {
                                self.responseBodyTA.text = key as String
                            }
                        }
                        
                    }
                    print(jsonData)
                } catch let error {
                    DispatchQueue.main.sync {
                        self.responseBodyTA.text = "invalid json response"
                    }
                    print(error.localizedDescription)
                }
                
                
            }.resume()
        }
    }
}
