//
//  TopView.swift
//  yes
//
//  Created by MacBook on 2021-12-06.
//

import SwiftUI

struct TopView: View {
    @Environment(\.openURL) var openURL
    @State var menuOpen: Bool = false
    var body: some View {
        ZStack{
            VStack {
                ZStack(alignment: .bottom)  {
                    Color.white
                        .edgesIgnoringSafeArea(.top)
                    HStack {
                        let topDim = UIScreen.main.bounds.width/13
                        //    if !self.menuOpen {
                        Button(action: {
                            self.openMenu()
                        }){
                            Image("menu")
                                .resizable()
                                .scaledToFit()
                                .frame(width:topDim, height:topDim*12/15, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }.padding(.leading, 20)
                         
                        //  }
                        
                        Spacer()
                        Image("jpLogo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: UIScreen.main.bounds.width/4,alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(.trailing, 20)
                            .onTapGesture {
                                NotificationCenter.default.post(name: NSNotification.ImageClick,object: nil, userInfo: ["info": "home"])
                            }
                        Spacer()
                    }.padding(.bottom, 5)
                }.frame(height: UIScreen.main.bounds.height/10)
                Spacer()
            }
            SideMenu(width: UIScreen.main.bounds.width * 3/5,
                     isOpen: self.menuOpen,
                     menuClose: self.openMenu)
        }.edgesIgnoringSafeArea(.top)
    }
    
    struct MenuContent: View {
        @State var menuOpen: Bool = false
        var body: some View {
            ZStack {
                VStack (spacing:0){
                    Spacer()
                    Image("just_play_white")
                        .resizable()
                        .scaledToFit()
                        .frame(width:UIScreen.main.bounds.height/7,alignment: .center)
                        .padding(.trailing, UIScreen.main.bounds.width * 1/6)
                        .padding(.top, 40)
                        .onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.ImageClick,object: nil, userInfo: ["info": "home"])
                        }
                       
                    List {
                        
                        Text("Podcasts (coming soon)").onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.ImageClick,object: nil, userInfo: ["info": "1"])
                        }.listRowBackground(Color.black)
                        Text("YES101 Curated").onTapGesture {
                            if let url = NSURL(string: "https://open.spotify.com/user/whfmwhvtgsvjgv61k1pssaltx") {
                                UIApplication.shared.openURL(url as URL)
                               }
                        }.listRowBackground(Color.black)
                        Text("News First").onTapGesture {
                            if let url = NSURL(string: "https://www.newsfirst.lk/tag/website/") {
                                UIApplication.shared.openURL(url as URL)
                               }
                        }.listRowBackground(Color.black)
                        Text("Events & Promotion").onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.ImageClick,object: nil, userInfo: ["info": "4"])
                        }.listRowBackground(Color.black)
                        Text("Program Lineup").onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.ImageClick,object: nil, userInfo: ["info": "5"])
                        }.listRowBackground(Color.black)
                        Text("Song Request").onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.ImageClick,object: nil, userInfo: ["info": "6"])
                        }.listRowBackground(Color.black)
                   
                        Text("Exit").onTapGesture {
                            NotificationCenter.default.post(name: NSNotification.ImageClick,object: nil, userInfo: ["info": "7"])
                        }.listRowBackground(Color.black)
                        
                    }.foregroundColor(.white)
                        .background(Color.black.ignoresSafeArea())
                        .onAppear {
                            // Set the default to clear
                            UITableView.appearance().backgroundColor = .clear
                        }
                    
                }.background(Color.black)
            }
        }
    }
    
    struct SideMenu: View {
        let width: CGFloat
        let isOpen: Bool
        let menuClose: () -> Void
        
        var body: some View {
            ZStack {
                GeometryReader { _ in
                    EmptyView()
                }
                .background(Color.gray.opacity(0.3))
                .opacity(self.isOpen ? 1.0 : 0.0)
                .animation(Animation.easeIn.delay(0.25))
                .onTapGesture {
                    self.menuClose()
                }
                
                HStack {
                    MenuContent()
                        .frame(width: self.width)
                        .background(Color.white)
                        .offset(x: self.isOpen ? 0 : -self.width)
                        .animation(.default)
                    Spacer()
                }.simultaneousGesture(
                    TapGesture()
                        .onEnded { _ in
                            self.menuClose()
                        }
                )
                
            }
        }
    }
    
    func openMenu() {
        self.menuOpen.toggle()
    }
}

struct TopView_Previews: PreviewProvider {
    static var previews: some View {
        TopView()
    }
}

