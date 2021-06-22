//
//  categoryViewController.swift
//  recipeResearcher
//
//  Created by 洞井僚太 on 2021/06/21.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class categoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var resp:categoryResult?
    var recipeResponse:recipeResult?
    var tappedRow:Int = 0
    @IBOutlet weak var categoryList: UITableView!
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    override func viewDidLoad() {
        categoryList.dataSource = self
        categoryList.delegate = self
        categoryList.isUserInteractionEnabled = true
        categoryList.allowsSelection = true
        categoryList.reloadData()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if resp == nil{
            return 1
        }
        return resp!.result.large.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        if resp == nil{
            cell.textLabel?.text = "Loading..."
            return cell
        }
        cell.textLabel?.text = resp!.result.large[indexPath.row].categoryName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tappedRow = indexPath.row
            request()
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "toRecipeListViewController") {
                let vc2: recipeListViewController = (segue.destination as? recipeListViewController)!
                
                vc2.recipeList = recipeResponse
                print(vc2.recipeList)
            }
        }
    func request(){
        let apiKey = Key()
        guard let id = resp?.result.large[tappedRow].categoryId else{ return}
        let url = "https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=\(apiKey.key!)&categoryId=\(id)"
        AF.request(url,method: .get).responseJSON{response in
            switch response.result{
            case .success:
                guard let json = response.data else{return}
                let decoder:JSONDecoder = JSONDecoder()
                do{
                    let access_resp:recipeResult = try decoder.decode(recipeResult.self,from:json)
                 //   print(access_resp)
                    self.recipeResponse=access_resp
                    self.performSegue(withIdentifier: "toRecipeListViewController", sender: nil)
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
    
}
