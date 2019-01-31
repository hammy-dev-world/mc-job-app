//
//  MCFetchTallinnEmployeesOperation.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/30/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

class MCFetchTallinnEmployeesOperation: NetworkOperationBase {
    // MARK: Instance Variables

    // MARK: Overridden Methods

    override func start() {
        super.start()

        self.startFetchingEmployeesOperation()
    }
    
    override func handleDidFinishedWithResponse(response: Data!){
        do {
            let employeesList = try JSONDecoder().decode(MCEmployeesListRootObject.self, from: response as Data)
            
            self.safeCallDidFinishSuccessfullyCallback(responseObject: employeesList as AnyObject)
        } catch {
            self.handleDidFinishedWithError(error: error)
        }
    }
    
    override func handleDidFinishedWithError(error: Error!) {
        self.safeCallDidFinishWithErrorCallback(error: error)
    }
    
    // MARK: Request
    // MARK: Operation
    private func startFetchingEmployeesOperation() {
        let router = Router<TallinnNetworkManager>()

        router.request(.getTallinnEmployees()) { data, response, error in
            
            if error != nil {
                self.handleDidFinishedWithError(error: error)
            }
            
            if let response = response as? HTTPURLResponse {
                let result = NetworkResponseHandler.sharedInstance.handleNetworkResponse(response)
                switch result {
                case .success:
                    guard let responseData = data else {
                        //completion(nil, NetworkResponse.noData.rawValue)
                        self.handleDidFinishedWithError(error: error)
                        return
                    }
                    self.handleDidFinishedWithResponse(response: responseData)
                case .failure(let networkFailureError):
                    self.handleDidFinishedWithError(error: networkFailureError as? Error)
                }
            }
        }
    }
}
