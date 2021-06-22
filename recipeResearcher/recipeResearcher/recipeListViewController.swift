//
//  recipeListViewController.swift
//  recipeResearcher
//
//  Created by 洞井僚太 on 2021/06/21.
//

import Foundation
import UIKit

class recipeListViewController:UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    var recipeList:recipeResult?
    var timer:Timer!
    var tappedPath :Int!
    @IBOutlet weak var recipeImages: UICollectionView!
    override func viewDidLoad() {
        recipeImages.delegate = self
        recipeImages.dataSource = self
        recipeImages.isUserInteractionEnabled = true
        recipeImages.allowsSelection = true
        //print(recipeList)
        timer = Timer.scheduledTimer(withTimeInterval:1, repeats: true, block: {_ in
            self.checkData()
        })
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.frame.width, height: 120)
        recipeImages.collectionViewLayout = layout
    }
    func checkData(){
        if recipeList == nil{
            return
        }
        timer.invalidate()
        recipeImages.reloadData()
        print(recipeList)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if recipeList == nil{
            return 1
        }
        return (recipeList?.result.count)!
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let Cell:UICollectionViewCell =
        collectionView.dequeueReusableCell(withReuseIdentifier: "Cell",for: indexPath)
        if recipeList == nil{
            return Cell
        }
        if(recipeList!.result[indexPath.row].foodImageUrl != nil){
            // Tag番号を使ってImageViewのインスタンス生成
            let imageView = Cell.contentView.viewWithTag(1) as! UIImageView
            // 画像配列の番号で指定された要素の名前の画像をUIImageとする
    
            let cellImage = getImageByUrl(url:(recipeList?.result[indexPath.row].foodImageUrl)!)
            // UIImageをUIImageViewのimageとして設定
            imageView.image = cellImage
        }
         
        let label = Cell.contentView.viewWithTag(2) as! UILabel
        label.text = recipeList?.result[indexPath.row].recipeTitle
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return Cell
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
            // section数は１つ
            return 1
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            tappedPath = indexPath.row
            performSegue(withIdentifier: "toRecipeInfoViewController", sender: nil)
        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if (segue.identifier == "toRecipeInfoViewController") {
                let vc:recipeInfoViewController = (segue.destination as? recipeInfoViewController)!
                vc.recipe = recipeList?.result[tappedPath]
                
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
