//
//  PlayerView.swift
//  yes
//
//  Created by MacBook on 2022-01-18.
//

import SwiftUI
import Kingfisher
import AVFoundation
import AVKit

struct PlayerView: View {
    
    @Environment(\.openURL) var openURL
    @State var isPlaying : Bool = true
    var programName : String
    var djName : String
    var audioWidth : CGFloat
    var imageUrl : String
    var startTime : String
    var endTime : String
    var currentSongTitle : String
    var currentSongArtist : String
    var audioPlayer : AVPlayer
    
    var body: some View {
        
        VStack{
            ZStack(alignment: .top)  {
                
                let url = URL(
                    string: imageUrl
                )
                
                if  imageUrl != "" {
                    KFImage(url)
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2 + 20)
                } else {
                    Image("dj")
                        .resizable()
                        .scaledToFill()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/2 + 20)
                }
                
                HStack {
                    let buttonDim = UIScreen.main.bounds.width/8
                    Button(action: {}) {
                        Image("NOTIFICATION")
                            .resizable()
                            .scaledToFit()
                            .frame(width: buttonDim, height:buttonDim, alignment: .center)
                    }
                    Button(action: {openURL(URL(string: "https://www.facebook.com/yes101srilanka/")!)}) {
                        Image("FB")
                            .resizable()
                            .scaledToFit()
                            .frame(width:buttonDim, height:buttonDim, alignment: .center)
                    }
                    Button(action: {
                        
                        if audioPlayer.rate > 0 {
                            audioPlayer.pause()
                        } else {
                            audioPlayer.play()
                        }
                        self.isPlaying.toggle()
                        
                    }) {
                        
                        Image(self.isPlaying == true ? "STOP":"PLAY_BUTTON")
                            .resizable()
                            .scaledToFit()
                            .frame(width:buttonDim*4/3, height:buttonDim*4/3, alignment: .center)
                    }
                    Button(action: {openURL(URL(string: "https://www.instagram.com/yes101srilanka/?hl=en")!)}) {
                        Image("IG")
                            .resizable()
                            .scaledToFit()
                            .frame(width: buttonDim, height:buttonDim, alignment: .center)
                    }
                    Button(action: actionSheet) {
                        Image("SHARE")
                            .resizable()
                            .scaledToFit()
                            .frame(width:buttonDim, height:buttonDim, alignment: .center)
                    }
                }
                .padding(.top, UIScreen.main.bounds.height/2 - 20)
            }
            
            ZStack(alignment:.leading){
                let capsuleWidth = UIScreen.main.bounds.width - 30
                Capsule().fill(Color.white.opacity(0.8)).frame(width:capsuleWidth, height : 5)
                
                if self.audioWidth < capsuleWidth {
                    
                    Capsule().fill(Color.red).frame(width:self.audioWidth,height : 5)

                } else {
                    
                    Capsule().fill(Color.red).frame(width:capsuleWidth,height : 5)
                }
            }.padding(.horizontal, 20)
            
            //                AudioProgress(progress:self.audioWidth)
            //                    .padding(.horizontal, 30)
            
            HStack {
                Text("\(startTime)").foregroundColor(.white)
                    .font(.caption)
                Spacer()
                Text("\(endTime)").foregroundColor(.white)
                    .font(.caption)
            }
            .padding(.horizontal, 30)
            Text(programName)
                .foregroundColor(.white)
                .font(.subheadline)
            Text(djName)
                .foregroundColor(.white)
                .font(.caption)
            Spacer()
            ZStack {
                Image("yes_white")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.height/8, height:UIScreen.main.bounds.height/8, alignment: .center)
                
            }
            
            Spacer()
            ZStack {
                let bottomDim = UIScreen.main.bounds.width/6
                Color.bgHome.opacity(0.5)
                HStack {
                    ZStack {
                        Image(systemName: "play.fill")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                        
                            .padding()
                    }
                    .frame(width:bottomDim, height:bottomDim)
                    .background(Color.black)
                    .clipShape(Circle())
                    .padding(.leading)
                    Spacer()
                    
                    VStack {
                        Text(currentSongTitle)
                            .foregroundColor(.white)
                            .font(.headline)
                        Text(currentSongArtist).foregroundColor(.white)
                            .font(.caption)
                    }
                    
                    Spacer()
                    ZStack {
                        Image("singer")
                            .resizable()
                            .scaledToFill()
                    }
                    .frame(width:bottomDim, height: bottomDim)
                    .background(Color.black)
                    .clipShape(Circle())
                    .padding(.trailing)
                }
            }
            .frame(width: UIScreen.main.bounds.width -  30, height:UIScreen.main.bounds.width/5)
            .background(Image("pr__1").resizable().scaledToFill())
            .clipShape(Capsule())
            .padding(.bottom, 30)
            
        }
    }
    
    func actionSheet() {
        //add test url
        guard let data = URL(string: "http://live.trusl.com:1150") else { return }
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}

