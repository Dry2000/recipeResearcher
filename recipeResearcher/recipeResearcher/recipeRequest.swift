//
//  request.swift
//  recipeResearcher
//
//  Created by 洞井僚太 on 2021/06/20.
//

import Foundation
import Alamofire
import SwiftyJSON

class recipeRequest{
    var result:recipeResult?
    func getRecipeResponse(id:String,callBackClosure:@escaping () -> Void){
        let apiKey = Key()
        let url = "https://app.rakuten.co.jp/services/api/Recipe/CategoryRanking/20170426?applicationId=\(apiKey.key!)&categoryId=\(id)"
        AF.request(url,method: .get).responseJSON{response in
            switch response.result{
            case .success:
                guard let json = response.data else{return}
                let decoder:JSONDecoder = JSONDecoder()
                do{
                    let access_resp:recipeResult = try decoder.decode(recipeResult.self,from:json)
                    self.result = access_resp
                    callBackClosure()
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
