//
//  MRangelEcommerceTests.swift
//  MRangelEcommerceTests
//
//  Created by MacBookMBA5 on 17/01/23.
//

import XCTest
@testable import MRangelEcommerce

final class MRangelEcommerceTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testDepaAddCorrect() throws {
        let depaViewModel = DepartamentoViewModel()
        let result = depaViewModel.AddDepa(departamento: Departamento(IdDepartamento: 0, Nombre: "Testing", Area: Area(IdArea: 1, Nombre: "")))
        XCTAssertFalse(result.Correct, result.ErrorMessage)
    }
    
    func testDepaAddIncorrect() throws {
        let depaViewModel = DepartamentoViewModel()
        let result = depaViewModel.AddDepa(departamento: Departamento(IdDepartamento: 0, Nombre: "Testing", Area: Area(IdArea: 1, Nombre: "test")))
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    func testDepaUpdateCorrect() throws {
        let depaViewModel = DepartamentoViewModel()
        let result = depaViewModel.UpdateDepa(departamento: Departamento(IdDepartamento: 1, Nombre: "Testing", Area: Area(IdArea: 1, Nombre: "")), IdUpdate: 1)
        XCTAssertFalse(result.Correct, result.ErrorMessage)
    }
    
    func testDepaUpdateIncorrect() throws {
        let depaViewModel = DepartamentoViewModel()
        let result = depaViewModel.UpdateDepa(departamento: Departamento(IdDepartamento: 50, Nombre: "Testing", Area: Area(IdArea: 1, Nombre: "")), IdUpdate: 50)
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    func testDepaDeleteCorrect() throws {
        let depaViewModel = DepartamentoViewModel()
        let result = depaViewModel.Delete(IdDelete: 3)
        XCTAssertFalse(result.Correct, result.ErrorMessage)
    }
    
    func testDepaDeleteIncorrect() throws {
        let depaViewModel = DepartamentoViewModel()
        let result = depaViewModel.Delete(IdDelete: 3)
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    func testDepaGetAllCorrect() throws{
        let depaViewModel = DepartamentoViewModel()
        let result = depaViewModel.GetAll()
        XCTAssertFalse(result.Correct, result.ErrorMessage)
    }
    
    func testDepaGetAllIncorrect() throws{
        let depaViewModel = DepartamentoViewModel()
        let result = depaViewModel.GetAll()
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    func testDepaGetByIdCorrect() throws{
        let depaViewModel = DepartamentoViewModel()
        let result = depaViewModel.GetById(IdGetById: 2)
        XCTAssertFalse(result.Correct, result.ErrorMessage)
    }
    
    func testDepaGetByIdIncorrect() throws{
        let depaViewModel = DepartamentoViewModel()
        let result = depaViewModel.GetById(IdGetById: 2)
        XCTAssertTrue(result.Correct, result.ErrorMessage)
    }
    
    
    
    
    

    //func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    //}

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
