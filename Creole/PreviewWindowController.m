//
//  PreviewWindowController.m
//  Creole
//
//  Created by Atsushi Nagase on 5/26/12.
//  Copyright (c) 2012 LittleApps Inc. All rights reserved.
//

#import "PreviewWindowController.h"
#import "CreolePlugin.h"
#import <WebKit/WebKit.h>

@interface PreviewWindowController ()


@end

@implementation PreviewWindowController

NSString *const kWindowSaveName = @"CreoleWikiPreviewWindow";

@synthesize webView = _webView
, plugin = _plugin
;

- (id)initWithPlugin:(CreolePlugin *)plugin {
  if (self=[super initWithWindowNibName:@"PreviewWindow" owner:self]) {
    self.plugin = plugin;
  }
  return self;
}

- (void)windowDidLoad {
  self.window.level = NSStatusWindowLevel;
  self.window.frameAutosaveName = kWindowSaveName;
  [super windowDidLoad];
}

- (void)windowDidMove: (NSNotification *)aNotification {
  [self.window saveFrameUsingName:kWindowSaveName];
}

- (void)showWindow:(id)sender {
  [super showWindow:sender];
}

- (void)windowWillClose:(NSNotification *)notification {
  [self.plugin didPreviewClose];
}

@end

