//
//  FlipgridInterviewTests.swift
//  FlipgridInterviewTests
//
//  Created by Nyghtwel on 2/13/22.
//

import XCTest
@testable import FlipgridInterview

class FlipgridInterviewTests: XCTestCase {
    
    func testEmptyUser() throws {
        let user = User(name: "", email: "", password: "", website: "")
        XCTAssertEqual(user.isValidUser, false)
    }
    
    func testUserValidEmail() throws {
        let user = User(name: "", email: "valid@gmail.com", password: "", website: "")
        XCTAssertEqual(user.hasEmailError, false)
    }
    
    func testUserInvalidEmail() throws {
        let user = User(name: "", email: "not an email", password: "", website: "")
        XCTAssertEqual(user.hasEmailError, true)
    }
    
    func testValidUser() throws {
        let user = User(name: "", email: "valid@gmail.com", password: "password", website: "")
        XCTAssertEqual(user.isValidUser, true)
    }
    
    func testInvalidUserPassword() throws {
        let user = User(name: "", email: "", password: "", website: "")
        XCTAssertEqual(user.hasPasswordError, true)
    }
    
    func testValidUserPassword() throws {
        let user = User(name: "", email: "", password: "password", website: "")
        XCTAssertEqual(user.hasPasswordError, false)
    }

    func testInvalidProfileCreationUser() throws {
        let vm = ProfileCreationViewModel()
        vm.user = User(name: "", email: "", password: "", website: "")
        vm.submitPressed()
        XCTAssertEqual(vm.isShowingEmptyPasswordError, true)
        XCTAssertEqual(vm.isShowingEmptyEmailError, true)
        XCTAssertEqual(vm.isShowingInvalidEmailError, false)
        XCTAssertEqual(vm.showConfirmation, false)
    }
    
    func testValidProfileCreationUser() throws {
        let vm = ProfileCreationViewModel()
        vm.user = User(name: "", email: "email@gmail.com", password: "password", website: "")
        vm.submitPressed()
        XCTAssertEqual(vm.isShowingEmptyPasswordError, false)
        XCTAssertEqual(vm.isShowingEmptyEmailError, false)
        XCTAssertEqual(vm.isShowingInvalidEmailError, false)
        XCTAssertEqual(vm.showConfirmation, true)
    }
}
