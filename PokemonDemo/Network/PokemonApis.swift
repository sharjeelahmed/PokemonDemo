//
//  QavaShopNetworkApi.swift
//  QavaShop
//
//  Created by Shairjeel Ahmed on 19/04/2019.
//  Copyright © 2019 Shairjeel Ahmed. All rights reserved.
//

import Foundation
import Moya
import Alamofire
import UIKit

enum PokemonApis {
	case getPokemon(parameters:Parameters)
}


extension PokemonApis:TargetType{
	
	var baseURL: URL {
		guard let url = URL(string: "https://pokeapi.co/api/v2/")else{fatalError("baseUrl could not be configured")}
		return url
	}
	
	var path: String {
		switch self {
		case .getPokemon: return "pokemon";
		}
	}
	
	var method: Moya.Method {
		switch self {
		case .getPokemon:
			return .get
		}
	}
	
	var sampleData: Data {
		return Data()
	}
	
	var task: Task {
		switch self {
		case .getPokemon(let parameters):
			return .requestParameters(parameters:parameters, encoding: URLEncoding.default )
		}
	}
	
	var headers: [String : String]? {
		switch self {
		default:
			return nil
		}
	}
	
	var validationType: ValidationType{
		switch self{
		default:
			return .successCodes
		}
	}
}
