//
//  PromotionViewModle.swift
//  yes
//
//  Created by MacBook on 2021-12-20.
//

import Foundation

class PromotionViewModle : ObservableObject {
    
    @Published var promotionLists : PromotionList?
    
    init() {
        
        getPromotionData()
    }
    
    func getPromotionData() {
        
        URLSession.fetch(request: URLRequest.getFormSirasa(), completion: { resp in
            switch resp {
                
            case .success(let result):
              
                if let data = result.data(using: .utf8){
                    do {
                        let decodedResponse = try JSONDecoder().decode(PromotionList.self, from: data)
                        DispatchQueue.main.async {
                            self.promotionLists = decodedResponse
                        }
                    } catch let jsonError as NSError {
                        print("JSON decode failed: \(jsonError.localizedDescription)")
                    }
                    return
                }
                
            case .failure(_):
                print("Error")
                
            }
        })
    }
}
