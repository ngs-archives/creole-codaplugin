/**
 *	@file NMEObjC.m
 *	@author Yves Piguet.
 *	@copyright 2007-2011, Yves Piguet.
 *	@brief Objective C wrapper for NME as a category for NSData.
 */

/* License: new BSD license (see NME.h) */

#import "NMEObjC.h"
#import "NME.h"

@implementation NSData(NME)

+ (NSData *)dataWithNME:(char const *)src length:(int)length
		fontSize:(int)fontSize format:(char)format
{
	NMEText buf, dest;
	NMEInt bufSize, destLen;
	NMEErr err;
	NSData *data;
	NMEOutputFormat const *f;
	NMEOutputFormat formatDebugNested;
	
	bufSize = 1024 + 2 * length;
	
tryAgain:
	buf = malloc(bufSize);
	if (!buf)
		return nil;
	
	switch (format)
	{
		case 'd':
			f = &NMEOutputFormatDebug;
			break;
		case 'D':
			formatDebugNested = NMEOutputFormatDebug;
			formatDebugNested.sublistInListItem = TRUE;
			f = &formatDebugNested;
			break;
		case 'h':
			f = &NMEOutputFormatHTML;
			break;
		case 'l':
			f = &NMEOutputFormatLaTeX;
			break;
		case 'n':
			f = &NMEOutputFormatNME;
			break;
		case 'r':
			f = &NMEOutputFormatRTF;
			break;
		default:
			f = &NMEOutputFormatText;
			break;
	}
	
	err = NMEProcess(src, length,
			buf, bufSize,
			kNMEProcessOptDefault, "\n", f, fontSize,
			&dest, &destLen, NULL);
	if (err == kNMEErrNotEnoughMemory)
		if (bufSize < 65536 + 10 * length)
		{
			free((void *)buf);
			bufSize *= 2;
			goto tryAgain;
		}
		else
		{
			free((void *)buf);
			return nil;
		}
	
	data = [NSData dataWithBytes:dest length:destLen];
	free((void *)buf);
	return data;
}

+ (NSData *)dataWithNME:(char const *)src length:(int)length
		fontSize:(int)fontSize
{
	return [NSData dataWithNME:src length:length
			fontSize:fontSize format:'r'];
}

+ (NSData *)dataWithNMEString:(NSString *)src
		fontSize:(int)fontSize format:(char)format;
{
	NSData *data = [src dataUsingEncoding:NSUTF8StringEncoding];
	return [NSData dataWithNME:[data bytes] length:[data length]
			fontSize:fontSize format:format];
}

@end
