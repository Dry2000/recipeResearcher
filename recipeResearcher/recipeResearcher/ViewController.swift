//
//  ViewController.swift
//  recipeResearcher
//
//  Created by 洞井僚太 on 2021/06/20.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {
    var response : categoryResult?
    let request = categoryRequest()
    @IBAction func transition(_ sender: Any) {
        performSegue(withIdentifier: "toCategoryViewController",sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        request.getCategoryResponse(callBackClosure: setResponse)

        
        
    }
    func setResponse(){
        response = request.result
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "toCategoryViewController") {
                let vc2: categoryViewController = (segue.destination as? categoryViewController)!
                vc2.categoryResponse = response
            }
        }
    }




