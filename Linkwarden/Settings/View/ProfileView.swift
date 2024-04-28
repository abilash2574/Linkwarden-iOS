//
//  ProfileView.swift
//  Linkwarden
//
//  Created by Abilash S on 28/04/24.
//

import SwiftUI

struct ProfileView: View {
    
    @Binding var user: User?
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            user?.profileImage
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(maxWidth: 80, maxHeight: 80)
                .foregroundStyle(.gray.opacity(0.8))
            
            VStack(alignment: .leading, spacing: 8) {
                Text(user?.displayName ?? "-")
                    .font(.title)
                    .fontWeight(.semibold)
                    .lineLimit(1)
                    .truncationMode(.tail)
                
                Text("@\(user?.username ?? "-")")
                    .font(.callout)
                    .fontWeight(.regular)
                    .foregroundStyle(.secondary)
            }
            
        }
        
    }
}

#Preview {
    let user = User.mockUser
    
    let userView =  ProfileView(user: .constant(user)).frame(width: 390, height: 80)
    return userView
}
