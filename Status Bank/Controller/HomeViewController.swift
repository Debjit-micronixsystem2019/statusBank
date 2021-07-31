//
//  HomeViewController.swift
//  Status Bank
//
//  Created by admin on 4/9/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit
import MBProgressHUD
import Toast_Swift
import AVKit
import AVFoundation
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var navVW : UIView!
    @IBOutlet weak var backBtn : UIButton!
    
    var PauseScrollTime : Double  = 0.0
    var menuarray = [menuCollection]()
    var jsonfetch = jasonFetchClass()
    var HomeDataArray = [Homedatadic]()
    var ScrollUpDown : Bool = false
    var videoload : Bool = false
    var time = Timer?.self
    
    
    @IBOutlet weak var categoryBtn : UIButton!
    @IBOutlet weak var TableVW : UITableView!
    @IBOutlet weak var MenuTableVW : UITableView!
    @IBOutlet weak var userRndVw : UIView!{
        didSet{
            self.userRndVw.layer.cornerRadius = self.userRndVw.frame.size.width / 2
            self.userRndVw.clipsToBounds = true
        }
    }
    @IBOutlet weak var userNmeLbl : UILabel!
    @IBOutlet weak var MenuBackVW : UIView!{
        didSet{
            MenuBackVW.isHidden = true
        }
    }
    
    var sel = "0"
    
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nibNameVDO = UINib(nibName: "VideoCell", bundle:nil)
        TableVW.register(nibNameVDO, forCellReuseIdentifier: "VideoCell")
        let nibNameeIMG = UINib(nibName: "ImageCell", bundle:nil)
        TableVW.register(nibNameeIMG, forCellReuseIdentifier: "ImageCell")
        let nibNameeTXT = UINib(nibName: "TextCell", bundle:nil)
        TableVW.register(nibNameeTXT, forCellReuseIdentifier: "TextCell")
        
         NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
       
        if  UIDevice.current.model == "iPad"{
        self.navVW.frame = CGRect(x: 10, y: 20, width: 95, height: 110)
          }else{
        self.navVW.frame = CGRect(x: 10, y: 20, width: 75, height: 75)
          }
    
        self.navigationController?.view.addSubview(navVW)
        self.navigationController?.navigationBar.isHidden = true
        
        jsonfetch.jsondata = self
        if  UIDevice.current.model == "iPad"{
            designBtnLbl(name: categoryBtn, radius: 35, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
              }else{
            designBtnLbl(name: categoryBtn, radius: 18, color: #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1))
              }
        
        MenuTableVW.delegate = self
        MenuTableVW.dataSource = self
        TableVW.delegate = self
        TableVW.dataSource = self
        
        print("Device Type : ",UIDevice.current.model)
        
        menuarrayLoad()
        hidemenuview()
        fetchData()
        }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navVW.isHidden = true
        }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navVW.isHidden = false
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
     
    @objc func loadList(notification: NSNotification){
        //load data here
        
       sel = "1"
        
        DispatchQueue.main.async {
            self.HomeDataArray.removeAll()
             
                  }
       
        fetchCatagoryIDData()
         DispatchQueue.main.async {
            self.TableVW.reloadData()
           }
        }
    

    func menuarrayLoad(){
        menuarray.append(menuCollection(icon: "Dashboard_icon", name: "Dashboard"))
        menuarray.append(menuCollection(icon: "favourit-icon", name: "Favourite"))
        menuarray.append(menuCollection(icon: "advertige-icon", name: "Premium Share"))
        menuarray.append(menuCollection(icon: "wallet-icon4", name: "Wallet"))
        menuarray.append(menuCollection(icon: "upgrade", name: "Upgrade"))
        menuarray.append(menuCollection(icon: "supports-icon", name: "Support"))
        menuarray.append(menuCollection(icon: "logout-icon", name: "Logout"))
        
    }

    @IBAction func menuBTNActn(_ sender : Any){
        MenuBackVW.isHidden = false
    }
    
    @IBAction func categoryBTNActn(_ sender : Any){
        
      
        
            let categoryVC = self.storyboard?.instantiateViewController(identifier: "CategoryViewController") as! CategoryViewController
            categoryVC.modalPresentationStyle = .overCurrentContext
            categoryVC.selectCategory = { (Category) in
            print("Selected Category : ",Category)
            self.categoryBtn.setTitle("     \(Category)", for: .normal)
            self.categoryBtn.textInputContextIdentifier
            }
        self.present(categoryVC, animated: true, completion: nil)
       }
    
    
    func  hidemenuview(){
        let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(HomeViewController.dismissmenuview))
        tap.cancelsTouchesInView = false
        MenuBackVW.addGestureRecognizer(tap)
             }
    
       @objc func dismissmenuview(){
            MenuBackVW.isHidden = true
             }
    
    
    func fetchData()  {
           let parms = [
           "user_id":store_User_id,
           "actiontype":"get_posts"
            ]
            print(parms)
            MBProgressHUD.showAdded(to: (self.view)!, animated: true)
            jsonfetch.fetchData(parms, methodtype: "post", url: BaseUrl, jsonname: "get_posts")
            }
        }

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       if tableView == MenuTableVW{
            return menuarray.count
          }
            return HomeDataArray.count
        }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        if tableView == MenuTableVW{
            let cell = MenuTableVW.dequeueReusableCell(withIdentifier: "MenuViewCell", for: indexPath) as! MenuViewCell
            cell.Img.image = UIImage(named: menuarray[indexPath.row].icon ?? "")
            cell.lbl.text = menuarray[indexPath.row].name
         
             return cell
                }
      
       
        
        var SelCell = UITableViewCell()
        switch HomeDataArray[indexPath.row].post_type {
        case "image":
            
            let cell = TableVW.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
            cell.textLblTitle.text =  HomeDataArray[indexPath.row].post_title ?? ""
            cell.Img.kf.setImage(with: URL(string: HomeDataArray[indexPath.row].post_file!))
            SelCell = cell
        
            break
        case "text":
                let cell = self.TableVW.dequeueReusableCell(withIdentifier: "TextCell", for: indexPath) as! TextCell
                cell.textLblTitle.text =  self.HomeDataArray[indexPath.row].post_title ?? ""
                cell.textLblDescription.text =  self.HomeDataArray[indexPath.row].post_decription ?? ""
                SelCell = cell
    
            break
        case"video":
            
            let cell = TableVW.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
            
            cell.delegate = self
            cell.textLblTitle.text =  HomeDataArray[indexPath.row].post_title ?? ""

            let url = NSURL(string: HomeDataArray[indexPath.row].post_file!);
            let avPlayer = AVPlayer(url: url as! URL);
            
            cell.PlayerView?.playerLayer.player = avPlayer
            cell.PlayerView.playerLayer.videoGravity = .resize
            
            let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
            let mainQueue = DispatchQueue.main
            cell.PlayerView.player?.addPeriodicTimeObserver(forInterval: interval, queue: mainQueue, using: { [weak self] time in
            guard let currentItem = cell.PlayerView.player?.currentItem else {return}
            cell.slider.maximumValue = Float(currentItem.duration.seconds)
            cell.slider.minimumValue = 0
            cell.slider.value = Float(currentItem.currentTime().seconds)
            cell.backwardlbl.text = self!.getTimeString(from: currentItem.currentTime())
            
            let currentTime = CMTimeGetSeconds(cell.PlayerView.player!.currentTime())
                    if currentTime >  0.1{
                              MBProgressHUD.hide(for: (cell.PlayerView)!, animated: true)
                           }
                       })
            
            //Mark:-For video Buffer
            
          /*  let playerItem = AVPlayerItem(url: url as! URL)
            playerItem.addObserver(self, forKeyPath: "playbackBufferEmpty", options: .new, context: nil)
            playerItem.addObserver(self, forKeyPath: "playbackLikelyToKeepUp", options: .new, context: nil)
            playerItem.addObserver(self, forKeyPath: "playbackBufferFull", options: .new, context: nil)

                avPlayer.replaceCurrentItem(with: playerItem)
                avPlayer.automaticallyWaitsToMinimizeStalling = false
                avPlayer.playImmediately(atRate: 0)
          //  avPlayer.automaticallyWaitsToMinimizeStalling = .playWhenBufferNotEmpty
          //preferredForwardBufferDuration -> default is 0, which means `AVPlayer` handle it independently, try more seconds like 5 or 10.
          playerItem.preferredForwardBufferDuration = TimeInterval(5)*/
            SelCell = cell
             break
    default:
            break
        }
        return SelCell
    }
 
 /*  override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
       if object is AVPlayerItem {
           switch keyPath! {
           case "playbackBufferEmpty":
               // Show loader
            print(00000000)

           case "playbackLikelyToKeepUp":
               // Hide loader
               print(111111)
               let cell = TableVW.dequeueReusableCell(withIdentifier: "VideoCell") as! VideoCell
               DispatchQueue.main.async {
               MBProgressHUD.showAdded(to: cell.self, animated: true)
               }
              
           case "playbackBufferFull":
               // Hide loader
              print(22222)

           default:
               return
           }
       }
   }*/

    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! VideoCell
        if let player = cell.PlayerView.player {
            if player.rate != 0 {
                player.pause()
                cell.playBtn.setTitle("Play", for: .normal)
                ScrollUpDown = true
                let currentTime = CMTimeGetSeconds(cell.PlayerView.player!.currentTime())
                PauseScrollTime = currentTime
            }
        }
    }
    
    

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if  UIDevice.current.model == "iPad"{
            if tableView == MenuTableVW{
                return 100
            }
             return 500
        }else{
            if tableView == MenuTableVW{
                return 60
                }
            return 300
            }
        }
      
      func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if tableView == MenuTableVW{
        return 1
        }else{
          return 0
            }
       }
 
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              
        if tableView == MenuTableVW{
            if indexPath.row == 0{
            let vc = storyboard?.instantiateViewController(identifier: "ProfileVWController") as! ProfileVWController
            self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
            }
        }


