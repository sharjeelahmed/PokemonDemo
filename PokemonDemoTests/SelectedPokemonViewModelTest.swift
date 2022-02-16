//
//  SelectedPokemonViewModelTest.swift
//  PokemonDemoTests
//
//  Created by Shairjeel Ahmed on 16/02/2022.
//

import XCTest
@testable import PokemonDemo

class SelectedPokemonListViewModelTest: XCTestCase {
	func testNumberOfRows(){
		let pokemons = Pokemon.init(object: ["name":"a"])
		let pokemons2 = Pokemon.init(object: ["name":"a"])
		let pokemonCache = DummyPokemonCache.init(pokomons: [pokemons,pokemons2])
		let dummySelectedPokemonProtocol = DummySelectedPokemonProtocol()
		let viewModel = SelectedPokemonListViewModel.init(cachePokemon: pokemonCache, selectedPokemonViewProtocol: dummySelectedPokemonProtocol)
		XCTAssertEqual(viewModel.numberOfRows, 2)
	}
	
	func testNumberOfRowsWithQuering(){
		let pokemons = Pokemon.init(object: ["name":"a"])
		let pokemons2 = Pokemon.init(object: ["name":"a"])
		let query = "a"
		let pokemonCache = DummyPokemonCache.init(pokomons: [pokemons,pokemons2])
		let dummySelectedPokemonProtocol = DummySelectedPokemonProtocol()
		let viewModel = SelectedPokemonListViewModel.init(cachePokemon: pokemonCache, selectedPokemonViewProtocol: dummySelectedPokemonProtocol)
		viewModel.query = query
		
		XCTAssertEqual(viewModel.numberOfRows, 2)
	}
}

class DummySelectedPokemonProtocol:SelectedPokemonViewProtocol{
	func reloadSelectedPokemonView(){
		
	}

}
