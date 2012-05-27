//
//  CreolePlugin.m
//  Creole
//
//  Created by Atsushi Nagase on 5/26/12.
//  Copyright (c) 2012 LittleApps Inc. All rights reserved.
//

#import "CreolePlugin.h"
#import "NMEObjC.h"

@implementation CreolePlugin

- (NSString *)name { return @"Creole Wiki"; }

- (NSString *)html {
  CodaTextView *tv = [self.pluginController focusedTextView:self];
  NSString *source = tv.string;
  if(!source||source.length==0) return @"";
  return [[NSString alloc] initWithData:
          [NSData dataWithNMEString:source
                           fontSize:0
                             format:'h']
                               encoding:NSUTF8StringEncoding];
}

@end
