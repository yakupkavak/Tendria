//
//  UserUI.swift
//  Tendria
//
//  Created by Yakup Kavak on 2.02.2025.
//

import SwiftUI

struct UserListContainerUI: View {
    
    @EnvironmentObject var routerUser: RouterUser
    
    var body: some View {
        NavigationStack(path: $routerUser.navPath) {
            UserListUI()
                .navigationDestination(for: RouterUser.Destination.self) { destination in
                    switch destination {
                    case .existRelation:
                        ExistRelationUI()
                    case .makeRelation:
                        MakeRelationUI()
                    case .resetPassword:
                        ResetPasswordUI()
                    case .userInfo:
                        UserInfoUI()
                    case .userList:
                        UserListUI()
                    }
                }.environmentObject(routerUser)
        }
    }
}

#Preview {
    UserListContainerUI()
}
