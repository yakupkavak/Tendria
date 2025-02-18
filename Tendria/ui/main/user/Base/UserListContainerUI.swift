//
//  UserUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 2.02.2025.
//

import SwiftUI

struct UserListContainerUI: View {
    
    @EnvironmentObject var routerUser: RouterUserInfo
    
    var body: some View {
        UserListUI()
    }
}

#Preview {
    UserListContainerUI()
}
