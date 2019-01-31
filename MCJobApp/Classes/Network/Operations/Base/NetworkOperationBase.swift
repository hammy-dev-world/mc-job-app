//
//  NetworkOperationBase.swift
//  MCJobApp
//
//  Created by Humayun Sohail on 1/30/19.
//  Copyright © 2019 Mooncascade. All rights reserved.
//

import Foundation

class NetworkOperationBase: Operation {
    //MARK: Instance Variables
    var networkTask : URLSessionDataTask?
    
    //MARK: States
    private var _executing : Bool = false
    override open var isExecuting : Bool {
        get { return _executing }
        set {
            guard _executing != newValue else { return }
            willChangeValue(forKey: "isExecuting")
            _executing = newValue
            didChangeValue(forKey: "isExecuting")
        }
    }
    
    private var _finished : Bool = false
    override open var isFinished : Bool {
        get { return _finished }
        set {
            guard _finished != newValue else { return }
            willChangeValue(forKey: "isFinished")
            _finished = newValue
            didChangeValue(forKey: "isFinished")
        }
    }
    
    
    //MARK: Callbacks
    public var didFinishWithErrorCallback : ((_ error: Error?) -> Void)?
    public var didFinishSuccessfullyCallback : ((_ responseObject: AnyObject?) -> Void)?
    
    //MARK: Overriden Methods
    override open func start() {
        DispatchQueue.main.async {
            self.willChangeValue(forKey: "isExecuting")
            self.isExecuting = true
            self.didChangeValue(forKey: "isExecuting")
        }
    }
    
    override open func cancel() {
        super.cancel()
        self.networkTask?.cancel()
        
        //Obj-c
        //NSError *error = [NSError networkErrorCanceled];
        self.safeCallDidFinishWithErrorCallback(error: nil);
    }
    
    //MARK: Public Methods
    public func finish() -> Void {
        DispatchQueue.main.async {
            self.willChangeValue(forKey: "isExecuting")
            self.willChangeValue(forKey: "isFinished")
            self.isExecuting = false
            self.isFinished = true
            self.didChangeValue(forKey: "isExecuting")
            self.didChangeValue(forKey: "isFinished")
        }
    }
}

extension NetworkOperationBase {
    //MARK: Public methods
    @objc open func handleDidFinishedWithResponse(response: Data!){
        // To be overriden
    }
        
    @objc open func handleDidFinishedWithError(error: Error!) -> Void{
        // To be overriden
    }
    
    @objc open func handleDidFinishedCommon() -> Void{
        // To be overriden
    }
    
    open func safeCallDidFinishWithErrorCallback(error: Error!) -> Void{
        self.finish()

        DispatchQueue.main.async {
            if self.didFinishWithErrorCallback != nil {
                self.didFinishWithErrorCallback!(error)
            }
        }
    }
    
    open func safeCallDidFinishSuccessfullyCallback(responseObject: AnyObject!) -> Void{
        self.finish()
        
        DispatchQueue.main.async {
            if self.didFinishSuccessfullyCallback != nil {
                self.didFinishSuccessfullyCallback!(responseObject)
            }
        }
    }
}
