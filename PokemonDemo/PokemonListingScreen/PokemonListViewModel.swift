//
//  PokemonListViewModel.swift
//  PokemonDemo
//
//  Created by Shairjeel Ahmed on 10/02/2022.
//

import Foundation

protocol PokemonPresentable{
	var Name:String{get}
	var ImageName:String{get}
}

struct PokemonListViewModel:PokemonPresentable{
	let pokemon : Pokemon
	var Name:String{
		return pokemon.name ?? ""
	}
	var ImageName:String{
		let random = Int.random(in: 0...9)
		return pokemon.imageName ?? "pokemon\(random)"
	}
}
