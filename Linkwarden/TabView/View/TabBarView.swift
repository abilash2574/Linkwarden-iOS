//
//  TabBarView.swift
//  Linkwarden
//
//  Created by Abilash S on 01/04/24.
//

import SwiftUI

struct TabBarView: View {
    
    @ObservedObject var viewState: TabViewState
    
    var body: some View {
        TabView {
            ForEach(viewState.modulesList, id: \.id) { module in
                switch module {
                case .Bookmarks:
                    BookmarksAssembler.getBookmarksView()
                        .tabItem {
                                module.tabIcon
                                Text(module.displayName)
                        }
                case .Collections:
                    CollectionsAssembler.getCollectionsView()
                        .tabItem {
                                module.tabIcon
                                Text(module.displayName)
                        }
                case .Favourites:
                    FavouritesView()
                        .tabItem {
                            module.tabIcon
                            Text(module.displayName)
                        }
                case .Tags:
                    TagsAssembler.getTagsView()
                        .tabItem {
                                module.tabIcon
                                Text(module.displayName)
                        }
                case .Settings:
                    SettingsView()
                        .tabItem {
                                module.tabIcon
                                Text(module.displayName)
                        }
                }
            }
        }
        .onAppear {
            viewState.viewOnAppearing()
        }
    }
}

#Preview {
    TabBarAssembler.getTabBar()
}
