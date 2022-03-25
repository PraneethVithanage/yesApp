//
//  HomePlayer.swift
//  yes
//
//  Created by Erandra Jayasundara on 2021-07-12.
//

import SwiftUI
import AVFoundation
import AVKit
import MediaPlayer
import Kingfisher

struct HomePlayer: View {
    @State var audioPlayer: AVPlayer?
    @ObservedObject var viewModel = HomePlayerViewModel()
    @State var menuOpen: Bool = false
    @State var isPlaying : Bool = true
    @State var audioWidth : CGFloat = 0.0

    var body: some View {
        
        ZStack {
            Color.bgHomeDj
                .edgesIgnoringSafeArea(.top)
            VStack {
                
                if viewModel.liveProgram != nil {
                    
                    PlayerView(programName:String(htmlString:viewModel.liveProgram?.programName ?? ""), djName: String(htmlString:viewModel.liveProgram?.djInfo.first?.djName ?? ""), audioWidth: audioWidth, imageUrl: viewModel.liveProgram?.imageURLLarge ?? "", startTime: viewModel.liveProgram?.startTime ?? "", endTime: viewModel.liveProgram?.endTime ?? "", currentSongTitle: viewModel.currentSongTitle.uppercased(), currentSongArtist: String(htmlString:viewModel.currentSongArtist),audioPlayer:audioPlayer ?? AVPlayer(url: URL(string: "http://live.trusl.com:1150")!))
                    
                } else {
                    
                    LoadingView(isShowing: .constant(true)) {
                        
                        PlayerView(programName:"programName", djName:"djName", audioWidth: 20.0, imageUrl: "", startTime: "00:00", endTime: "02:00", currentSongTitle: "current Song Title", currentSongArtist: "current Song Artist",audioPlayer:AVPlayer(url: URL(string: "http://----")!))
                       
                    }
                }
            }
            .background(Color.bgHome)
            .edgesIgnoringSafeArea(.bottom)
            .padding(.top, UIScreen.main.bounds.height/15)
        }
        .onAppear(){
            let url = URL(string: "http://live.trusl.com:1150")
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback)
                //try AVAudioSession.sharedInstance().setActive(true)
                let playerItem = AVPlayerItem(url: url!)
                self.audioPlayer = AVPlayer(playerItem: playerItem)
                audioPlayer!.volume = 1.0
                audioPlayer!.play()
                
                if audioPlayer!.currentItem!.status == .readyToPlay {
                    
                    print(self.audioPlayer!.currentItem!.asset.duration) // it't not nan
                }
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (_) in
                    
                    if self.isPlaying {
                        var endTime = viewModel.liveProgram?.endTime ?? ""
                        var startTime = viewModel.liveProgram?.startTime ?? ""
                        if viewModel.liveProgram != nil {
                            endTime =  endTime.replacingOccurrences(of: "PM", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "AM", with: "", options: NSString.CompareOptions.literal, range: nil)
                            
                            startTime =  startTime.replacingOccurrences(of: "PM", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "AM", with: "", options: NSString.CompareOptions.literal, range: nil)
                        } else {
                            endTime = "02:00"
                            startTime = "00:00"
                        }
                        
                        let formatter = DateFormatter()
                        formatter.dateFormat = "mm:ss"
                        let start = formatter.date(from: startTime)
                        let end = formatter.date(from: endTime)
                        let dif = end!.timeIntervalSinceReferenceDate - start!.timeIntervalSinceReferenceDate
                        
                        let time = Date()
                        let timeFormatter = DateFormatter()
                        timeFormatter.dateFormat = "HH:mm"
                        let dateAsString = timeFormatter.string(from: time)
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "HH:mm"
                        let date = dateFormatter.date(from: dateAsString)
                        dateFormatter.dateFormat = "h:mm a"
                        let Date12 = dateFormatter.string(from: date!).replacingOccurrences(of: "PM", with: "", options: NSString.CompareOptions.literal, range: nil).replacingOccurrences(of: "AM", with: "", options: NSString.CompareOptions.literal, range: nil)
                        
                        let difCurrent = formatter.date(from:Date12)!.timeIntervalSinceReferenceDate - start!.timeIntervalSinceReferenceDate
                        
                        let screen = UIScreen.main.bounds.width/dif
                        //  let audioAsset = AVURLAsset.init(url: url!, options: nil)
                        //  let duration = audioAsset.duration
                        //  let durationInSeconds = CMTimeGetSeconds(duration)
                        if audioPlayer != nil {
                            let value = Float(CMTimeGetSeconds(self.audioPlayer!.currentTime()))/Float(dif)
                            self.audioWidth = screen * CGFloat(value) + screen * difCurrent
                        }
                        
                        
                    }
                    
                }
                commandCenterSetup(title:"Yes FM")
            } catch {
                print("Error")
            }
        }
        // }
    }
    
    func commandCenterSetup(title:String) {
        
        UIApplication.shared.beginReceivingRemoteControlEvents()
        let commandCenter = MPRemoteCommandCenter.shared()
        
        updateInfoCenter(title:title)
        
        commandCenter.pauseCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            
            print("PAUSE")
            self.audioPlayer!.pause()
            return .success
            
        }
        
        commandCenter.playCommand.addTarget { (event) -> MPRemoteCommandHandlerStatus in
            
            print("PLAY")
            self.audioPlayer!.play()
            return .success
        }
        
    }
    
    func updateInfoCenter(title:String) {
        
        let totalCount = 0
        let playIndex = 0
        var nowPlayingInfo : [String : AnyObject] = [
            
            MPMediaItemPropertyPlaybackDuration : Float(0.0) as AnyObject,
            MPMediaItemPropertyTitle : title  as AnyObject,
            MPNowPlayingInfoPropertyElapsedPlaybackTime : Float(CMTimeGetSeconds(self.audioPlayer!.currentTime())) as AnyObject,
            MPNowPlayingInfoPropertyPlaybackQueueCount :totalCount as AnyObject,
            MPNowPlayingInfoPropertyPlaybackQueueIndex : playIndex as AnyObject,
            MPMediaItemPropertyMediaType : MPMediaType.anyAudio.rawValue as AnyObject]
        
        if let image = UIImage(named: "just_play_black") {
            nowPlayingInfo[MPMediaItemPropertyArtwork] =
            MPMediaItemArtwork(boundsSize: image.size) { size in
                // Extension used here to return newly sized image
                return image.imageWith(newSize: size)
            }
        }
        
        MPNowPlayingInfoCenter.default().nowPlayingInfo = nowPlayingInfo
    }
    
    
    func actionSheet() {
        //add test url
        guard let data = URL(string: "http://live.trusl.com:1150") else { return }
        let av = UIActivityViewController(activityItems: [data], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(av, animated: true, completion: nil)
    }
}
struct HomePlayer_Previews: PreviewProvider {
    static var previews: some View {
        HomePlayer()
    }
}

extension UIImage {
    func imageWith(newSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: newSize)
        let image = renderer.image { _ in
            self.draw(in: CGRect.init(origin: CGPoint.zero, size: newSize))
        }
        return image.withRenderingMode(self.renderingMode)
    }
}

