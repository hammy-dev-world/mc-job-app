//
//  MCFetchTallinnEmployeesOperation.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/30/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

class MCFetchTallinnEmployeesOperation: MCOperationBase {
    // MARK: Instance Variables
    let cacher: Cacher = Cacher(destination: .temporary)

    // MARK: Overridden Methods

    override func start() {
        super.start()

        self.startFetchingEmployeesOperation()
    }
    
    override func handleDidFinishedWithResponse(response: Data!){
        do {
            // Addition of location key in the API response after casting the response from Data to Dictionary, adding new key/value pair and cast back to dictionary 
            
            var responseDictionary: [String: Any] = try JSONSerialization.jsonObject(with: response, options:[]) as! [String : Any] // from Data to Dictionary
            
            var employeesArray: [[String: Any]] = responseDictionary[String(Substring(MCEmployeesListRootObject.EmployeesRootApiResponseCodingKeys.employees.rawValue))] as! [[String : Any]] // Employees list
            
            for i in 0..<employeesArray.count { // Appending new key/value in the dictionary of each employee
                var employee = employeesArray[i]
                employee[String(Substring(MCEmployeeRootObject.EmployeeCodingKeys.location.rawValue))] = EmployeeLocation.kTallinnLocationName
                
                employeesArray[i] = employee
            }
            
            responseDictionary[String(Substring(MCEmployeesListRootObject.EmployeesRootApiResponseCodingKeys.employees.rawValue))] = employeesArray
            
            do {
                let responseData = try JSONSerialization.data(withJSONObject:responseDictionary) // Cast back from dictionary to Data
                
                let tallinnCachable = TallinnEmployeesListCachable(value: responseData)
                
                cacher.persist(item: tallinnCachable) { url, error in
                    if let error = error {
                        self.handleDidFinishedWithError(error: error)
                    } else {
                        print("Object persisted in \(String(describing: url))")
                    }
                }

                do {
                    let employeesList = try JSONDecoder().decode(MCEmployeesListRootObject.self, from: responseData as Data)
                    
                    self.safeCallDidFinishSuccessfullyCallback(responseObject: employeesList as AnyObject)
                } catch {
                    self.handleDidFinishedWithError(error: error)
                }
                
            } catch {
                self.handleDidFinishedWithError(error: error)
            }
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
