//
//  LoginFlowTestCases.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 11/12/22.
//

import XCTest

@testable import CarTrack

class LoginFlowTestCases: XCTestCase {
    var viewModel:CTLoginViewModel!
    
    override func setUp() {
        super.setUp()
        LoginDataManager.sharedManager.updateLoginStatus(isUserLogin: false)
        prepareViewModel()
    }
    
    private func prepareViewModel(){
        viewModel = CTLoginViewModel()
    }
    
    //MARK: testing initial screen data not nil
    func testCellViewModelNotNil(){
        XCTAssertNotEqual(viewModel.cellViewModel.count, 0)
        if viewModel.cellViewModel.count > LoginPageCells.CellTypeDropdown.rawValue,let countryDropdownData = viewModel.cellViewModel[LoginPageCells.CellTypeDropdown.rawValue] as? CTDrodownModel{
            XCTAssertTrue(countryDropdownData.items.count > 0)
        }
    }
    
    //MARK: testing login flow with right and wrong credentials
    func testLoginWithRightCredentials(){
        //Right Credentials
        let inputTextFieldEmail = "cartrack@gmail.com"
        let inputTextFieldPassword = "cartrack"
        
        //Wrong Credentials
        //        let inputTextFieldEmail = "abc@gmail.com"
        //        let inputTextFieldPassword = "abc"
        
        if viewModel.cellViewModel.count >= LoginPageCells.TotalCellCount.rawValue{
            guard let emailTFModel = viewModel.cellViewModel[LoginPageCells.CellTypeEmail.rawValue] as? CTInputTFCellModel else {XCTAssertTrue(false); return}
            guard let passwordTFModel = viewModel.cellViewModel[LoginPageCells.CellTypePassword.rawValue] as? CTInputTFCellModel else {XCTAssertTrue(false); return}
            emailTFModel.fieldValue = inputTextFieldEmail
            passwordTFModel.fieldValue = inputTextFieldPassword
            viewModel.cellViewModel[LoginPageCells.CellTypeEmail.rawValue] = emailTFModel
            viewModel.cellViewModel[LoginPageCells.CellTypePassword.rawValue] = passwordTFModel
            viewModel.actionCellButtonTapped()
        }
        if let data = LoginDataManager.sharedManager.getLoginCredential(){
            XCTAssertTrue(data.isLogin)
        }
    }
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        viewModel = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            prepareViewModel()
            // Put the code you want to measure the time of here.
        }
    }
    
}
