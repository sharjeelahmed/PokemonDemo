//
//  PokemonService.swift
//  PokemonDemo
//
//  Created by Shairjeel Ahmed on 10/02/2022.
//

import Foundation
import Moya
import SwiftyJSON
import Alamofire

class PokemonService{
	static let provider = MoyaProvider<PokemonApis>()
	
	static func getPokemonList(parameters:Parameters, completionHandler:@escaping (_ success:Bool,_ response:JSON)->Void){
		provider.request(.getPokemon(parameters: parameters)) { (result) in
			switch result{
			case let .success(moyaResponse):
				if let responseJson =  JSON(rawValue: moyaResponse.data){
					completionHandler(true, responseJson)
				}
			case let .failure(error):
				print(error.errorCode)
				completionHandler(false,  JSON(rawValue: error.localizedDescription)!)
				print("Request failed with error: \(error.localizedDescription)")
				print(error)
			}
		}
	}
}
