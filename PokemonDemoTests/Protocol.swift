//
//  Protocol.swift
//  PokemonDemoTests
//
//  Created by Shairjeel Ahmed on 16/02/2022.
//

import Foundation
@testable import PokemonDemo
import UIKit

class DummyPokemonCache:CachePokemonProtocol{
	var pokemons: [Pokemon] = []
	init(pokomons:[Pokemon]){
		self.pokemons = pokomons
	}
	func savePokemon(pokemon: Pokemon) {
		
	}
	
	func removePokemon(pokemon: Pokemon) {
		
	}
	
	func getPokemons() -> [Pokemon] {
		return self.pokemons
	}
	
	func saveImageInUserDefault(img: UIImage) {
	}
	
	func getImageFromUserDefault() -> UIImage? {
		return UIImage(named: "pokemon0")
	}
	
	
}
