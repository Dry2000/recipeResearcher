//
//  recipeInfoViewController.swift
//  recipeResearcher
//
//  Created by 洞井僚太 on 2021/06/21.
//

import Foundation
import UIKit

class recipeInfoViewController:UIViewController,UITableViewDelegate,UITableViewDataSource{

    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeMaterial: UITableView!
    var recipe:rakuten?
    override func viewDidLoad() {
        recipeName.text = recipe?.recipeTitle
        recipeName.lineBreakMode = .byCharWrapping
        recipeName.numberOfLines = 0
        recipeImage.image = getImageByUrl(url:(recipe?.foodImageUrl)!)
        recipeMaterial.delegate = self
        recipeMaterial.dataSource = self
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (recipe?.recipeMaterial.count)!+2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        if indexPath.row == 0{
            cell.textLabel?.text = "制作時間:\(recipe!.recipeIndication)\n材料一覧"
            return cell
        }else if indexPath.row == (recipe?.recipeMaterial.count)!+1{
            cell.textLabel?.text = "タップしてレシピのページへ"
            return cell
        }
        cell.textLabel?.text = recipe?.recipeMaterial[indexPath.row-1]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == (recipe?.recipeMaterial.count)!+1{
            self.performSegue(withIdentifier: "toOriginalPage", sender: Any?.self)
        }
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "toOriginalPage") {
                let vc2:originalPageViewController = (segue.destination as? originalPageViewController)!
                vc2.targetUrl = recipe?.recipeUrl
            }
        }
    func getImageByUrl(url: String) -> UIImage{
        let url = URL(string: url)
        do {
            let data = try Data(contentsOf: url!)
            return UIImage(data: data)!
        } catch let err {
            print("Error : \(err.localizedDescription)")
        }
        return UIImage()
    }
    
}
