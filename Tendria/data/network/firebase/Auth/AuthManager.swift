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
        verifySignInWithAppleID()
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
        if Auth.auth().currentUser != nil {
            do {
                try Auth.auth().signOut()
            }
            catch let error as NSError{
                print("FirebaseAuthError: failed to sign out from Firebase, \(error)")
                throw error
            }
        }
    }
    
    //credential alıp firebaseden giriş yapmaya çalışıyor.
    private func authenticateUser(credentials: AuthCredential) async throws -> AuthDataResult? {
        guard let currentUser = Auth.auth().currentUser else {
            return try await authSignIn(credentials: credentials)
        }
        let providers = currentUser.providerData.map { $0.providerID }
        
        if providers.contains("google.com") && credentials.provider == "google.com" {
            return try await Auth.auth().signIn(with: credentials)
        }
        else if providers.contains("apple.com") && credentials.provider == "apple.com"{
            return try await Auth.auth().signIn(with: credentials)
        }
        else if providers.contains("password") && credentials.provider == "password" {
            return try await Auth.auth().signIn(with: credentials)
        }
        return try await authLink(credentials: credentials)
    }

    private func authSignIn(credentials: AuthCredential) async throws -> AuthDataResult? {
        do {
            let result = try await Auth.auth().signIn(with: credentials)
            updateState(user: result.user) // bu kendi içimiz için.
            return result
        }
        catch {
            print("FirebaseAuthError: signIn(with:) failed. \(error)")
            throw error
        }
    }
    
    func signUpWithEmail(email: String, password: String) async throws -> AuthDataResult? {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            return try await signInWithEmail(email: email, password: password)
        } catch {
            print("FirebaseAuthError: signUpWithEmail(email:password:) failed. \(error)")
            throw error
        }
    }
    
    func signInWithEmail(email: String, password: String) async throws -> AuthDataResult? {
        let credentials = EmailAuthProvider.credential(withEmail: email, password: password)
        
        do {
            let result = try await authenticateUser(credentials: credentials)
            return result
        } catch {
            print("FirebaseAuthError: signInWithEmail(email:password:) failed. \(error)")
            throw error
        }
    }

    // 3.Kullanıcı oturum açmışsa mevcut bilgileri bağla
    
    //TODO AYARLAR EKRANINDAN E MAIL ŞİFRE BAĞLANICAK
    private func authLink(credentials: AuthCredential) async throws -> AuthDataResult? {
        do {
            guard let user = Auth.auth().currentUser else { return nil }
            let result = try await user.link(with: credentials)
            //await updateDisplayName(for: result.user)
            updateState(user: result.user)
            return result
        }
        catch {
            print("FirebaseAuthError: link(with:) failed, \(error)")
            throw error
        }
    }
    
    private func updateDisplayName(for user: User) async {
        //apple ya da google sunucudan aldığımız display name ile firebasedekini işliyoruz.
        if let currentDisplayName = Auth.auth().currentUser?.displayName, !currentDisplayName.isEmpty {
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
        let credentials = GoogleAuthProvider.credential( //googledan gelen bilgileri credential olarak olst.
            withIDToken: idToken,
            accessToken: user.accessToken.tokenString
        )
        do {
            // 2.
            return try await authenticateUser(credentials: credentials)
        }
        catch let error as NSError {
            if error.code == AuthErrorCode.credentialAlreadyInUse.rawValue {
                print("Google hesabı zaten bir kullanıcıya bağlı, giriş yapılıyor...")
                return try await Auth.auth().signIn(with: credentials)
            } else {
                print("FirebaseAuthError: googleAuth(user:) failed. \(error.localizedDescription)")
                throw error
            }
        }
    }
    
    //import AppleSignIn
    func appleAuth(
        _ appleIDCredential: ASAuthorizationAppleIDCredential,
        nonce: String?
    ) async throws -> AuthDataResult? {
        guard let nonce = nonce else {
            fatalError("Invalid state: A login callback was received, but no login request was sent.")
        }

        guard let appleIDToken = appleIDCredential.identityToken else {
            print("Unable to fetch identity token")
            return nil
        }

        guard let idTokenString = String(data: appleIDToken, encoding: .utf8) else {
            print("Unable to serialize token string from data: \(appleIDToken.debugDescription)")
            return nil
        }

        // 2.
        let credentials = OAuthProvider.appleCredential(withIDToken: idTokenString,
                                                       rawNonce: nonce,
                                                       fullName: appleIDCredential.fullName)

        do { // 3.
            return try await authenticateUser(credentials: credentials)
        }
        catch {
            print("FirebaseAuthError: appleAuth(appleIDCredential:nonce:) failed. \(error)")
            throw error
        }
    }
    
    func verifySignInWithAppleID() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let providerData = Auth.auth().currentUser?.providerData
        if let appleProviderData = providerData?.first(where: { $0.providerID == "apple.com" }) {
            Task {
                let credentialState = try await appleIDProvider.credentialState(forUserID: appleProviderData.uid)
                switch credentialState {
                case .authorized:
                    break // The Apple ID credential is valid.
                case .revoked, .notFound:
                    // The Apple ID credential is either revoked or was not found, so show the sign-in UI.
                    do {
                        try await self.signOut()
                    }
                    catch {
                        print("FirebaseAuthError: signOut() failed. \(error)")
                    }
                default:
                    break
                }
            }
        }
    }
    
    
    func firebaseProviderSignOut(_ user: User) {
        let providers = user.providerData
                .map { $0.providerID }.joined(separator: ", ")

        if providers.contains("google.com") {
            GoogleSignInManager.shared.signOutFromGoogle()
        }
    }
     
}

enum AuthState {
    case authenticated // Anonymously authenticated in Firebase.
    case signedIn // Authenticated in Firebase using one of service providers, and not anonymous.
    case signedOut // Not authenticated in Firebase.
}
