//
//  CreolePlugin.m
//  Creole
//
//  Created by Atsushi Nagase on 5/26/12.
//  Copyright (c) 2012 LittleApps Inc. All rights reserved.
//

#import "CreolePlugin.h"
#import "PreviewWindowController.h"
#import "NMEObjC.h"
#import <WebKit/WebKit.h>

@interface CreolePlugin ()

- (id)initWithPlugInController:(CodaPlugInsController*)aController;
- (void)reloadPreview;
- (NSString *)html;

@property (nonatomic, strong) CodaPlugInsController *pluginController;
@property (nonatomic, strong) PreviewWindowController *previewWindowController;

@end

@implementation CreolePlugin

@synthesize pluginController = _pluginController
, previewWindowController = _previewWindowController
;

#pragma mark - CodaPlugin Methods

- (NSString *)name { return @"Creole Wiki"; }

- (id)initWithPlugInController:(CodaPlugInsController*)aController
                  plugInBundle:(NSObject <CodaPlugInBundle> *)plugInBundle {
  return self = [self initWithPlugInController:aController];
}

- (id)initWithPlugInController:(CodaPlugInsController *)aController
                        bundle:(NSBundle *)yourBundle {
  return self = [self initWithPlugInController:aController];
}

- (id)initWithPlugInController:(CodaPlugInsController*)aController {
  if(self=[self init]) {
    self.pluginController = aController;
    [aController registerActionWithTitle:NSLocalizedString(@"Open preview", nil)
                   underSubmenuWithTitle:nil
                                  target:self
                                selector:@selector(openPreview:)
                       representedObject:nil
                           keyEquivalent:nil
                              pluginName:self.name];
    
    [aController registerActionWithTitle:NSLocalizedString(@"Generate HTML", nil)
                   underSubmenuWithTitle:nil
                                  target:self
                                selector:@selector(generateHTML:)
                       representedObject:nil
                           keyEquivalent:nil
                              pluginName:self.name];
  }
  return self;
}

- (void)textViewWillSave:(CodaTextView *)textView {
  [self reloadPreview];
}

#pragma mark -

- (void)openPreview:(id)sender {
  CodaTextView *tv = [self.pluginController focusedTextView:self];
  if(!tv||!tv.string||[tv.string isEqualToString:@""]) return;
  self.previewWindowController = [[PreviewWindowController alloc] initWithPlugin:self];
  [self.previewWindowController showWindow:self];
  [self reloadPreview];
}

- (void)generateHTML:(id)sender {
  NSString *html = self.html;
  CodaTextView *tv = [self.pluginController makeUntitledDocument];
  [tv insertText:html];
}

#pragma mark -

- (NSString *)html {
  CodaTextView *tv = [self.pluginController focusedTextView:self];
  NSString *source = tv.string;
  if(!source||source.length==0) return nil;
  return [[NSString alloc] initWithData:
          [NSData dataWithNMEString:source
                           fontSize:0
                             format:'h']
                               encoding:NSUTF8StringEncoding];
}

- (void)reloadPreview {
  [self.previewWindowController.webView.mainFrame
   loadHTMLString:self.html baseURL:
   [[NSURL alloc] initFileURLWithPath:@"~/" isDirectory:YES]];
}

@end
