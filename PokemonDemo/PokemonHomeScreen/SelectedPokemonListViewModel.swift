//
//  SelectedPokemonListViewModel.swift
//  PokemonDemo
//
//  Created by Shairjeel Ahmed on 14/02/2022.
//

import Foundation

class SelectedPokemonListViewModel{
	var pokemons: [Pokemon]{
		return cachePokemon.getPokemons()
	}
	
	weak var delegate:SelectedPokemonViewProtocol?

	var cachePokemon:CachePokemonProtocol
	var searchedPokemon:[Pokemon] = []{
		didSet{
			pokemonsDidChange?(searchedPokemon)
		}
	}

	var query:String?{
		didSet{
			if query != nil{
				self.filterArray(query:query!)
				quering = true
			}else{
				quering = false
				self.delegate?.reloadSelectedPokemonView()
			}
		}
	}
	private var quering:Bool = false
	
	
	init(cachePokemon:CachePokemonProtocol,selectedPokemonViewProtocol:SelectedPokemonViewProtocol){
		self.cachePokemon = cachePokemon
		self.delegate = selectedPokemonViewProtocol
	}
	var pokemonsDidChange:(([Pokemon]) -> ())?

	var numberOfSection:Int{
		return 1
	}
	
	var numberOfRows:Int{
		return self.quering == false ? cachePokemon.pokemons.count : self.searchedPokemon.count
	}
	
	func viewModel(for index: Int) -> PokemonListViewModel {
		let pokemonArray =  quering == false  ? cachePokemon.pokemons : self.searchedPokemon
		let pokemon = pokemonArray[index]
		return PokemonListViewModel.init(pokemon: pokemon)
	}
	
	func filterArray(query:String){
		let filteredArray = self.cachePokemon.pokemons.filter { $0.name!.localizedCaseInsensitiveContains(query)}
		self.searchedPokemon.removeAll()
		self.searchedPokemon.append(contentsOf: filteredArray)
	}
	
}
