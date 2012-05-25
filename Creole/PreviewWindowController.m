//
//  PreviewWindowController.m
//  Creole
//
//  Created by Atsushi Nagase on 5/26/12.
//  Copyright (c) 2012 LittleApps Inc. All rights reserved.
//

#import "PreviewWindowController.h"

@interface PreviewWindowController ()


@end

@implementation PreviewWindowController
@synthesize webView = _webView
, plugin = _plugin
, isWindowOpened = _isWindowOpened
;

- (id)initWithPlugin:(CreolePlugin *)plugin {
  if (self=[super initWithWindowNibName:@"PreviewWindow" owner:self]) {
    self.plugin = plugin;
  }
  return self;
}

- (void)windowDidLoad {
  [super windowDidLoad];
  self.window.level = NSStatusWindowLevel;
}

- (void)showWindow:(id)sender {
  [super showWindow:sender];
  _isWindowOpened = YES;
}

- (void)windowWillClose:(NSNotification *)notification {
  _isWindowOpened = NO;
}

@end

