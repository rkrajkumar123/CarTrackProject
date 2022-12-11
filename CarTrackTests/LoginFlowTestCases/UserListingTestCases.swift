//
//  UserListingTestCases.swift
//  UserListingTestCases
//
//  Created by Raj Kumar Gola on 11/12/22.
//

import XCTest

@testable import CarTrack

class UserListingTestCases: XCTestCase {
    var viewModel:CTUserListingViewModel!
    var isApiCalled = false
    var isRightURL = false
    override func setUp() {
        super.setUp()
        viewModel = CTUserListingViewModel()
    }
    
    //MARK: testing api calling for users with right and wrong uls
    func testApiData(){
        //right url
        Constants.PathUrlType.users = "/users"
        isRightURL = true
        
//        wrong url
//        Constants.PathUrlType.users = "/abc"
//        isRightURL = false
        
        
        let exp = self.expectation(description: "Api data retrive")
        viewModel.getUserLists {
            self.isApiCalled = true
            exp.fulfill()
        }
        waitForExpectation()
    }
    
    
    //Waiting For Expectation
    private func waitForExpectation(){
        self.waitForExpectations(timeout: 10) { [weak self] (error) in
            XCTAssertTrue(self?.isApiCalled == true)
            if self?.isApiCalled == true{
                self?.checkUsersData()
                do{
                    try self?.testPerformanceExample()
                }catch{
                    
                }
            }
        }
    }
    
    //MARK: testing users response data for right or wrong url
    private func checkUsersData(){
        XCTAssertNotEqual(viewModel.cellViewModel.count, 0)
        if isRightURL{
            let usersNotFoundData = viewModel.cellViewModel.filter({$0.cellType == .dataNotFound}).count
            XCTAssertEqual(usersNotFoundData, 0)
            XCTAssertTrue(viewModel.cellViewModel.count > 1)
        }else{
            let usersNotFoundData = viewModel.cellViewModel.filter({$0.cellType == .dataNotFound}).count
            XCTAssertEqual(usersNotFoundData, 1)
            XCTAssertEqual(viewModel.cellViewModel.count, 1)
        }
        
    }

    override func tearDownWithError() throws {
          viewModel = nil
    }

    func testPerformanceExample() throws {
        measure {
            if self.isApiCalled{
                measureTimeToPrepareUserListingCellViewData()
            }
        }
    }
    
    //MARK: measuring time prepare cellview model after api call
    private func measureTimeToPrepareUserListingCellViewData(){
        print("timeToPrepareUserListingCellViewDat=>")
        viewModel.cellViewModel.removeAll()
        viewModel.prepareUserListingData()
    }

}
