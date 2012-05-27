/**
 *	@file NMEObjC.h
 *	@author Yves Piguet.
 *	@copyright 2007-2011, Yves Piguet.
 *	@brief Objective C wrapper for NME as a category for NSData.
 */

/* License: new BSD license (see NME.h) */

/**	@page nmeobjc NMEObjC Usage
 *
 *	NMEObjC - an Objective-C wrapper for NME
 *
 *	@author Yves Piguet
 *	@see http://www.nyctergatis.com (home of NME project)
 *	and http://www.wikicreole.org (Creole site).
 *	
 *	@section Usage Usage
 *
 *	To display text with NME markup in an NSTextView object:
 *
 *	@code
 *	#import "NMEObjC.h"
 *
 *	// assume the following variables
 *	NSTextView *textView;	// NSTextView text is written to
 *	NSString *nmeInput;	// input string with NME markup
 *
 *	// append nmeInput processed by NME to textView's contents
 *	NSRange range = NSMakeRange([[output textStorage] length], 0);
 *	NSData *rtf = [NSData dataWithNMEString:nmeInput fontSize:0 format:'r'];
 *	[textView replaceCharactersInRange:range withRTF:rtf];
 *	@endcode
 */

#import <Foundation/Foundation.h>

@interface NSData(NME)

/** Create autoreleased NSData object by converting text with NME markup
	to another format.
	@param[in] src text with NME format (UTF-8)
	@param[in] length length of src in bytes
	@param[in] fontSize fontSize (0 for default)
	@param[in] format output format: 'h'=HTML, 'l'=LaTeX, 'n'=NME, 'r'=RTF, 't'=text,
	'd'=debug with sublistInListItem=FALSE, 'D'=debug with sublistInListItem=TRUE
*/
+ (NSData *)dataWithNME:(char const *)src length:(int)length
		fontSize:(int)fontSize format:(char)format;

/** Create autoreleased NSData object by converting text with NME markup
	to RTF.
	@param[in] src text with NME format (UTF-8)
	@param[in] length length of src in bytes
	@param[in] fontSize fontSize (0 for default)
*/
+ (NSData *)dataWithNME:(char const *)src length:(int)length
		fontSize:(int)fontSize;

/** Create autoreleased NSData object by converting text with NME markup
	to another format.
	@param[in] src text with NME format as a string
	@param[in] fontSize fontSize (0 for default)
	@param[in] format output format: 'h'=HTML, 'l'=LaTeX, 'n'=NME, 'r'=RTF, 't'=text,
	'd'=debug
*/
+ (NSData *)dataWithNMEString:(NSString *)src
		fontSize:(int)fontSize format:(char)format;

@end
