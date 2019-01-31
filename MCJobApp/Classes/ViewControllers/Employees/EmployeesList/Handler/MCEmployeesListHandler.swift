//
//  MCEmployeesListHandler.swift
//
//  MCEmployeesListViewController.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/26/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

class MCEmployeesListHandler: NSObject {
    // MARK: Instance Variables
    var viewController: MCEmployeesListViewController!
    var view: MCEmployeesListView!
    
    // MARK: Init
    required init(viewController: MCEmployeesListViewController!) {
        self.viewController = viewController
        self.view = self.viewController.employeesListView
    }
    
    //MARK: Callbacks
    public var didReceiveSuccessFetchingTallinnEmployeesCallback : ((_ responseObject: MCEmployeesListRootObject?) -> Void)?
    public var didReceiveSuccessFetchingTartuEmployeesCallback : ((_ responseObject: MCEmployeesListRootObject?) -> Void)?
    public var didRecieveErrorCallback : ((_ error: Error?) -> Void)?
    
    //MARK: Public Methods
    public func requestFetchTallinnEmployeesDataAPI() -> Void {
        self.handleFetchTallinnEmployeesDataAPI()
    }
    
    public func requestFetchTartuEmployeesDataAPI() -> Void {
        self.handleFetchTartuEmployeesDataAPI()
    }
    
    //MARK: Private Methods
    //MARK: Operation
    private func handleFetchTallinnEmployeesDataAPI() -> Void {
        let apiOperation: MCFetchTallinnEmployeesOperation = MCFetchTallinnEmployeesOperation()
        
        weak var weakSelf = self
        
        apiOperation.didFinishSuccessfullyCallback = {response in
            weakSelf?.handleSuccessfulFetchingTallinnEmployeesAPIRequest(response: response)
            weakSelf?.handleFinishRequest()
        }
        
        apiOperation.didFinishWithErrorCallback = {error in
            weakSelf?.handleFailedAPIRequest(error: error)
            weakSelf?.handleFinishRequest()
        }
        
        NetworkOperationQueue.sharedInstance.addOperation(apiOperation)
    }
    
    private func handleFetchTartuEmployeesDataAPI() -> Void {
        let apiOperation: MCFetchTartuEmployeesOperation = MCFetchTartuEmployeesOperation()
        
        weak var weakSelf = self
        
        apiOperation.didFinishSuccessfullyCallback = {response in
            weakSelf?.handleSuccessfulFetchingTartuEmployeesAPIRequest(response: response)
            weakSelf?.handleFinishRequest()
        }
        
        apiOperation.didFinishWithErrorCallback = {error in
            weakSelf?.handleFailedAPIRequest(error: error)
            weakSelf?.handleFinishRequest()
        }
        
        NetworkOperationQueue.sharedInstance.addOperation(apiOperation)
    }

    // MARK: Common
    private func handleFinishRequest() -> Void {
        //Handle Finish API Call through
    }

    // MARK: Events
    private func handleSuccessfulFetchingTallinnEmployeesAPIRequest(response : AnyObject!) -> Void {
        if self.didReceiveSuccessFetchingTallinnEmployeesCallback != nil {
            self.didReceiveSuccessFetchingTallinnEmployeesCallback!(response as? MCEmployeesListRootObject)
        }
    }
    
    private func handleSuccessfulFetchingTartuEmployeesAPIRequest(response : AnyObject!) -> Void {
        if self.didReceiveSuccessFetchingTartuEmployeesCallback != nil {
            self.didReceiveSuccessFetchingTartuEmployeesCallback!(response as? MCEmployeesListRootObject)
        }
    }
    
    private func handleFailedAPIRequest(error : Error!) -> Void {
        if self.didRecieveErrorCallback != nil {
            self.didRecieveErrorCallback!(error)
        }
    }
}

