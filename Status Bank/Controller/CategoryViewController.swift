//
//  CategoryViewController.swift
//  Status Bank
//
//  Created by admin on 4/11/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import MBProgressHUD
import Toast_Swift

class CategoryViewController: UIViewController {
    
    var jsonfetch = jasonFetchClass()
    
    
    @IBOutlet weak var tableVW : UITableView!
     @IBOutlet weak var BckVW : UIView!
    
    var Categoryarray = [Catagorydatadic]()
    
    var selectCategory : ((String)->())!
   

    override func viewDidLoad() {
        super.viewDidLoad()
        jsonfetch.jsondata = self
        fetchCatagoryData()
        
        tableVW.delegate = self
        tableVW.dataSource = self
      hideView()
        
      
    }
    
    func  hideView(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CategoryViewController.dismissmenuview))
        tap.cancelsTouchesInView = false
               
        BckVW.addGestureRecognizer(tap)
             }
    
       @objc func dismissmenuview(){
            self.dismiss(animated: true, completion: nil)
            
    
             }
    
    func fetchCatagoryData()  {
           let parms = [
                         "actiontype":"category"
                            ]
                           print(parms)
                           
                        MBProgressHUD.showAdded(to: (tableVW)!, animated: true)
                           
                    jsonfetch.fetchData(parms, methodtype: "post", url: BaseUrl, jsonname: "Category Data")
        }

    }


extension CategoryViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Categoryarray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableVW.dequeueReusableCell(withIdentifier: "CategoryViewCell", for: indexPath) as! CategoryViewCell
        cell.Lbl.text = Categoryarray[indexPath.row].category_title
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      
          return 80
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
      
        return 0
   
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        print(indexPath.row)
        if indexPath.row == 0{
            postcatid = "2"
        }else{
            postcatid = "3"
        }
        selectCategory?(Categoryarray[indexPath.row].category_title ?? "")
        self.dismiss(animated: true, completion: nil)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
      
    }
}
extension CategoryViewController : jsonDataDelegate{
     func didReceivedData(_ data: Any, jsonname: String) {
         print("Raw Data",data)
         print("jsonname",jsonname)
        
       if data as? String ==  "NO INTERNET CONNECTION" {
           
           DispatchQueue.main.async {
               
            MBProgressHUD.hide(for: (self.tableVW)!, animated: true)
           }
           
           showAlertMessageokkk(alertTitle: "Network !", alertMsg: "Check your internet connection please")
           
}else{
        if let cdata = convertToData(givingValue: data){
            do{
                let jsonData = try JSONDecoder().decode(CatagoryData.self, from: cdata)
                 if jsonData.status == "Yes"{
                    
                    if jsonData.data?.count ?? 0 > 0{
                    Categoryarray = jsonData.data!
                    self.tableVW.reloadData()
                         }
                     print("Categoryarray",Categoryarray)
                    DispatchQueue.main.async {
                    MBProgressHUD.hide(for: (self.tableVW)!, animated: true)
                      }
                    }else{
                     DispatchQueue.main.async {
                     MBProgressHUD.hide(for: (self.tableVW)!, animated: true)
                        }
                    self.view.makeToast("Category data not available" , duration: 3.0, position: .bottom)
                    }
                }catch(let err){
                    print(err.localizedDescription)
             }
         }
    }
}
    
     
     func didFailedReceivedData(_ error: Error) {
         print(error.localizedDescription)
         
             DispatchQueue.main.async {
                 MBProgressHUD.hide(for: (self.tableVW)!, animated: true)
                 }
                  showAlert(title: "Error", message: "Something going wrong,try latter", noOfButton: 1,selectorMethod:())
         }
    
     func convertToData(givingValue: Any) -> Data? {
            return try? JSONSerialization.data(withJSONObject: givingValue, options: [])
     
          }
     
}

extension CategoryViewController{
    
    func fetchCatagoryIDData()  {
           let parms = [
                         "actiontype":"get_posts_by_cat_id",
                         "post_cat_id":postcatid
                            ]
                           print(parms)
                           
                        MBProgressHUD.showAdded(to: (tableVW)!, animated: true)
                           
                    jsonfetch.fetchData(parms, methodtype: "post", url: BaseUrl, jsonname: "CatagoryIDData")
            }
    
}
