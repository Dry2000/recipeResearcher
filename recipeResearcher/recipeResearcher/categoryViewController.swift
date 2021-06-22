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
    var categoryResponse:categoryResult?
    var recipeResponse:recipeResult?
    let request = recipeRequest()
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
        if categoryResponse == nil{
            return 1
        }
        return categoryResponse!.result.large.count
    }
    func numberOfSections(in tableView: UITableView) -> Int {
      return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        if categoryResponse == nil{
            cell.textLabel?.text = "Loading..."
            return cell
        }
        cell.textLabel?.text = categoryResponse!.result.large[indexPath.row].categoryName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        request.getRecipeResponse(id:(categoryResponse?.result.large[indexPath.row].categoryId)!, callBackClosure: toRecipeListTransition)
        //getResponse(id:categoryResponse?.result.large[indexPath.row].categoryId)
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "toRecipeListViewController") {
                let vc2: recipeListViewController = (segue.destination as? recipeListViewController)!
                vc2.recipeList = recipeResponse
            }
        }
    func toRecipeListTransition(){
        recipeResponse = request.result
        self.performSegue(withIdentifier: "toRecipeListViewController", sender: nil)
    }
}
