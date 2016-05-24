//
//  AppDelegate.swift
//  project1
//
//  Created by JT Newsome on 2/7/16.
//  Copyright © 2016 JT Newsome. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var palette: Palette?
    
    var widthSlider: UISlider?
    
    var buttCapButton: UIButton?
    var roundCapButton: UIButton?
    var squareCapButton: UIButton?
    
    var miterJoinButton: UIButton?
    var roundJoinButton: UIButton?
    var bevelJoinButton: UIButton?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // RVC setup
        let rootViewController: UIViewController = UIViewController()
        rootViewController.view.backgroundColor = UIColor.lightGrayColor()
        let titleLabel = UILabel(frame: CGRectMake(CGRectGetMidX(UIScreen.mainScreen().bounds)-25, 20, 150 , 50))
        titleLabel.text = "Brush"
        titleLabel.textColor = UIColor.blackColor()
        rootViewController.view.addSubview(titleLabel)
        
        // Add palette subview
        palette = Palette(frame: CGRectMake(0, 65, UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height - 65))
        palette?.backgroundColor = UIColor.blackColor()
        rootViewController.view.addSubview(palette!)
        palette!.addTarget(self, action: "colorChanged", forControlEvents: .ValueChanged)
        
        // Slider to adjust width of "preview"
        widthSlider = UISlider(frame: CGRectMake(10, 425, 300, 50))
        widthSlider?.minimumValue = 0.0
        widthSlider?.maximumValue = 50.0
        widthSlider?.value = 25.0
        widthSlider?.addTarget(self, action: "widthSliderChanged", forControlEvents: .ValueChanged)
        rootViewController.view.addSubview(widthSlider!)
        
        // Cap: Butt
        buttCapButton = UIButton(frame: CGRectMake(30, 325, 70, 35))
        buttCapButton?.setTitle("Butt", forState: .Normal)
        buttCapButton?.backgroundColor = UIColor.blackColor()
        buttCapButton?.setTitleColor(UIColor.greenColor(), forState: .Normal)
        buttCapButton?.layer.cornerRadius = 10
        buttCapButton?.layer.borderWidth = 1.5
        buttCapButton?.addTarget(self, action: "buttCapButtonPressed", forControlEvents: .TouchUpInside)
        rootViewController.view.addSubview(buttCapButton!)
        
        // Cap: Round
        roundCapButton = UIButton(frame: CGRectMake(125, 325, 70, 35))
        roundCapButton?.setTitle("Round", forState: .Normal)
        roundCapButton?.backgroundColor = UIColor.blackColor()
        roundCapButton?.layer.borderColor = UIColor.yellowColor().CGColor
        roundCapButton?.setTitleColor(UIColor.greenColor(), forState: .Normal)
        roundCapButton?.layer.cornerRadius = 10
        roundCapButton?.layer.borderWidth = 1.5
        roundCapButton?.addTarget(self, action: "roundCapButtonPressed", forControlEvents: .TouchUpInside)
        rootViewController.view.addSubview(roundCapButton!)
        
        // Cap: Square
        squareCapButton = UIButton(frame: CGRectMake(220, 325, 70, 35))
        squareCapButton?.setTitle("Square", forState: .Normal)
        squareCapButton?.backgroundColor = UIColor.blackColor()
        squareCapButton?.setTitleColor(UIColor.greenColor(), forState: .Normal)
        squareCapButton?.layer.cornerRadius = 10
        squareCapButton?.layer.borderWidth = 1.5
        squareCapButton?.addTarget(self, action: "squareCapButtonPressed", forControlEvents: .TouchUpInside)
        rootViewController.view.addSubview(squareCapButton!)
        
        // Join: Miter
        miterJoinButton = UIButton(frame: CGRectMake(30, 375, 70, 35))
        miterJoinButton?.setTitle("Miter", forState: .Normal)
        miterJoinButton?.backgroundColor = UIColor.blackColor()
        miterJoinButton?.setTitleColor(UIColor.greenColor(), forState: .Normal)
        miterJoinButton?.layer.cornerRadius = 10
        miterJoinButton?.layer.borderWidth = 1.5
        miterJoinButton?.addTarget(self, action: "miterJoinButtonPressed", forControlEvents: .TouchUpInside)
        rootViewController.view.addSubview(miterJoinButton!)
        
        // Join: Round
        roundJoinButton = UIButton(frame: CGRectMake(125, 375, 70, 35))
        roundJoinButton?.setTitle("Round", forState: .Normal)
        roundJoinButton?.backgroundColor = UIColor.blackColor()
        roundJoinButton?.layer.borderColor = UIColor.yellowColor().CGColor
        roundJoinButton?.setTitleColor(UIColor.greenColor(), forState: .Normal)
        roundJoinButton?.layer.cornerRadius = 10
        roundJoinButton?.layer.borderWidth = 1.5
        roundJoinButton?.addTarget(self, action: "roundJoinButtonPressed", forControlEvents: .TouchUpInside)
        rootViewController.view.addSubview(roundJoinButton!)
        
        // Join: Bevel
        bevelJoinButton = UIButton(frame: CGRectMake(220, 375, 70, 35))
        bevelJoinButton?.setTitle("Bevel", forState: .Normal)
        bevelJoinButton?.backgroundColor = UIColor.blackColor()
        bevelJoinButton?.setTitleColor(UIColor.greenColor(), forState: .Normal)
        bevelJoinButton?.layer.cornerRadius = 10
        bevelJoinButton?.layer.borderWidth = 1.5
        bevelJoinButton?.addTarget(self, action: "bevelJoinButtonPressed", forControlEvents: .TouchUpInside)
        rootViewController.view.addSubview(bevelJoinButton!)
        
        // Make everything visible
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        window!.rootViewController = rootViewController
        window!.makeKeyAndVisible()
        
        return true;
    }
    
    // Called when color selector value is changed
    func colorChanged() {
        let color:UIColor = palette!.colorSelected
        miterJoinButton?.setTitleColor(color, forState: .Normal)
        roundJoinButton?.setTitleColor(color, forState: .Normal)
        bevelJoinButton?.setTitleColor(color, forState: .Normal)
        buttCapButton?.setTitleColor(color, forState: .Normal)
        roundCapButton?.setTitleColor(color, forState: .Normal)
        squareCapButton?.setTitleColor(color, forState: .Normal)
    }
    
    // Called when the widthSlider value is changed
    func widthSliderChanged() {
        // When you move the slider change the lineWidth value so "preview" is redrawn
        palette?.lineWidth = CGFloat(widthSlider!.value)
    }

    // Called when buttCapButton has been pressed and released
    func miterJoinButtonPressed() {
        setJoinButtonSelect(1)
        palette?.lineJoin = CGLineJoin.Miter
    }
    
    // Called when roundJoinButton has been pressed and released
    func roundJoinButtonPressed() {
        setJoinButtonSelect(2)
        palette?.lineJoin = CGLineJoin.Round
    }
    
    // Called when bevelButton has been pressed and released
    func bevelJoinButtonPressed() {
        setJoinButtonSelect(3)
        palette?.lineJoin = CGLineJoin.Bevel
    }
    
    // Updates button border colors given a selected joinOption
    // @joinOption: 1 = Miter, 2 = Round, 3 = Bevel
    func setJoinButtonSelect(joinOption: Int) {
        
        // Reset all border colors to default first
        miterJoinButton?.layer.borderColor = UIColor.blackColor().CGColor
        roundJoinButton?.layer.borderColor = UIColor.blackColor().CGColor
        bevelJoinButton?.layer.borderColor = UIColor.blackColor().CGColor
        
        // Change border color for the currently selected button
        if (joinOption == 1) {
            miterJoinButton?.layer.borderColor = UIColor.yellowColor().CGColor
        }
        else if (joinOption == 2) {
            roundJoinButton?.layer.borderColor = UIColor.yellowColor().CGColor
        }
        else if (joinOption == 3) {
            bevelJoinButton?.layer.borderColor = UIColor.yellowColor().CGColor
        }
    }
    
    // Called when buttCapButton has been pressed and released
    func buttCapButtonPressed() {
        setCapButtonSelect(1)
        palette?.lineCap = CGLineCap.Butt
    }
    
    // Called when buttCapButton has been pressed and released
    func roundCapButtonPressed() {
        setCapButtonSelect(2)
        palette?.lineCap = CGLineCap.Round
    }
    
    // Called when buttCapButton has been pressed and released
    func squareCapButtonPressed() {
        setCapButtonSelect(3)
        palette?.lineCap = CGLineCap.Square
    }
    
    // Updates button border colors given a selected capOption
    // @capOption: 1 = Butt, 2 = Round, 3 = Square
    func setCapButtonSelect(capOption: Int) {
        
        // Reset all border colors to default first
        buttCapButton?.layer.borderColor = UIColor.blackColor().CGColor
        roundCapButton?.layer.borderColor = UIColor.blackColor().CGColor
        squareCapButton?.layer.borderColor = UIColor.blackColor().CGColor
        
        // Change border color for the currently selected button
        if (capOption == 1) {
            buttCapButton?.layer.borderColor = UIColor.yellowColor().CGColor
        }
        else if (capOption == 2) {
            roundCapButton?.layer.borderColor = UIColor.yellowColor().CGColor
        }
        else if (capOption == 3) {
            squareCapButton?.layer.borderColor = UIColor.yellowColor().CGColor
        }
    }

    //
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

