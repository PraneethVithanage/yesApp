//
//  LandmarkList.swift
//  yes
//
//  Created by MacBook on 2021-12-05.
//

import Foundation
import SwiftUI

struct ProgramLineList: View {
    
    @ObservedObject var viewModel = HomePlayerViewModel()
    @State private var dayNumber = Calendar.current.component(.weekday, from: Date()) - 1
    @State private var bgImage = ["pr__1", "pr__2", "pr__3", "pr__4", "pr__5", "pr__6"]
    @State var isNotify : Bool = false
    @State var songs: [Int] = []
    @State var songsList : [String] = UserDefaults.standard.stringArray(forKey: "myKey") ?? []
    let capsuleWidth = UIScreen.main.bounds.width/5 - 10
    
    var body: some View {
        
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
            VStack(alignment:.center, spacing:0){
                HStack {
                    Button("  <") {
                        if dayNumber > 0 {
                            self.dayNumber -= 1
                        }else{
                            self.dayNumber = 6
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .font(Font.body.weight(.medium))
                    
                    Spacer()
                    if  viewModel.channelPrograms != nil {
                        Text(viewModel.channelPrograms![dayNumber].day).foregroundColor(.white).bold()
                    } else {
                        Text(DateFormatter().weekdaySymbols[dayNumber]).foregroundColor(.white).bold()
                    }
                    Spacer()
                    
                    Button(">  ") {
                        
                        if dayNumber < 6 {
                            self.dayNumber += 1
                        }else {
                            self.dayNumber = 0
                        }
                    }
                    .padding()
                    .foregroundColor(.white)
                    .font(Font.body.weight(.medium))
                    
                }.frame(width:UIScreen.main.bounds.width - 30, height:30)
                    .background(Color.bgHome)
                if  viewModel.channelPrograms != nil {
                    let rowNum = viewModel.channelPrograms![dayNumber].programlist.count
                    List(0 ..< rowNum ){ row in
                        if row <= rowNum - 1 {
                            let programList = viewModel.channelPrograms![dayNumber].programlist[row]
                            ZStack (alignment:.leading){
                                ProgramListRawView(programename:programList.channelProgramName, programenameTime: programList.channelProgramStartHour + " - " + programList .channelProgramEndHour,programenametype:programList.djName.replacingOccurrences(of: "&amp;", with: "&"), imageUrl:programList.coverImage, backgroundImage: bgImage[row % 6], isNotify: programList.isBellClick)
                                //  isNotify = programList.isBellClick
                                HStack{
                                    VStack(){
                                        if songsList.contains(String(programList.channelProgramAutoID)) {
                                            Image("NOTIFICATIONFill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width:capsuleWidth/3, height:capsuleWidth/3)
                                            
                                        } else {
                                            Image("NOTIFICATION")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width:capsuleWidth/3, height:capsuleWidth/3)
                                            
                                        }
                                        
                                        Spacer()
                                    }.edgesIgnoringSafeArea(.all)
                                        .onTapGesture {
                                            
                                            if songsList.contains(String(programList.channelProgramAutoID)) {
                                                
                                                if let index = songsList.firstIndex(of:String(programList.channelProgramAutoID)) {
                                                    songsList.remove(at: index)
                                                    UserDefaults.standard.set(songsList, forKey: "myKey")
                                                    
                                                }
                                                
                                            } else {
                                                
                                                songsList.append(String(programList.channelProgramAutoID))
                                                UserDefaults.standard.set(songsList, forKey: "myKey")
                                                
                                            }
                                            //                                            songsList.removeAll()
                                            //                                            UserDefaults.standard.set(songsList, forKey: "myKey")
                                            
                                            UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                                                if success {
                                                    
                                                    if  songsList.contains(String(programList.channelProgramAutoID)) == true {
                                                        //  UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                                                        let content = UNMutableNotificationContent()
                                                        content.title = programList.channelProgramName
                                                        content.subtitle = programList.channelProgramStartHour + " - " + programList .channelProgramEndHour
                                                        content.sound = UNNotificationSound.default
                                                        // show this notification five seconds from now
                                                        // Configure the recurring date.
                                                        var dateComponents = DateComponents()
                                                        
                                                        let dateAsString = "\(programList.channelProgramStartHour)"
                                                        let dateFormatter = DateFormatter()
                                                        dateFormatter.dateFormat = "h:mm a"

                                                        let date = dateFormatter.date(from: dateAsString)
                                                        dateFormatter.dateFormat = "HH:mm"

                                                        let Date24 = dateFormatter.string(from: date!)
                                                        
                                                        
                                                        dateComponents.weekday = dayNumber + 1 // Tuesday
                                                        dateComponents.hour = Int(Date24.replacingOccurrences(of: ":00", with: "", options: NSString.CompareOptions.literal, range: nil)) // 14:00 hours
                                                        let trigger = UNCalendarNotificationTrigger(
                                                            dateMatching: dateComponents, repeats: true)
                                                        //   let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 61, repeats: true)
                                                        // choose a random identifier
                                                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                                                        // add our notification request
                                                        UNUserNotificationCenter.current().add(request)
                                                        
                                                    } else {
                                                        UNUserNotificationCenter.current().getPendingNotificationRequests { (notificationRequests) in
                                                            var identifiers: [String] = []
                                                            for notificationRequest:UNNotificationRequest in notificationRequests {
                                                                print(notificationRequest.identifier)
                                                                
                                                                identifiers.append(notificationRequest.identifier)
                                                            }
                                                            
                                                            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: identifiers)
                                                        }
                                                    }
                                                    //    UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                                                    print("Show details for user")
                                                } else if let error = error {
                                                    print(error.localizedDescription)
                                                }
                                            }
                                            
                                        }
                                    Spacer()
                                }.edgesIgnoringSafeArea(.all)
                                    .frame(width:capsuleWidth, height:capsuleWidth)
                                    .padding(10)
                                
                            }.listRowBackground(Color.black)
                                .listRowInsets(EdgeInsets()).frame(maxWidth: .infinity)
                        }
                    }.frame(width: UIScreen.main.bounds.size.width,
                            alignment: .center)
                        .listRowInsets(.init())
                        .background(Color.black.ignoresSafeArea())
                        .listStyle(GroupedListStyle())
                        .onAppear {
                            // Set the default to clear
                            UITableView.appearance().backgroundColor = .clear
                            UITableView.appearance().contentInset.top = -10
                            // UITableView.appearance().contentInset.left = -20
                        }
                    
                } else {
                    LoadingView(isShowing: .constant(true)) {
                        List(0 ..< 10 ){ row in
                            
                            ProgramListRawView(programename:"AM 101", programenameTime: "00:00 NM - 05:00 AM",programenametype:"auto", imageUrl: "", backgroundImage: bgImage[1], isNotify:false).listRowInsets(EdgeInsets()).frame(maxWidth: .infinity)
                        }
                    }.frame(width: UIScreen.main.bounds.size.width,
                            alignment: .center)
                        .listRowInsets(.init())
                        .listStyle(GroupedListStyle())
                        .background(Color.black.ignoresSafeArea())
                        .onAppear {
                            // Set the default to clear
                            UITableView.appearance().backgroundColor = .clear
                            UITableView.appearance().contentInset.top = -10
                        }
                }
            }.padding(.top,UIScreen.main.bounds.height/10)
                .background(Color.black.edgesIgnoringSafeArea(.all))
        }.padding(.top,UIScreen.main.bounds.height/30)
            .background(Color.black.ignoresSafeArea())
        
    }
}

extension String {
    
    init(htmltring: String) {
        self.init()
        guard let encodedData = htmltring.data(using: .utf8) else {
            self = htmltring
            return
        }
        
        let attributedOptions: [NSAttributedString.DocumentReadingOptionKey : Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: encodedData,
                                                          options: attributedOptions,
                                                          documentAttributes: nil)
            self = attributedString.string
        } catch {
            print("Error: \(error.localizedDescription)")
            self = htmltring
        }
    }
}

struct programLine_Previews: PreviewProvider {
    static var previews: some View {
        
        ProgramLineList()
    }
}



