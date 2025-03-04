import SwiftUI

struct UserListUI: View {
    
    @EnvironmentObject var router: RouterUserInfo
    @StateObject var viewModel = UserListViewModel()
    @StateObject private var notificationManager = NotificationManager()

    var body: some View {
        ScrollView {
            VStack(spacing: Height.smallHeight) {
                VStack {
                    Circle()
                        .fill(Color(.systemGray5))
                        .frame(width: Height.xLargeHeight, height: Height.xLargeHeight)
                    
                    Text("Vishal Khadok")
                        .font(.title2)
                        .fontWeight(.bold)
                }
                .padding(.top, Height.smallHeight)
                
                // Menü Grupları
                VStack(spacing: Height.xSmallHeight) {
                    MenuSection(items: [
                        MenuItem(icon: IconName.person, title: StringKey.personal_info,onClick:{ router.navigate(to: .userInfo)}),
                    ])
                    
                    MenuSection(items: [
                        MenuItem(icon: IconName.heart, title: StringKey.make_relation
                                 ,onClick:{
                                     print(viewModel.isRelationExist)
                                     if(viewModel.isRelationExist) {
                                         router.navigate(to: .existRelation)
                                     }else {
                                         router.navigate(to: .makeRelation)
                                     }
                                     }),
                    ])
                    
                    MenuSection(items: [
                        MenuItem(icon: "questionmark.circle.fill", title: StringKey.change_password,onClick:{ router.navigate(to: .userInfo)}),
                        MenuItem(icon: "star.fill", title: StringKey.notifications,onClick:{ router.navigate(to: .userInfo)}),
                        MenuItem(icon: "gearshape.fill", title: StringKey.settings,onClick:{ router.navigate(to: .userInfo)})
                    ])
                    
                    MenuSection(items: [
                        MenuItem(icon: "arrow.left.square.fill", title: StringKey.log_out,onClick:{ router.navigate(to: .userInfo)}),
                    ])
                }
                .padding()
            }
        }
    }
}

// Menü İçin Yardımcı Yapılar
struct MenuItem: Identifiable {
    let id = UUID()
    let icon: String
    let title: LocalizedStringKey
    let onClick: () -> Void
}

struct MenuSection: View {
    let items: [MenuItem]
    
    var body: some View {
        VStack {
            ForEach(items) { item in
                MenuItemView(icon: item.icon, title: item.title, onClick: item.onClick)
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(Radius.mediumRadius)
    }
}

struct MenuItemView: View {
    let icon: String
    let title: LocalizedStringKey
    var onClick: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(.blue500)
                .frame(width: 24)
            
            tvColorKey(text: title, color: .black, font: .body)
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }.onTapGesture {
            onClick()
        }
        .padding()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserListUI()
    }
}
