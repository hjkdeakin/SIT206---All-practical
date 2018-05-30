//
//  ViewController.swift
//  Music Player
//
//  Created by HYUNGJIN KIM on 27/3/18.
//  Copyright © 2018 HYUNGJIN KIM. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Vars
    var filterBySinger = "All"
    var musicPlayer : MusicPlayer = MusicPlayer( PlayList() )
    var isPlaying : Bool = false
    var timer : Timer!
    var playOrResume : Bool = false
    
    //IBOutlets
    
    @IBOutlet weak var singerImg: UIImageView!
    @IBOutlet weak var noewPlayingLabel: UILabel!
    @IBOutlet weak var elapsedTimeLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var songProgress: UIProgressView!
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var playButton: UIButton!
    
    //Functions
    
    @objc func updateRealtimeUI(){
        let currentSong = musicPlayer.getCurrentSong()
        let progress = Float( currentSong.timeElapsed / currentSong.duration )
        songProgress.setProgress(progress, animated: true)
        let elapsedTime = Int(currentSong.timeElapsed.nextUp)
        let remainingTime = Int(currentSong.duration.nextUp) - elapsedTime
        elapsedTimeLabel.text = "\(elapsedTime)"
        remainingTimeLabel.text = "\(remainingTime)"
    }
    func updateUI(){
        let currentSong = musicPlayer.currentSong
        singerImg.image = UIImage(named : currentSong.singer)
        noewPlayingLabel.text = currentSong.title
    }
    
    //IBActions
    
    @IBAction func play(_ sender: UIButton) {
        if playOrResume == true{
            musicPlayer.resume()
        }
        else{
            musicPlayer.play(filterBy: filterBySinger)
        }
        updateUI()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateRealtimeUI), userInfo: nil, repeats: true)
    }
    
    @IBAction func pause(_ sender: Any) {
        musicPlayer.pause()
        playOrResume = true
    }
    
    @IBAction func previous(_ sender: UIButton) {
        musicPlayer.previous(filterBy: filterBySinger)
        updateUI()
    }
    
    @IBAction func next(_ sender: UIButton) {
        musicPlayer.next(filterBy: filterBySinger)
        updateUI()
    }
    
    @IBAction func stop(_ sender: UIButton) {
        musicPlayer.stop()
        playOrResume = false
        updateUI()
    }
    
    @IBAction func changeVolume(_ sender: UISlider) {
        musicPlayer.changeVolume(newValue: sender.value)
    }
}

