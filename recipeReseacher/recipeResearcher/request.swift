//
//  request.swift
//  recipeResearcher
//
//  Created by 洞井僚太 on 2021/06/20.
//

import Foundation
import Alamofire
import SwiftyJSON

func request(){
    let apiKey = Key()
    let url = "https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?applicationId=\(apiKey.key!)&categoryType=large"
    AF.request(url,method: .get).responseJSON{response in
        switch response.result{
        case .success:
            let decoder:JSONDecoder = JSONDecoder()
            do{
                let access_resp = try decoder.decode(categoryResult.self,from:response.data!)
                print(access_resp)
   

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
