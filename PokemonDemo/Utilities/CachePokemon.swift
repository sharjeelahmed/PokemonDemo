//
//  CachePokemon.swift
//  PokemonDemo
//
//  Created by Shairjeel Ahmed on 10/02/2022.
//

import Foundation
import UIKit

protocol CachePokemonProtocol{
	var pokemons:[Pokemon]{
		get
	}
	func savePokemon(pokemon:Pokemon)
	func removePokemon(pokemon:Pokemon)
	func getPokemons()->[Pokemon]
	func saveImageInUserDefault(img:UIImage)
	func getImageFromUserDefault() -> UIImage?
}
class CachePokemon:CachePokemonProtocol{
	
	let userDefaults = UserDefaults.standard
	var pokemons: [Pokemon]{
		get{
			self.getPokemons()
		}
	}
	 func savePokemon(pokemon:Pokemon){
		let userDefaults = UserDefaults.standard
		guard let name = pokemon.name else{
			return
		}
	   var strings: [String] = userDefaults.stringArray(forKey: UserDefaultsKeys.pokemons) ?? []
		if !strings.contains(name){
			strings.append(name)
			userDefaults.set(strings, forKey: UserDefaultsKeys.pokemons)
		}
	}
	
	func removePokemon(pokemon:Pokemon){
		let userDefaults = UserDefaults.standard
		guard let name = pokemon.name else{
			return
		}
		var strings: [String] = userDefaults.stringArray(forKey: UserDefaultsKeys.pokemons) ?? []
		if let index = strings.firstIndex(where: {$0 == name}){
			strings.remove(at: index)
		}
		userDefaults.set(strings, forKey: UserDefaultsKeys.userImage)
	}
	
	func getPokemons()->[Pokemon]{
		let userDefaults = UserDefaults.standard
		let pokemonsName: [String] = userDefaults.stringArray(forKey: UserDefaultsKeys.pokemons) ?? []
		let pokemons = pokemonsName.map{Pokemon.init(object: ["name":$0,"imageName":"pokemon\(Int.random(in: 0...9))"])}
		return pokemons
		
	}
	
	func saveImageInUserDefault(img:UIImage) {
		UserDefaults.standard.set(img.pngData(), forKey:  UserDefaultsKeys.userImage)
	}

	func getImageFromUserDefault() -> UIImage? {
		let imageData = UserDefaults.standard.object(forKey:  UserDefaultsKeys.userImage) as? Data
		var image: UIImage? = nil
		if let imageData = imageData {
			image = UIImage(data: imageData)
		}
		return image
	}
	
	
}

