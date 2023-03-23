//
//  ProfileView.swift
//  ShortVideoApp
//
//  Created by Marcus Chen on 3/22/23.
//

import Foundation
import SwiftUI
import UIKit

struct ProfileView: View {
    @Binding var showProfileView: Bool

    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 20) {
                // Profile picture
                Image("image-profile-1")
                    .renderingMode(.original)
                    .resizable()
                    .frame(width: 120, height: 120)
                    .clipShape(Circle())
                
                // Follow button
                Button(action: {
                    // Handle follow action here
                }) {
                    Text("Follow")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 150, height: 45)
                        .background(Color.blue)
                        .cornerRadius(10)
                }
                
                // 3x3 grid for photos and videos
                let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
                
                LazyVGrid(columns: columns, spacing: 10) {
                    ForEach(1...9, id: \.self) { i in
                        Image("grid-image-\(i)") // Replace with actual image names
                            .resizable()
                            .scaledToFill()
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .aspectRatio(1, contentMode: .fill)
                            .clipped()
                    }
                }
            }
            .padding()
        }
        .navigationBarTitle("Profile", displayMode: .inline)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