extension HomeViewController : jsonDataDelegate{
    func didReceivedData(_ data: Any, jsonname: String) {
        print("rawData",data)
        print("jsonname",jsonname)
        
        if data as? String ==  "NO INTERNET CONNECTION" {
            DispatchQueue.main.async {
            MBProgressHUD.hide(for: (self.view)!, animated: true)
            }
            showAlertMessageokkk(alertTitle: "Network !", alertMsg: "Check your internet connection please")
            
            }else{
                if let cdata = convertToData(givingValue: data){
                    do{
                    let jsonData = try JSONDecoder().decode(HomeData.self, from: cdata)
                     if jsonData.status == "Yes"{
                        
                      
                            if jsonData.data?.count ?? 0 > 0{
                            HomeDataArray = jsonData.data!
                            
                                 }
                        self.TableVW.reloadData()
                         
                         print("HomeDataArray",HomeDataArray)
                         DispatchQueue.main.async {
                         MBProgressHUD.hide(for: (self.view)!, animated: true)
                            }
                          }else{
                        
                        DispatchQueue.main.async {
                        MBProgressHUD.hide(for: (self.view)!, animated: true)
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
                MBProgressHUD.hide(for: (self.view)!, animated: true)
                     }
                showAlert(title: "Error", message: "Something going wrong,try latter", noOfButton: 1,selectorMethod:())
             }
        
         func convertToData(givingValue: Any) -> Data? {
                return try? JSONSerialization.data(withJSONObject: givingValue, options: [])
        }
    
    }

extension HomeViewController{
    
    func fetchCatagoryIDData()  {
       
              let parms = [
                "post_cat_id":postcatid,
                "user_id":store_User_id,
                "actiontype":"get_posts_by_cat_id"
                               ]
                              print(parms)
                              
        MBProgressHUD.showAdded(to: (self.view)!, animated: true)
        jsonfetch.fetchData(parms, methodtype: "post", url: BaseUrl, jsonname: "get_posts_by_cat_id")
               }
        }


extension HomeViewController: MyCellDelegate {
    func didTapForwardBtn(_ cell: VideoCell) {
        guard let duration = cell.PlayerView.player!.currentItem?.duration else {return}
        let currentTime = CMTimeGetSeconds(cell.PlayerView.player!.currentTime())
        
        let newTime = currentTime + 3.0
        if newTime < (CMTimeGetSeconds(duration) - 3.0) {
        
        let time: CMTime = CMTimeMake(value: Int64(newTime*1000), timescale: 1000)
        cell.PlayerView.player?.seek(to: time)
            
            
        }
    }
    
    func didTapBackwardBtn(_ cell: VideoCell) {
        let currentTime = CMTimeGetSeconds(cell.PlayerView.player!.currentTime())
        var newTime = currentTime - 3.0
         if newTime < 0 {
            newTime = 0
         }
        let time: CMTime = CMTimeMake(value: Int64(newTime*1000), timescale: 1000)
        cell.PlayerView.player?.seek(to: time)

    }
    
    func Slidertap(_ cell: VideoCell, sender: UISlider) {
        cell.PlayerView.player!.seek(to: CMTimeMake(value: Int64(sender.value*1000), timescale: 1000))
        }
    
   
    
    func didTapPlayButtonInCell(_ cell: VideoCell) {
        
        if ScrollUpDown == true {
            let time: CMTime = CMTimeMake(value: Int64(PauseScrollTime*1000), timescale: 1000)
            cell.PlayerView.player?.seek(to: time)
            cell.PlayerView.player?.play()
            ScrollUpDown = false
            
        }else{
            if cell.videoButnTouch == true{
            cell.PlayerView.player?.pause()
            cell.playBtn.setTitle("Play", for: .normal)
            cell.videoButnTouch = false
                }else{
            cell.PlayerView.player!.play()
            cell.playBtn.setTitle("Pause", for: .normal)
            cell.videoButnTouch = true
            }
        }
    }
    
    
    func getTimeString(from time: CMTime) -> String {
        let totalSeconds = CMTimeGetSeconds(time)
        let hours = Int(totalSeconds/3600)
        let minutes = Int(totalSeconds/60) % 60
        let seconds = Int(totalSeconds.truncatingRemainder(dividingBy: 60))
        if hours > 0 {
            return String(format: "%i:%02i:%02i", arguments: [hours,minutes,seconds])
        }else {
            return String(format: "%02i:%02i", arguments: [minutes,seconds])
        }
     }
 }
