#   NSButtonTest2: test of Rigs::NSButton again!
#
#    Copyright (C) 2000 Free Software Foundation, Inc.
#
#    Author:  Laurent Julliard <laurent@julliard-online.org>
#             (inspired from Nicola Pero's JIGS test file)
#    Date: September 2001
#  
#    This file is part of GNUstep.
#  
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#  
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#  
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.

require 'rigs'
Rigs.import("NSApplication")
Rigs.import("NSGraphicsContext")
Rigs.import("NSWindow")
Rigs.import("NSButton")
Rigs.import("NSProcessInfo")
Rigs.import("NSSelector")
Rigs.import("NSString")

# The difference between this test and NSButtonTest is that in this
#   test the button sends an action to an Objective-C object.

class NSButtonTest2

    def initialize 
	@window = NSWindow.alloc
    end

    def applicationWillFinishLaunching (notification)

	# FIXME For some reason NSButton.new crashes with error 
	# "NSInvalidArgumentException: NSButton doesn't recognize NSCopyWithZone: " error
	# May due to the retain method call in rb_objc_new
	button = NSButton.new
	button.setTarget($NSApp)
	button.setAction( selector("terminate:"))
	button.setTitle("Quit This Test")
	button.sizeToFit()

	rect = button.frame()
	styleMask = NSTitledWindowMask | NSClosableWindowMask |
	    NSMiniaturizableWindowMask | NSResizableWindowMask

	@window.initWithContentRect_styleMask_backing_defer \
	                 (rect, styleMask, NSBackingStoreRetained, false)
	@window.setTitle("GNUstep")
	@window.setContentView (button)
    end
  
    def applicationDidFinishLaunching (notification)
	@window.center()
	@window.makeKeyAndOrderFront(self)
    end
    
end

  
# main
NSProcessInfo.processInfo.setProcessName("NSButtonTest2")

application = NSApplication.sharedApplication
buttonTest = NSButtonTest2.new

application.setDelegate(buttonTest)

application.run
 
