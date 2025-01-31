//
//  BaseViewModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 30.01.2025.
//

import Foundation
import Combine

@MainActor
class BaseViewModel: ObservableObject {
    
    func getDataCall<T>(
        dataCall: @escaping () async throws -> T,
        onSuccess: @escaping (T) -> Void,
        onLoading: @escaping () -> Void,
        onError: @escaping (Error?) -> Void
        
    ) {
        Task {
            do {
                DispatchQueue.main.async { onLoading() }
                let result = try await dataCall()
                DispatchQueue.main.async {
                    onSuccess(result)
                }
            } catch {
                DispatchQueue.main.async {
                    onError(error)
                }
            }
        }
    }
}
