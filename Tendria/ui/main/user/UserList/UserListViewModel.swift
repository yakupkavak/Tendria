//
//  UserViewModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 2.02.2025.
//

import Foundation
import Combine

class UserListViewModel: BaseViewModel {
    
    @Published var isRelationExist: Bool = false
    @Published var loading: Bool = false
    @Published var error: String = ""

    override init() {
        super.init()
        updateRelation()
    }
    
    private func updateRelation(){
        getDataCall {
             try await FirestorageManager.shared.checkUserRelation()
        } onSuccess: { success in
            if success {
                self.isRelationExist = true
                self.loading = false
            }else {
                self.isRelationExist = false
                self.loading = false
            }
        } onLoading: {
            self.loading = true
        } onError: { error in
            self.isRelationExist = false
            self.error = error?.localizedDescription ?? "error"
        }
    }
}
