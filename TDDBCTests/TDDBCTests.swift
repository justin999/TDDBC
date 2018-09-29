//
//  TDDBCTests.swift
//  TDDBCTests
//
//  Created by Koichi Justin Sato on 2018/09/29.
//  Copyright © 2018 Koichi Justin Sato. All rights reserved.
//

import XCTest
@testable import TDDBC

class TDDBCTests: XCTestCase {
    
    var machine: Machine!

    override func setUp() {
        machine = Machine()
        
    }

    override func tearDown() {
    }
    
    // Q1
    func test_コーラ出る() {
        machine.insert()
        let actual = machine.pushButton(drink: .cola)
        XCTAssertEqual("コーラ", actual)
    }
    
    func test_コーラ出ない() {
        let actual = machine.pushButton(drink: .cola)
        XCTAssertNotEqual("コーラ", actual)
    }
    
    // Q2
    func test_100円投入() {
        machine.insert()
        let actual = machine.inserted
        XCTAssertEqual(true, actual)
    }
    
    // Q3
    func test_コーラボタンを押したらコーラが出ます() {
        machine.insert()
        let actual = machine.pushButton(drink: .cola)
        XCTAssertEqual("コーラ", actual)
    }
    
    func test_ウーロン茶ボタンを押したらウーロン茶が出ます() {
        machine.insert()
        let actual = machine.pushButton(drink: .oolong)
        XCTAssertEqual("ウーロン茶", actual)
    }
    
}

import Foundation
class Machine {
    // 投入金額
    var amount: Int = 0
    var inserted: Bool = false
    
    enum Drink: String {
        case cola    = "コーラ"
        case oolong  = "ウーロン茶"
        case ginger  = "ジンジャーエール"
    }
    
    func pushButton(drink: Drink) -> String? {
        if inserted {
            return drink.rawValue
        } else {
            return nil
        }
    }
    
    func insert() {
        self.inserted = true
    }
    
}
