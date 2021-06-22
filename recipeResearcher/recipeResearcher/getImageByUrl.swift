//
//  setImageUrl.swift
//  recipeResearcher
//
//  Created by 洞井僚太 on 2021/06/23.
//

import Foundation
import UIKit

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
