//
//  ViewController.swift
//  Puzzle
//
//  Created by David Christy on 13/11/2014.
//  Copyright (c) 2014 David Christy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var LblDebug: UILabel!
    var _gameEngine: GameEngine?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var v = UIView(frame: CGRectMake(50, 50, 150, 150))
        v.backgroundColor = UIColor.blueColor()
        self.view.addSubview(v)
        
        let b = UIScreen.mainScreen().bounds
        
        LblDebug.text = "Width: \(b.width) Height: \(b.height)"
        LblDebug.sizeToFit()
        LblDebug.setNeedsLayout()
        
        //
        _gameEngine = GameEngine()
        _gameEngine?.setupNewGame()
        //_gameController?.initializeNewGame()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

