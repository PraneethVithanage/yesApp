//
//  PreLaunch.swift
//  yes
//
//  Created by praneeth vithanage on 2021-11-30.
//

import SwiftUI
import AVKit

struct PreLaunch: View {
    
    @State private var showMainView = false
    @State var angle:Double = 360
    @State var opacity:Double = 1
    @State var scale: CGFloat = 1
    @State var viewNumber = "0"
    var body: some View {
        
        Group {
            if showMainView {
                ZStack(alignment: .center) {
                    
                    HomePlayer()
                    
                    if viewNumber == "1" {
                        
                        // Comming soon
                        
                    } else if  viewNumber == "2" {
                        
                        // link in Yes101 webside
                        
                    } else if  viewNumber == "3" {
                        
                        // link in News First webside
                        
                    } else if  viewNumber == "4" {
                        
                        EventAndPromoView()
                        
                    } else if  viewNumber == "5" {
                        
                        ProgramLineList()
                        
                    } else if  viewNumber == "6" {
                        
                        SongRequestView()
                        
                    } else if  viewNumber == "7" {
                        
                        exit(0)
                        
                    } else {
                        
                        
                    }
                    
                    TopView()
                }.edgesIgnoringSafeArea(.top)
            } else {
                ZStack(alignment: .top) {
                    VStack {
                        
                        AVPlayerView().aspectRatio(contentMode: .fill)
                        
                    } .frame(width: UIScreen.main.bounds.width, height:UIScreen.main.bounds.height)
                        .background(Color.white)
                        .edgesIgnoringSafeArea(.top)
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.ImageClick))
        { obj in
            
            // Change key as per your "userInfo"
            if let userInfo = obj.userInfo, let info = userInfo["info"] {
                viewNumber = info as! String
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 2)) {
                self.angle = 0
                self.scale = 3
                self.opacity = 0
            }
            withAnimation(Animation.linear.delay(1.7)) {
                DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
                    self.showMainView = true
                }
                
            }
        }
    }
}

struct PreLaunch_Previews: PreviewProvider {
    static var previews: some View {
        PreLaunch()
    }
}

extension NSNotification {
    static let ImageClick = Notification.Name.init("ImageClick")
}

struct AVPlayerView: UIViewControllerRepresentable {
    
    var videoURL = Bundle.main.url(forResource: "launchVideo", withExtension: "mov")!
    
    private var player: AVPlayer {
        return AVPlayer(url: videoURL)
    }
    
    func updateUIViewController(_ playerController: AVPlayerViewController, context: Context) {
        playerController.player = player
        playerController.player?.play()
        playerController.showsPlaybackControls = false
    }
    
    func makeUIViewController(context: Context) -> AVPlayerViewController {
        return AVPlayerViewController()
    }
}
