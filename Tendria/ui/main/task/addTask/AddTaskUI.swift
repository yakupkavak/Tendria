//
//  TaskAddUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 5.02.2025.
//

import SwiftUI

struct AddTaskUI: View {
    
    @EnvironmentObject var routerTask: RouterTask

    var body: some View {
        VStack(alignment: .leading){
            tvHeadline(text: StringKey.create, color: .orange700)
            tvFootnote(text: StringKey.already_account, color: .black)
            
        }
    }
}

#Preview {
    AddTaskUI()
}
