//
//  MCEmployeesListHandler.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/26/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation
import ContactsUI

class MCEmployeesListHandler: NSObject {
    // MARK: Instance Variables
    var viewController: MCEmployeesListViewController!
    var view: MCEmployeesListView!
    
    // MARK: Init
    required init(viewController: MCEmployeesListViewController!) {
        self.viewController = viewController
        self.view = self.viewController.employeesListView
    }
    
    // MARK: Callbacks
    public var didReceiveSuccessFetchingDeviceContactsCallback : ((_ error: [CNContact]?) -> Void)?
    public var didRecieveFetchingContactErrorCallback : ((_ error: Error?) -> Void)?

    public var didReceiveSuccessFetchingTallinnEmployeesCallback : ((_ responseObject: MCEmployeesListRootObject?) -> Void)?
    public var didReceiveSuccessFetchingTartuEmployeesCallback : ((_ responseObject: MCEmployeesListRootObject?) -> Void)?
    public var didRecieveErrorCallback : ((_ error: Error?) -> Void)?
    
    // MARK: Public Methods
    // MARK: Local
    public func requestFetchDeviceContactsDataRequest() -> Void {
        self.handleFetchDeviceContactsDataRequest()
    }
    
    // MARK: Remote
    public func requestFetchTallinnEmployeesDataAPI() -> Void {
        self.handleFetchTallinnEmployeesDataAPI()
    }
    
    public func requestFetchTartuEmployeesDataAPI() -> Void {
        self.handleFetchTartuEmployeesDataAPI()
    }
    
    // MARK: Private Methods
    // MARK: Local
    private func handleFetchDeviceContactsDataRequest() {
        let localOperation: MCPhoneContactsOperation = MCPhoneContactsOperation()

        weak var weakSelf = self
        
        localOperation.didReceiveSuccessFetchingDeviceContactsCallback = {contacts in
            weakSelf?.handleSuccessfulFetchingDeviceContactsRequest(contacts: contacts)
        }
        
        localOperation.didRecieveErrorCallback = {error in
            weakSelf?.handleFailedContactFetchRequest(error: error)
        }
        
        MCOperationQueue.sharedInstance.addOperation(localOperation)
    }
    
    // MARK: Remote
    // MARK: Operations
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
        
        MCOperationQueue.sharedInstance.addOperation(apiOperation)
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
        
        MCOperationQueue.sharedInstance.addOperation(apiOperation)
    }

    // MARK: Common
    private func handleFinishRequest() -> Void {
        //Handle Finish API Call through
    }

    // MARK: Events
    // MARK: Local
    private func handleSuccessfulFetchingDeviceContactsRequest(contacts : [CNContact]!) -> Void {
        if self.didReceiveSuccessFetchingDeviceContactsCallback != nil {
            self.didReceiveSuccessFetchingDeviceContactsCallback!(contacts)
        }
    }
    
    private func handleFailedAPIRequest(error : Error!) -> Void {
        if self.didRecieveFetchingContactErrorCallback != nil {
            self.didRecieveFetchingContactErrorCallback!(error)
        }
    }

    // MARK: Remote
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
    
    private func handleFailedContactFetchRequest(error : Error!) -> Void {
        if self.didRecieveErrorCallback != nil {
            self.didRecieveErrorCallback!(error)
        }
    }
    

}

