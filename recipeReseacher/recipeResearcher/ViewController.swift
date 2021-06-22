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

    @IBAction func transition(_ sender: Any) {
        performSegue(withIdentifier: "toCategoryViewController",sender: nil)
    }
    var resp : categoryResult?
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let apiKey = Key()
        let url = "https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?applicationId=\(apiKey.key!)&categoryType=large"
        AF.request(url,method: .get).responseJSON{response in
            switch response.result{
            case .success:
                let decoder:JSONDecoder = JSONDecoder()
                do{
                    let access_resp = try decoder.decode(categoryResult.self,from:response.data!)
                    self.resp = access_resp
                }catch{
                    print(response)
                    print("JSON convert failed",error.localizedDescription)
                }
                break
            case .failure(let ERROR):
                print(ERROR)
                break
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "toCategoryViewController") {
                let vc2: categoryViewController = (segue.destination as? categoryViewController)!
                vc2.resp = resp
            }
        }
    }




