//
//  GLDynamicVideoContainer.swift
//  666
//
//  Created by Yanci on 2017/8/19.
//  Copyright © 2017年 Yanci. All rights reserved.
//

import UIKit
import Kingfisher

@objc class GLDynamicVideoContainer: UIView {
    
    // MARK: - public properties
    lazy var playBackView:GLAssetPlayBackView =  {
        let playbackView = GLAssetPlayBackView.init()
        return playbackView
    }()
    
    lazy var defaultImageView:UIImageView = {
        let defaultImageView = UIImageView.init()

        return defaultImageView
    }()
    
    lazy var playBtn:UIButton = {
        let playBtn = UIButton.init()
        playBtn.setImage(UIImage.init(named: "play_icon"), for: UIControlState.normal)
        playBtn.addTarget(self, action: #selector(self.play), for: UIControlEvents.touchUpInside)
        return playBtn
    }()
    
    // MARK: - const
    // MARK: - ui properties
    // MARK: - cache properties
    var _needsReload:Bool = false
    var defaultImageUrl:String?
    var videoUrl:String?
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.commonInit()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self._reloadDataIfNeed()
        self.defaultImageView.frame = self.bounds;
        self.playBtn.sizeToFit()
        self.playBtn.frame = CGRect.init(x: self.bounds.width / 2.0 - 15.0,
                                         y: self.bounds.height / 2.0 - 15.0,
                                         width: 30.0,
                                         height: 30.0)
        super.layoutSubviews()
    }
    // MARK: - Data Source
    // MARK: - Delegate
    // MARK: - User Events
    // MARK: - Funcs 
    func commonInit () {
        self.addSubview(self.defaultImageView)
        self.addSubview(self.playBtn)
        self.setNeedsReload()
    }
    
    func setNeedsReload() {
        _needsReload = true
        self.setNeedsLayout()
    }
    
    func _reloadDataIfNeed() {
        if _needsReload {
            self.reloadData()
        }
    }
    
    func setDynamicVideo(imageUrl:String,videoUrl:String) {
        self.defaultImageUrl = imageUrl
        self.videoUrl = videoUrl
        self.defaultImageView.kf.setImage(with: ImageResource.init(downloadURL: URL.init(string: imageUrl)!),
                                          placeholder:nil, completionHandler: nil);
    }
    
    func hasVideo() -> Bool {
        return self.defaultImageUrl != nil && self.videoUrl != nil
    }
    
    func  reloadData() {
        
    }
    
    func play() {
        
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
