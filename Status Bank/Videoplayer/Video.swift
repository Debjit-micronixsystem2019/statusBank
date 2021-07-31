//
//  ToastAlert.swift
//  Status Bank
//
//  Created by admin on 4/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit
import AVKit
import AVFoundation

class PlayerView: UIImageView {
    
        override static var layerClass: AnyClass {
            return AVPlayerLayer.self;
        }

        var playerLayer: AVPlayerLayer {
            return layer as! AVPlayerLayer;
        }
        
        var player: AVPlayer? {
            get {
                return playerLayer.player;
            }
            set {
                playerLayer.player = newValue;
            }
        }
    
    

}

