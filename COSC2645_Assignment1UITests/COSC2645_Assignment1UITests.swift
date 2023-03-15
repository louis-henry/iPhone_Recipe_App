//
//  COSC2645_Assignment1UITests.swift
//  COSC2645_Assignment1UITests
//
//  Created by Nicholas Mamone on 9/9/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import XCTest

class COSC2645_Assignment1UITests: XCTestCase {

    override func setUp() {
        
        continueAfterFailure = false
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    
    // tests that the first switch in the Appliances page exists and can be toggled
    func testAppliancesSwitch() {
        let app = XCUIApplication()
        
        app.tabBars.buttons["More"].tap()
        app.tables.staticTexts["Appliances"].tap()
        
        let uiSwitch = app.tables.cells.switches.firstMatch
        XCTAssert(uiSwitch.exists)
        uiSwitch.tap()
        uiSwitch.tap()
    }
    
    // tests that a recipe and its instructions can be viewed
    func testRecipeInstructions() {
        let app = XCUIApplication()
        let firstRecipe = app.tables.cells.firstMatch
        
        app.tabBars.buttons["Search"].tap()
        firstRecipe.tap()
        app.buttons["Step-by-step instructions"].tap()
        app.buttons["Next"].tap()
        
        let table = app.tables.element
        XCTAssert(table.exists)
    }
    
    // tests that recipes can be added and removed from favourites list
    func testFavouriteRecipe() {
        let app = XCUIApplication()
        let navBar = app.navigationBars["COSC2645_Assignment1.RecipeDetailView"]
        let firstRecipe = app.tables.cells.firstMatch
        
        app.tables.cells.firstMatch.tap()
        app.buttons["Button"].tap()
        navBar.buttons["Recipe list"].tap()
        app.tabBars.buttons["Favorites"].tap()
        
        XCTAssert(app.tables.cells.count > 0)
        
        firstRecipe.tap()
        app.buttons["Button"].tap()
        navBar.buttons["Recipe list"].tap()
        
    }
    
    //tests whether the app logo on the Student Profile page changes in landscape mode on iPhone displays
    func testAdaptiveLogo() {
        let app = XCUIApplication()
        app.tabBars.buttons["More"].tap()
        app.tables.staticTexts["Student profile"].tap()
        let iPadAppLogo = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element(boundBy: 1)
        
        let iPhoneAppLogo = XCUIApplication().children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            XCTAssert(iPadAppLogo.exists)
            XCUIDevice.shared.orientation = .landscapeRight
            XCTAssert(iPadAppLogo.exists)
            XCUIDevice.shared.orientation = .portrait
        } else {
            XCTAssert(iPhoneAppLogo.exists)
            XCUIDevice.shared.orientation = .landscapeRight
            XCTAssert(iPhoneAppLogo.exists == false)
            XCUIDevice.shared.orientation = .portrait
        }
    }
}
