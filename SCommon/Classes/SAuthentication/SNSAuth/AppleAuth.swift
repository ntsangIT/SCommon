//
//  AppleAuth.swift
//  Core
//
//  Created by Thanh Sang on 6/29/20.
//  Copyright © 2020 FLYG. All rights reserved.
//

import UIKit
import AuthenticationServices

@available(iOS 13.0, *)
extension SAuthentication.Apple {
    func createAppleSignInButton(with frame: CGRect) -> UIView {
        let authorizationButton = ASAuthorizationAppleIDButton()
        authorizationButton.frame = frame
        authorizationButton.addTarget(self,
                                      action: #selector(handleAuthorizationAppleID),
                                      for: .touchUpInside)
        return authorizationButton
    }
    
    /// the only scopes you can request are .fullName and .email. The name and email will be returned in the delegate function
    @objc
    func handleAuthorizationAppleID() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.fullName, .email]
        
        let authorizationController =
            ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
    
    /// Prompts the user if an existing iCloud Keychain credential or Apple ID credential is found.
    func performExistingAccountSetupFlows() {
        // Prepare requests for both Apple ID and password providers.
        let requests = [ASAuthorizationAppleIDProvider().createRequest(),
                        ASAuthorizationPasswordProvider().createRequest()]

        // Create an authorization controller with the given requests.
        let authorizationController = ASAuthorizationController(authorizationRequests: requests)
        authorizationController.delegate = self
        authorizationController.presentationContextProvider = self
        authorizationController.performRequests()
    }
}

@available(iOS 13.0, *)
extension SAuthentication.Apple: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        
    }
}

@available(iOS 13.0, *)
extension SAuthentication.Apple: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return window!
    }
}
