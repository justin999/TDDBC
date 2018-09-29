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
    
    func test_2回買うことはできない() {
        machine.insert()
        _ = machine.pushButton(drink: .cola)
        let actual = machine.pushButton(drink: .cola)
        XCTAssertEqual(nil, actual)
    }
    
    func test_コーラ出ない() {
        let actual = machine.pushButton(drink: .cola)
        XCTAssertNotEqual("コーラ", actual)
    }
    
    // Q2
    func test_100円投入() {
        machine.insert()
        let actual = machine.amount
        XCTAssertEqual(100, actual)
    }
    
    // Q3
    func test_コーラボタンを押したらコーラが出ます() {
        machine.insert()
        let actual = machine.pushButton(drink: .cola)
        XCTAssertEqual("コーラ", actual)
    }
    
    func test_ウーロン茶ボタンを押したらウーロン茶が出ます() {
        machine.insert()
        machine.insert()
        let actual = machine.pushButton(drink: .oolong)
        XCTAssertEqual("ウーロン茶", actual)
    }
    
    // Q4
    
    func test_200円入れられる() {
        machine.insert()
        machine.insert()
        let actual = machine.amount
        XCTAssertEqual(200, actual)
    }
    
    func test_レッドブルが買える() {
        machine.insert()
        machine.insert()
        let actual = machine.pushButton(drink: .redbull)
        XCTAssertEqual("レッドブル", actual)
    }
    
    func test_レッドブルは100円で買えない() {
        machine.insert()
        let actual = machine.pushButton(drink: .redbull)
        XCTAssertEqual(nil, actual)
    }
    
    func test_100円入れるとコーラとジンジャーエールが光る() {
        machine.insert()
        let actual = Set(machine.canBuyDrinks())
        XCTAssertEqual(Set(["コーラ", "ジンジャーエール"]), actual)
    }
    
    func test_200円入れるとコーラとジンジャーエールとウーロン茶が光る() {
        machine.insert()
        machine.insert()
        let actual = Set(machine.canBuyDrinks())
        XCTAssertEqual(Set(["コーラ", "ウーロン茶", "レッドブル", "ジンジャーエール"]), actual)
    }
}

import Foundation
class Machine {
    // 投入金額
    var amount: Int = 0
    
//    typealias DrinkInfo = (String, Int)
//    enum Drink: (String, Int) {
//        case cola    = ("コーラ", 100)
//        case oolong  = ("ウーロン茶", 100)
//        case ginger  = ("ジンジャーエール", 100)
//        case redbull = ("レッドブル", 200)
//    }
    
    enum Drink: String, CaseIterable {
        case cola    = "コーラ"
        case oolong  = "ウーロン茶"
        case ginger  = "ジンジャーエール"
        case redbull = "レッドブル"
        
        var price: Int {
            switch self {
            case .redbull:
                return 200
            case .oolong:
                return 150
            default:
                return 100
            }
        }
    }
    
    func pushButton(drink: Drink) -> String? {
        if amount >= drink.price {
            amount -= drink.price
            return drink.rawValue
        } else {
            return nil
        }
    }
    
    func insert() {
        amount += 100
    }
    
    func canBuyDrinks() -> [String] {
        return Drink.allCases.compactMap { drink in
            if drink.price <= amount {
                return drink.rawValue
            }
            return nil
        }
    }
    
}
