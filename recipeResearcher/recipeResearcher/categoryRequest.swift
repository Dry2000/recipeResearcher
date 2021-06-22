//
//  categoryRequest.swift
//  recipeResearcher
//
//  Created by 洞井僚太 on 2021/06/23.
//

import Foundation
import Alamofire
import SwiftyJSON

class categoryRequest{
    var result:categoryResult?
    func getCategoryResponse(callBackClosure:@escaping () -> Void){
        let apiKey = Key()
        var access_resp:categoryResult?
        let url = "https://app.rakuten.co.jp/services/api/Recipe/CategoryList/20170426?applicationId=\(apiKey.key!)&categoryType=large"
        AF.request(url,method: .get).responseJSON{response in
            switch response.result{
            case .success:
                let decoder:JSONDecoder = JSONDecoder()
                do{
                    access_resp = try decoder.decode(categoryResult.self,from:response.data!)
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
