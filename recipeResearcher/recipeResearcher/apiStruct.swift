//
//  apiStruct.swift
//  recipeResearcher
//
//  Created by 洞井僚太 on 2021/06/20.
//

import Foundation


struct recipeResult:Codable{
    let result:[rakuten]
}

struct rakuten:Codable{
    let recipeId:Int
    let recipeTitle:String
    let recipeUrl:String
    let foodImageUrl:String!
    let mediumImageUrl:String
    let smallImageUrl:String
    let pickup:Int
    let shop:Int
    let nickname:String
    let recipeDescription:String
    let recipeMaterial:[String]
    let recipeIndication:String
    let recipeCost:String
    let recipePublishday:String
    let rank:String
}

struct categoryResult:Codable{
    let result:category
}

struct category:Codable{
    let large:[categories]
    let medium:[categories]!
    let small:[categories]!
}

struct categories:Codable{
    let categoryId:String
    let categoryName:String
    let categoryUrl:String
}
