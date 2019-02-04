//
//  MCPhoneContacts.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 2/3/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation
import ContactsUI

enum ContactsFilter {
    case none
    case mail
    case message
}

class MCPhoneContactsOperation: MCOperationBase {
    // MARK: Instance Variables
    
    // MARK: Overridden Methods
    
    override func start() {
        super.start()
        
        self.startFetchingDeviceContactsOperation()
    }

    // MARK: Callbacks
    public var didReceiveSuccessFetchingDeviceContactsCallback : ((_ responseObject: [CNContact]?) -> Void)?
    public var didRecieveErrorCallback : ((_ error: Error?) -> Void)?

    // MARK: Events
    private func handleSuccessfulFetchedRequest(contacts : [CNContact]!) -> Void {
        self.finish()
                
        if self.didReceiveSuccessFetchingDeviceContactsCallback != nil {
            self.didReceiveSuccessFetchingDeviceContactsCallback!(contacts)
        }
    }
    
    private func handleFailedFetchedRequest(error : Error!) -> Void {
        self.finish()
        
        if self.didRecieveErrorCallback != nil {
            self.didRecieveErrorCallback!(error)
        }
    }

    // MARK: Private methods
    private func startFetchingDeviceContactsOperation(filter: ContactsFilter = .none) -> Void {
        let contactStore = CNContactStore()
        
        let keysToFetch = [
            CNContactGivenNameKey,
            CNContactFormatter.descriptorForRequiredKeys(for: .fullName),
            CNContactPhoneNumbersKey,
            CNContactEmailAddressesKey,
            CNContactThumbnailImageDataKey] as [Any]
        
        var allContainers: [CNContainer] = []
        
        do {
            allContainers = try contactStore.containers(matching: nil)
        } catch {
            self.handleFailedFetchedRequest(error: error)
        }
        
        var results: [CNContact] = []
        
        for container in allContainers {
            let fetchPredicate = CNContact.predicateForContactsInContainer(withIdentifier: container.identifier)
            
            do {
                let containerResults = try contactStore.unifiedContacts(matching: fetchPredicate, keysToFetch: keysToFetch as! [CNKeyDescriptor])
                results.append(contentsOf: containerResults)
                
                self.handleSuccessfulFetchedRequest(contacts: results)
            } catch {
                self.handleFailedFetchedRequest(error: error)
            }
        }
    }
}
