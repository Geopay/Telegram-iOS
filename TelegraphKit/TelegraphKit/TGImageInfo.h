/*
 * This is the source code of Telegram for iOS v. 1.1
 * It is licensed under GNU GPL v. 2 or later.
 * You should have received a copy of the license in this archive (see LICENSE).
 *
 * Copyright Peter Iakovlev, 2013.
 */

#import <UIKit/UIKit.h>

@interface TGImageInfo : NSObject

- (void)addImageWithSize:(CGSize)size url:(NSString *)url;
- (void)addImageWithSize:(CGSize)size url:(NSString *)url fileSize:(int)fileSize;

- (NSString *)closestImageUrlWithWidth:(int)width resultingSize:(CGSize *)resultingSize;
- (NSString *)closestImageUrlWithHeight:(int)height resultingSize:(CGSize *)resultingSize;
- (NSString *)closestImageUrlWithSize:(CGSize)size resultingSize:(CGSize *)resultingSize;
- (NSString *)closestImageUrlWithSize:(CGSize)size resultingSize:(CGSize *)resultingSize pickLargest:(bool)pickLargest;
- (NSString *)closestImageUrlWithSize:(CGSize)size resultingSize:(CGSize *)resultingSize resultingFileSize:(int *)resultingFileSize;
- (NSString *)closestImageUrlWithSize:(CGSize)size resultingSize:(CGSize *)resultingSize resultingFileSize:(int *)resultingFileSize pickLargest:(bool)pickLargest;
- (NSString *)imageUrlWithExactSize:(CGSize)size;

- (bool)containsSizeWithUrl:(NSString *)url;

- (NSDictionary *)allSizes;

- (void)serialize:(NSMutableData *)data;
+ (TGImageInfo *)deserialize:(NSInputStream *)is;

@end
