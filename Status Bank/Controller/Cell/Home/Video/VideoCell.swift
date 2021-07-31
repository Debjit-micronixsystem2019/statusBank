//
//  VideoCell.swift
//  Status Bank
//
//  Created by admin on 4/17/20.
//  Copyright © 2020 admin. All rights reserved.
//


import UIKit
import AVKit
import AVFoundation
import MBProgressHUD

protocol MyCellDelegate : class {
    func didTapPlayButtonInCell(_ cell: VideoCell)
    func Slidertap(_ cell: VideoCell, sender : UISlider)
    func didTapForwardBtn(_ cell: VideoCell)
    func didTapBackwardBtn(_ cell: VideoCell)
}

class VideoCell: UITableViewCell {
    
     weak var delegate: MyCellDelegate?
     var imagetap = ""
     var videoButnTouch : Bool = false
    
    @IBOutlet weak var favouriteBtn : UIButton!
    @IBOutlet weak var repoprtBtn : UIButton!
    @IBOutlet weak var shareeBtn : UIButton!
    @IBOutlet weak var timeLbl : UILabel!
    @IBOutlet weak var textLblTitle : UILabel!
    @IBOutlet weak var PlayerView : PlayerView!
    @IBOutlet var forwardlbl: UILabel!
    @IBOutlet var backwardlbl: UILabel!
    @IBOutlet var slider: UISlider!
    @IBOutlet var forwardBtn: UIButton!
    @IBOutlet var backwardBtn: UIButton!
    @IBOutlet var playBtn: UIButton!
    @IBOutlet var firstPlayBtn: UIButton!
    @IBOutlet weak var VwPlayTool : UIView!{
           didSet{
               VwPlayTool.isHidden = true
           }
       }
       
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
    PlayerView.isUserInteractionEnabled = true
    PlayerView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(imageTapped(_:))))
        
        firstPlayBtn.isHidden = false
    }

    @objc func imageTapped(_ sender: UITapGestureRecognizer) {
        if imagetap == "0"{
            VwPlayTool.isHidden = false
             imagetap = "1"
        }else if imagetap == "1"{
            VwPlayTool.isHidden = true
            imagetap = "0"
           }
        }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    @IBAction func plyBTn (_ sender : Any){
        delegate?.didTapPlayButtonInCell(self)
        imagetap = "1"
    }
    
    @IBAction func plyStartBTn (_ sender : Any){
        delegate?.didTapPlayButtonInCell(self)
        videoButnTouch = true
        firstPlayBtn.isHidden = true
        VwPlayTool.isHidden = false
        imagetap = "1"
        NotificationCenter.default.addObserver(self, selector: #selector(playerEndedPlaying), name:Notification.Name("AVPlayerItemDidPlayToEndTimeNotification"), object: nil)
         ducation()
       MBProgressHUD.showAdded(to: (self.PlayerView)!, animated: true)
        
       }
    
   @IBAction func farwardBTn (_ sender : Any){
    delegate?.didTapForwardBtn(self)
    
    }
   @IBAction func backwardBTn (_ sender : Any){
    delegate?.didTapBackwardBtn(self)
       }
    
   @IBAction func timeslider (_ sender : UISlider){
    delegate?.Slidertap(self, sender: sender)
    }
    
    @objc func playerEndedPlaying(_ notification: Notification) {
            DispatchQueue.main.async {[weak self] in
            if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
            self!.playBtn.setTitle("Play", for: .normal)
            }
        }
        ducation()
    }
    func ducation() {
          guard let duration = PlayerView.player?.currentItem?.duration else {return}
              
              let Time : Double = CMTimeGetSeconds(duration)
              print(Time,"Time")
              
              print("CMTimeGetSeconds(duration)",CMTimeGetSeconds(duration))
              
              
        let hours = Int(Time/3600)
              let minutes = Int(Time/60) % 60
              let seconds = Int(Time.truncatingRemainder(dividingBy: 60))
              if hours > 0 {
                let item = String(format: "%i:%02i:%02i", arguments: [hours,minutes,seconds])
                 // print(item,"item")
                forwardlbl.text = item
                  
              }else {
                 let itemsec = String(format: "%02i:%02i", arguments: [minutes,seconds])
                 // print(itemsec,"itemsec")
                forwardlbl.text = itemsec
            }
        }
    }


   
