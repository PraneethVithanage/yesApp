//
//  EventAndPromoView.swift
//  yes
//
//  Created by MacBook on 2021-12-06.
//

import SwiftUI
import Kingfisher


struct EventAndPromoView: View {
    
    @ObservedObject var viewModel = PromotionViewModle()
    
    var body: some View {
        
        ZStack {
            VStack(alignment:.center, spacing:0) {
                HStack {
                    Spacer()
                    Text("Event & Promotion")
                        .font(.title3).bold()
                        .foregroundColor(.gray)
                       
                    Spacer()
                    
                }.frame(width:UIScreen.main.bounds.width, height:40)
                    .background(Color.white)
            
                if  viewModel.promotionLists != nil {
                    let rowNum = viewModel.promotionLists?.count
                    
                    List(0 ..< rowNum! ){ row in
                        let title = String(htmlString:viewModel.promotionLists?.posts[row].title ?? "")
                        EventPromoRawView(imageUrl: viewModel.promotionLists?.posts[row].thumbnail ?? "" , title:title).listRowInsets(EdgeInsets()).frame(maxWidth: .infinity)
                        
                    }.frame(width: UIScreen.main.bounds.size.width,
                           alignment: .center)
                    .listRowInsets(.init())
                    .listStyle(GroupedListStyle())
                    .background(Color.black)
                    .onAppear {
                        // Set the default to clear
                        UITableView.appearance().backgroundColor = .clear
                        UITableView.appearance().contentInset.top = -35
                    }
                    
                } else {
                    LoadingView(isShowing: .constant(true)) {
                        List(0 ..< 0 ){ row in
                            
                            EventPromoRawView(imageUrl: "" , title:  "")
                        }
                    }
                    .background(Color.black.ignoresSafeArea())
                    .onAppear {
                        // Set the default to clear
                        UITableView.appearance().backgroundColor = .clear
                    }
                    
                }
            }.frame(width:UIScreen.main.bounds.width)
             .background(Color.black.edgesIgnoringSafeArea(.all))
        } .padding(.top,UIScreen.main.bounds.height/10)
    }
}

struct EventAndPromoView_Previews: PreviewProvider {
    static var previews: some View {
        EventAndPromoView()
    }
}

extension String {

    init(htmlString: String) {
        self.init()
        guard let encodedData = htmlString.data(using: .utf8) else {
            self = htmlString
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
            self = htmlString
        }
    }
}

