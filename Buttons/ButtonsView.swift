//
//  ButtonsView.swift
//  ShortVideoApp
//
//  Created by Marcus Chen on 3/23/23.
//

import Foundation
import SwiftUI
import AVKit

struct ButtonsView: View {
    // Add any @Binding properties needed for navigation or button actions
    @Binding var currentPage: AppPage
    @State private var following = true
    @State var index = 0
    @State var top = 0
    @State var data = [
        Video(id: 0, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video-8", ofType: "mp4")!)), replay: false),
        Video(id: 1, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video-5", ofType: "mp4")!)), replay: false),
        Video(id: 2, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video-9", ofType: "mp4")!)), replay: false),
        Video(id: 3, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video-6", ofType: "mp4")!)), replay: false),
        Video(id: 4, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video-7", ofType: "mp4")!)), replay: false),
        Video(id: 5, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video-4", ofType: "mp4")!)), replay: false),
        Video(id: 6, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video-10", ofType: "mp4")!)), replay: false),
        Video(id: 7, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video-1", ofType: "mp4")!)), replay: false),
        Video(id: 8, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video-3", ofType: "mp4")!)), replay: false),
        Video(id: 9, player: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "video-2", ofType: "mp4")!)), replay: false),
    ]
    
    
    var body: some View {
        VStack{
            HStack(spacing: 15){
                Button(action: {
                    self.top = 0
                }) {
                    Text("Following")
                        .foregroundColor(self.top == 0 ? .white : Color.white.opacity(0.45))
                        .fontWeight(self.top == 0 ? .bold : .none)
                        .padding(.vertical)
                }
                Button(action: {
                    self.top = 1
                }) {
                    Text("For You")
                        .foregroundColor(self.top == 1 ? .white : Color.white.opacity(0.45))
                        .fontWeight(self.top == 1 ? .bold : .none)
                        .padding(.vertical)
                    
                }
                Button(action: {
                    self.top = 2
                }) {
                    Text("Live")
                        .foregroundColor(self.top == 2 ? .white : Color.white.opacity(0.45))
                        .fontWeight(self.top == 2 ? .bold : .none)
                        .padding(.vertical)
                }
            }
            Spacer()
            HStack {
                Spacer()
                VStack(spacing: 15) {
                    Button(action: {
                        currentPage = .profile
                    }) {
                        Image("image-profile-1")
                            .renderingMode(.original)
                            .resizable()
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                    }
                    
                    Button(action: {
                        
                    }) {
                        VStack(spacing: 5) {
                            Image(systemName: "suit.heart.fill")
                                .font(.title)
                                .foregroundColor(.white)
                            Text("22k")
                                .foregroundColor(.white)
                        }
                    }
                    Button(action: {
                        
                    }) {
                        VStack(spacing: 5) {
                            Image(systemName: "message.fill")
                                .font(.title)
                                .foregroundColor(.white)
                            Text("1021")
                                .foregroundColor(.white)
                        }
                    }
                    Button(action: {
                        
                    }) {
                        VStack(spacing: 5) {
                            Image(systemName: "arrowshape.turn.up.right.fill")
                                .font(.title)
                                .foregroundColor(.white)
                            Text("Share")
                                .foregroundColor(.white)
                        }
                    }
                    Button(action: {
                        
                    }) {
                        VStack(spacing: 5) {
                            Image(systemName: "hurricane")
                                .font(.title)
                                .foregroundColor(.white)
                            Text("Trending")
                                .foregroundColor(.white)
                        }
                    }
                    Button(action: {
                        
                    }) {
                        VStack(spacing: 5) {
                            Image(systemName: "bag.fill")
                                .font(.title)
                                .foregroundColor(.white)
                            Text("Shop")
                                .foregroundColor(.white)
                        }
                    }
                }
                .padding(.bottom, 40)
                .padding(.trailing)
            }
            HStack(spacing: 0) {
                Button(action: {
                    
                    self.index = 0
                    
                }) {
                    Image("home-white")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(self.index == 0 ? .white : Color.white.opacity(0.35))
                        .padding(.horizontal)
                }
                
                Spacer(minLength: 0)
                
                Button(action: {
                    
                    self.index = 1
                    
                }) {
                    Image("search-white")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(self.index == 1 ? .white : Color.white.opacity(0.35))
                        .padding(.horizontal)
                }
                
                Spacer(minLength: 0)
                
                Button(action: {
                    
                }) {
                    Image("Hot-linear-button-1")
                        .renderingMode(.original)
                        .resizable()
                        .frame(width: 80, height: 65)
                        .padding(.horizontal)
                }
                
                Spacer(minLength: 0)
                
                Button(action: {
                    
                    self.index = 2
                    
                }) {
                    Image("comment-white")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(self.index == 2 ? .white : Color.white.opacity(0.35))
                        .padding(.horizontal)
                }
                
                Spacer(minLength: 0)
                
                Button(action: {
                    
                    self.index = 3
                    
                }) {
                    Image("profile-white")
                        .resizable()
                        .frame(width: 25, height: 25)
                        .foregroundColor(self.index == 3 ? .white : Color.white.opacity(0.35))
                        .padding(.horizontal)
                }
            }
            .padding(.horizontal)
        }
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView(currentPage: .constant(.home))
    }
}
