//
//  ProgramListRawView.swift
//  yes
//
//  Created by MacBook on 2021-12-19.
//

import SwiftUI
import Kingfisher
import UserNotifications

struct ProgramListRawView: View {
    
    var programename : String
    var programenameTime : String
    var programenametype : String
    var imageUrl : String
    var backgroundImage : String
    @State var isNotify : Bool
    let capsuleWidth = UIScreen.main.bounds.width/5 - 10
    
    var body: some View {
        
        ZStack {
            Image(backgroundImage)
                .resizable()
                .frame(width:UIScreen.main.bounds.width, height:UIScreen.main.bounds.height/9)
            HStack {
                ZStack {
                    Circle()
                        .fill(Color.white)
                        .frame(width:capsuleWidth - 9 , height: capsuleWidth - 9)
                    VStack {
                        ActivityIndicator(isAnimating: .constant(true), style: .medium)
                    }.frame(width:capsuleWidth - 9 , height: capsuleWidth - 9)
                    
                    let url = URL(
                        string: imageUrl
                    )
                    if !imageUrl.isEmpty {
                        KFImage(url)
                            .resizable()
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                            .frame(width:capsuleWidth, height:capsuleWidth)
                        
                    }else {
                        Image("singer")
                            .resizable()
                            .clipShape(Circle())
                            .shadow(radius: 10)
                            .overlay(Circle().stroke(Color.white,  lineWidth: 1))
                            .frame(width:capsuleWidth, height:capsuleWidth)
                    }
                    //                    HStack{
                    //                        VStack(){
                    //                            Image(self.isNotify == false ? "NOTIFICATION":"NOTIFICATIONFill")
                    //                                .resizable()
                    //                                .scaledToFit()
                    //                                .frame(width:capsuleWidth/3, height:capsuleWidth/3)
                    //                            
                    //                            
                    //                            Spacer()
                    //                        }.edgesIgnoringSafeArea(.all)
                    //                            .onTapGesture {
                    //                                self.isNotify.toggle()
                    //                                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    //                                    if success {
                    //                                      //  UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                    //                                        
                    //                                        let content = UNMutableNotificationContent()
                    //                                        content.title = programename
                    //                                        content.subtitle = programenameTime
                    //                                        content.sound = UNNotificationSound.default
                    //
                    //                                        // show this notification five seconds from now
                    //                                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
                    //
                    //                                        // choose a random identifier
                    //                                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                    //
                    //                                        // add our notification request
                    //                                        UNUserNotificationCenter.current().add(request)
                    //                                        
                    //                                        print("Show details for user",programename)
                    //                                    } else if let error = error {
                    //                                        print(error.localizedDescription)
                    //                                    }
                    //                                }
                    //                                
                    //                            }
                    //                        
                    //                        Spacer()
                    //                    }.edgesIgnoringSafeArea(.all)
                    //                        .frame(width:capsuleWidth, height:capsuleWidth)
                    
                    
                }.padding(10)
                Spacer()
                VStack(alignment:.trailing ,spacing: 2){
                    
                    Text(programename).font(.headline)
                    Text(programenameTime)
                    Text(programenametype).font(.caption)
                    
                }.foregroundColor(.white)
                    .padding(10)
                
            }.listRowBackground(Color.bgHome)
                .padding(10)
            
            
        }.background(Color.black)
            .edgesIgnoringSafeArea(.all)
        
    }
}


