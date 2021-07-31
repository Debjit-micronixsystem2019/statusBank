//
//  FetchJson.swift
//  Status Bank
//
//  Created by admin on 4/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import Alamofire
import MBProgressHUD

protocol jsonDataDelegate {
    func didReceivedData(_ data: Any, jsonname: String) -> Void
    func didFailedReceivedData(_ error : Error) -> Void
}

class jasonFetchClass: NSObject{
    
    var jsondata : jsonDataDelegate?
    
    func fetchData(_ parameters: [String: Any], methodtype: String ,url: String ,jsonname: String ) -> Void {
        
                DispatchQueue.main.async {
                    
                    if Reachability.isConnectedToNetwork(){
                        
                        if methodtype == "post" || methodtype == "Post"{
                            
                            let parameters1: [String: Any] = parameters
                            
                            AF.request(url, method: .post, parameters: parameters1, encoding: JSONEncoding.default, headers: [:])
                                .responseJSON   {
                                    response in
                                    
                                    print(response.data as Any)
                                    
                                    switch(response.result){
          
                                    case .success(_):
                                        
                                        if let data = response.value as? NSDictionary{
                                            self.jsondata?.didReceivedData(data, jsonname: jsonname)
                                        }
                                        
                                        break
                                    case .failure(_):
                                        self.jsondata?.didFailedReceivedData(response.error!)
                                        break
                                    }
                                    
                            }
                            
                        }
                     else if methodtype == "GeT" || methodtype == "get"{
                                   
                                    let urlLink :String =  url
                                            
                                            
                                    let encodedHost = urlLink.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
                                            
                                          
                                            
                                    print(encodedHost!)
                                            
                                AF.request(URL(string: encodedHost!)!,method: .get, parameters: nil, encoding: JSONEncoding.default, headers: [:])
                                                .responseJSON {
                                                    response in
                                                    
                                                    switch(response.result) {
                                                        
                                                    case .success(_):
                                                        
                                                   if let data = response.value as? NSDictionary{
                                                    self.jsondata?.didReceivedData(data, jsonname: jsonname)
                                                    }
                                                        
                                                        
                                                        break
                                                        
                                                    case .failure(_):
                                                        
                                                        self.jsondata?.didFailedReceivedData(response.error!)
                                                        
                                                        break
                                                        
                                                    }
                                            }
                                            
                                            
                                            
                                        }
                                    
                                        
                                    }
                                    else{
                                        
                                        
                        self.jsondata?.didReceivedData("NO INTERNET CONNECTION", jsonname: "NoInternet")
                                        
                                    }
                                }
                                
                            }
                            
    }
