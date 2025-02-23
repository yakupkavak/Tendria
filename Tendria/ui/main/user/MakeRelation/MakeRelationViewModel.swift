//
//  MakeRelationViewModel.swift
//  Tendria
//
//  Created by Yakup Kavak on 11.02.2025.
//

import Foundation

class MakeRelationViewModel: BaseViewModel {
    @Published var inputText = ""
    @Published var showCopy = false
    @Published var isEditable = true
    @Published var loading = false
    @Published var error = ""

    func generateCode(){
        getDataCall {
            try await FirestorageManager.shared.generateConnectionCode()
        } onSuccess: { connectionCode in
            guard let code = connectionCode else {
                return
            }
            self.loading = false
            self.inputText = code
            self.showCopy = true
            self.isEditable = false
        } onLoading: {
            self.loading = true
        } onError: { error in
            self.loading = false
            self.error = error?.localizedDescription ?? ""
        }
    }
    
    func enterCode(){
        if(isEditable){
            self.isEditable = true
        }else {
            
        }
    }
}
