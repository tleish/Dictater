//
//  ViewController.swift
//  Dictate Assist
//
//  Created by Kyle Carson on 9/1/15.
//  Copyright © 2015 Kyle Carson. All rights reserved.
//

import Cocoa
import ProgressKit

class ViewController: NSViewController {
	
	var buttonController = SpeechButtonManager(speech: Speech.sharedSpeech)
	
	@IBOutlet var skipDurationMenuItem : NSMenuItem?
	
	@IBOutlet var progressView : ProgressBar?
	
	@IBOutlet var playPauseButton : NSButton?
	@IBOutlet var skipForwardButton : NSButton?
	@IBOutlet var skipBackwardsButton : NSButton?
	@IBOutlet var openTeleprompterButton : NSButton?
	@IBOutlet var remainingTimeView : NSTextField?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		self.setupSkipDurationMenuItem()
		
		self.buttonController.openTeleprompterButton = self.openTeleprompterButton
		self.buttonController.progressView = self.progressView
		self.buttonController.playPauseButton = self.playPauseButton
		self.buttonController.skipForwardButton = self.skipForwardButton
		self.buttonController.skipBackwardsButton = self.skipBackwardsButton
		self.buttonController.remainingTimeView = self.remainingTimeView
		
		self.buttonController.update()
	}
	
	override func viewWillAppear() {
		self.buttonController.registerEvents()
	}
	
	override func viewWillDisappear() {
		self.buttonController.deregisterEvents()
	}
	
	@IBAction func openSpeechPreferences(target: AnyObject?)
	{
        NSWorkspace.shared.openFile("/System/Library/PreferencePanes/Speech.prefPane")
	}
	
	@IBAction func openMenu(target: AnyObject?)
	{
		if let view = target as? NSView
		{
            view.menu?.popUp(positioning: nil, at: view.frame.origin, in: view.superview)
		}
	}
	
	// Skip Duration Settings
	
	func setupSkipDurationMenuItem()
	{
		if let item = self.skipDurationMenuItem
		{
			let boundary = Dictater.skipBoundary
			
			if let submenu = item.submenu
			{
                for child in submenu.items
				{
					if child.tag == boundary.rawValue
					{
                        child.state = NSControl.StateValue.on
					} else {
						child.state = NSControl.StateValue.off
					}
				}
			}
		}
	}
	
	@IBAction func changeSkipDuration(target: AnyObject?)
	{
		if let view = target as? NSMenuItem
		{
			if let boundary = Speech.Boundary(rawValue: view.tag)
			{
				Dictater.skipBoundary = boundary
				
				self.setupSkipDurationMenuItem()
			}
		}
	}
	
}

