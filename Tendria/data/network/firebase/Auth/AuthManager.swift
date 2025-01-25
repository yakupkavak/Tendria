//
//  AuthManager.swift
//  Tendria
//
//  Created by Yakup Kavak on 25.01.2025.
//

import Foundation
import AuthenticationServices
import FirebaseAuth
import FirebaseCore
import GoogleSignIn

private var authStateHandle: AuthStateDidChangeListenerHandle!

@MainActor
class AuthManager: ObservableObject {
    @Published var user: User?
    @Published var authState = AuthState.signedOut
    
    init() {
        configureAuthStateChanges()
    }
    
    func configureAuthStateChanges() {
        authStateHandle = Auth.auth().addStateDidChangeListener { auth, user in
            //listener açıldı her oturum değişince burası çalışacak.
            print("Auth changed: \(user != nil)")
            self.updateState(user: user)
        }
    }
    
    func removeAuthStateListener() {
        Auth.auth().removeStateDidChangeListener(authStateHandle)
    }
    
    func updateState(user: User?) {
        self.user = user
        let isAuthenticatedUser = user != nil
        let isAnonymous = user?.isAnonymous ?? false

        if isAuthenticatedUser {
            self.authState = isAnonymous ? .authenticated : .signedIn
        } else {
            self.authState = .signedOut
        }
    }
    func signOut() async throws {
        if let user = Auth.auth().currentUser {
            do {
                try Auth.auth().signOut()
            }
            catch let error as NSError{
                print("FirebaseAuthError: failed to sign out from Firebase, \(error)")
                throw error
            }
        }
    }
    
    private func authenticateUser(credentials: AuthCredential) async throws -> AuthDataResult? {
        if Auth.auth().currentUser != nil {
            return try await authLink(credentials: credentials)
        } else {
            return try await authSignIn(credentials: credentials)
        }
    }

    // 2.
    private func authSignIn(credentials: AuthCredential) async throws -> AuthDataResult? {
        do {
            let result = try await Auth.auth().signIn(with: credentials)
            updateState(user: result.user)
            return result
        }
        catch {
            print("FirebaseAuthError: signIn(with:) failed. \(error)")
            throw error
        }
    }

    // 3.Kullanıcı oturum açmışsa mevcut bilgileri bağla
    private func authLink(credentials: AuthCredential) async throws -> AuthDataResult? {
        do {
            guard let user = Auth.auth().currentUser else { return nil }
            let result = try await user.link(with: credentials)
            // TODO: Update user's displayName
            updateState(user: result.user)
            return result
        }
        catch {
            print("FirebaseAuthError: link(with:) failed, \(error)")
            throw error
        }
    }
    
    private func updateDisplayName(for user: User) async {
        if let currentDisplayName = Auth.auth().currentUser?.displayName, !currentDisplayName.isEmpty {
            // current user is non-empty, don't overwrite it
        } else  {
            let displayName = user.providerData.first?.displayName
            let changeRequest = user.createProfileChangeRequest()
            changeRequest.displayName = displayName
            do {
                try await changeRequest.commitChanges()
            }
            catch {
                print("FirebaseAuthError: Failed to update the user's displayName. \(error.localizedDescription)")
            }
        }
    }
    // import GoogleSignIn
    func googleAuth(_ user: GIDGoogleUser) async throws -> AuthDataResult? {
        guard let idToken = user.idToken?.tokenString else { return nil }
        
        // 1.
        let credentials = GoogleAuthProvider.credential(
            withIDToken: idToken,
            accessToken: user.accessToken.tokenString
        )
        do {
            // 2.
            return try await authenticateUser(credentials: credentials)
        }
        catch {
            print("FirebaseAuthError: googleAuth(user:) failed. \(error)")
            throw error
        }
    }
}

enum AuthState {
    case authenticated // Anonymously authenticated in Firebase.
    case signedIn // Authenticated in Firebase using one of service providers, and not anonymous.
    case signedOut // Not authenticated in Firebase.
}
