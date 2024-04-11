//
//  AvaliadorTests.swift
//  LeilaoTests
//
//  Created by Matheus Cepil Alcatrao on 02/04/24.
//  Copyright © 2024 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

final class AvaliadorTests: XCTestCase {
    private var joao: Usuario!
    private var jose: Usuario!
    private var maria: Usuario!
    private var leiloeiro: Avaliador!
    
    override func setUpWithError() throws {
        leiloeiro = Avaliador()
        joao = Usuario(nome: "Joao")
        jose = Usuario(nome: "Jose")
        maria = Usuario(nome: "Maria")
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testShouldUnderstandBiddingInAscendingOrder() {
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4")
            .lance(joao, 250.0)
            .lance(maria, 300.0)
            .lance(joao, 400.0)
            .constroi()
        
        try? leiloeiro.avalia(leilao: leilao)
        
        XCTAssertEqual(250.0, leiloeiro.menorLance())
        XCTAssertEqual(400.0, leiloeiro.maiorLance())
    }
    
    func testDeveEntenderLeilaoComApenasUmLance() {
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 4")
            .lance(joao, 1000.0)
            .constroi()
        
        try? leiloeiro.avalia(leilao: leilao)
        
        XCTAssertEqual(1000.0, leiloeiro.maiorLance())
    }
    
    func testDeveEncontrarOsTresMaioresLances() {
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 5")
            .lance(joao, 300.0)
            .lance(maria, 400.0)
            .lance(joao, 500.0)
            .lance(maria, 600.0)
            .constroi()
        
        
        try? leiloeiro.avalia(leilao: leilao)
        
        let listaDeLances = leiloeiro.tresMaiores()
        
        XCTAssertEqual(3, listaDeLances.count)
        XCTAssertEqual(600, listaDeLances[0].valor)
        XCTAssertEqual(500, listaDeLances[1].valor)
        XCTAssertEqual(400, listaDeLances[2].valor)
    }
    
    func testDeveIgnorarLeilaoSemNenhumLance() {
        let leilao = CriadorDeLeilao().para(descricao: "Playstation 5").constroi()
        
        XCTAssertThrowsError(try leiloeiro.avalia(leilao: leilao), "Não é possível avaliar um leião sem lances") { error in
            print(error.localizedDescription)
        }
    }
}
