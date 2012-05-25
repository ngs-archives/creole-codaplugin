//
//  PreviewWindowController.h
//  Creole
//
//  Created by Atsushi Nagase on 5/26/12.
//  Copyright (c) 2012 LittleApps Inc. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class CreolePlugin, WebView;
@interface PreviewWindowController : NSWindowController

- (id)initWithPlugin:(CreolePlugin *)plugin;

@property (weak) CreolePlugin *plugin;
@property (readonly) BOOL isWindowOpened;
@property (weak) IBOutlet WebView *webView;


@end
