//
//  LeilaoTests.swift
//  LeilaoTests
//
//  Created by Ândriu Coelho on 27/04/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class LeilaoTests: XCTestCase {
    private var leticia: Usuario!
    private var lucas: Usuario!
    private var maria: Usuario!
    private var jose: Usuario!
    
    override func setUp() {
        super.setUp()
        leticia = Usuario(nome: "Leticia")
        lucas = Usuario(nome: "Lucas")
        maria = Usuario(nome: "Maria")
        jose = Usuario(nome: "Jose")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testeDeveReceberUmLance() {
        let leilao = Leilao(descricao: "Playstation 5")
        XCTAssertEqual(0, leilao.lances?.count)
        
        
        leilao.propoe(lance: Lance(lucas, 2000))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000, leilao.lances?.first?.valor)
    }
    
    func testDeveReceberVariosLances() {
        let leilao = Leilao(descricao: "Macbook")
        
        leilao.propoe(lance: Lance(leticia, 2000))
        leilao.propoe(lance: Lance(lucas, 3000))
        
        
        XCTAssertEqual(2, leilao.lances?.count)
        XCTAssertEqual(2000, leilao.lances?.first?.valor)
        XCTAssertEqual(3000, leilao.lances?[1].valor)
    }
    
    func testDeveIgonorarDoisLancesSeguidosDoMesmoUsuario() {
        let leilao = Leilao(descricao: "Macbook air")
        
        leilao.propoe(lance: Lance(maria, 2000))
        leilao.propoe(lance: Lance(maria, 3000))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000, leilao.lances?.first?.valor)
    }
    
    func testDeveIgonorarMaisDoQue5LancesDoMesmoUsuario() {
        let leilao = Leilao(descricao: "Macbook Pro 16 - m1")
        
        let jose = Usuario(nome: "Jose")
        let maria = Usuario(nome: "Maria")
        
        leilao.propoe(lance: Lance(jose, 2000))
        leilao.propoe(lance: Lance(maria, 3000))
        
        leilao.propoe(lance: Lance(jose, 4000))
        leilao.propoe(lance: Lance(maria, 5000))
        
        leilao.propoe(lance: Lance(jose, 6000))
        leilao.propoe(lance: Lance(maria, 7000))
        
        leilao.propoe(lance: Lance(jose, 8000))
        leilao.propoe(lance: Lance(maria, 9000))
        
        leilao.propoe(lance: Lance(jose, 10000))
        leilao.propoe(lance: Lance(maria, 11000))
        
        // IGNORAR:
        leilao.propoe(lance: Lance(jose, 12000))
        
        XCTAssertEqual(10, leilao.lances?.count)
        XCTAssertEqual(11000, leilao.lances?.last?.valor)
    }
}
