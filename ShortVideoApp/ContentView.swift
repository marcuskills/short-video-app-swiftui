//
//  ContentView.swift
//  ShortVideoApp
//
//  Created by user on 22/09/22.
//

import SwiftUI
import AVKit

enum AppPage {
    case home
    case profile
    // Add more cases for additional pages
}


struct ContentView: View {
    var body: some View {
        
        Home()
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    @State private var following = true
    @State private var currentPage: AppPage = .home
    
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
        Group {
            switch currentPage {
            case .home:
                VStack {
                    // Replace the buttons with the ButtonsView
                    ButtonsView(currentPage: $currentPage)
                    // ...
                }
            case .profile:
                ProfileView(showProfileView: $showProfileView)
            // Add more cases for additional pages
            }
        }
        ZStack {
            PlayerScrollView(data: self.$data)
            // Code to ignore all the edges on the screen
                .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
                .padding(.bottom, (UIApplication.shared.windows.first?.safeAreaInsets.bottom)! + 5)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
        .edgesIgnoringSafeArea(.all)
    }
}

// Code to create the sliding view with videos
struct PlayerView: View {
    @Binding var data: [Video] // This line of code connects the video files to the player
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0..<self.data.count) {i in
                
                ZStack {
                    Player(player: self.data[i].player)
                    // This line of code creates the effect of full size screen for paging
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                        .offset(y: -5)
                    
                    if self.data[i].replay{
                        Button(action: {
                            // Playing each video in a loop
                            self.data[i].replay = true
                            self.data[i].player.seek(to: .zero)
                            self.data[i].player.play()
                            
                        }) {
                            Image(systemName: "goforward")
                                .resizable()
                                .frame(width: 55, height: 60)
                                .foregroundColor(.white)
                        }
                    }
                }
            }
        }
        .onAppear {
            self.data[0].player.play()
        }
    }
}

struct Player: UIViewControllerRepresentable {
    var player: AVPlayer
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        let view = AVPlayerViewController()
        view.player = player
        view.showsPlaybackControls = false
        view.videoGravity = .resizeAspectFill
        return view
    }
    func  updateUIViewController(_ uiViewController: AVPlayerViewController, context: Context) {
        
    }
}

class Host: UIHostingController<ContentView>{
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}

// Insertion of video samples

struct Video: Identifiable {
    var id: Int
    var player: AVPlayer
    var replay: Bool
}

//var data = [] sent to @State at the beginning

struct PlayerScrollView: UIViewRepresentable {
    func makeCoordinator() -> Coordinator {
        return PlayerScrollView.Coordinator(parent1: self)
    }
    
    @Binding var data: [Video] // This line of code brings the video files to the player scrool viewer
    func makeUIView(context: Context) -> UIScrollView {
        let view = UIScrollView()
        let childView = UIHostingController(rootView: PlayerView(data: self.$data))
        // Each children, in this case a video, occupies the full screen when showing -> height = count * height of the screen
        childView.view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        // Each children, in this case a video, occupies the full screen when showing -> height = count * height of the screen
        view.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        view.addSubview(childView.view)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        // Line of code that makes the video ignore the safe area
        view.contentInsetAdjustmentBehavior = .never
        view.isPagingEnabled = true
        view.delegate = context.coordinator
        return view
    }
    func updateUIView(_ uiView: UIScrollView, context: Context) {
        // Piece of code to update the height of the videos based on the presented data
        uiView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        for i in 0..<uiView.subviews.count{
            uiView.subviews[i].frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * CGFloat((data.count)))
        }
    }
    class Coordinator: NSObject,UIScrollViewDelegate {
        var parent: PlayerScrollView
        var index = 0
        init(parent1: PlayerScrollView) {
            parent = parent1
        }
        func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
            let currenrindex = Int(scrollView.contentOffset.y / UIScreen.main.bounds.height)
            //print(index)
            if index != currenrindex {
                index = currenrindex
                for i in 0..<parent.data.count{
                    // Piece of code that pauses all other videeos while there is one playing
                    parent.data[i].player.seek(to: .zero)
                    parent.data[i].player.pause()
                }
                // Piece of code that plays the next video
                parent.data[index].player.play()
                parent.data[index].player.actionAtItemEnd = .none
                NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemFailedToPlayToEndTime, object: parent.data[index].player.currentItem, queue: .main) { [self] (_) in
                    // Notification to identify at the end of the video
                    //enables replay button
                    self.parent.data[self.index].replay = true
                }
            }
        }
    }
}
