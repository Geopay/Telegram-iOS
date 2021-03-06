/*
 * This is the source code of Telegram for iOS v. 1.1
 * It is licensed under GNU GPL v. 2 or later.
 * You should have received a copy of the license in this archive (see LICENSE).
 *
 * Copyright Peter Iakovlev, 2013.
 */

#import <Foundation/Foundation.h>

#import "TLObject.h"
#import "TLMetaRpc.h"

@class TLInputPhoto;
@class TLInputGeoPoint;
@class TLphotos_Photo;

@interface TLRPCphotos_editPhoto : TLMetaRpc

@property (nonatomic, retain) TLInputPhoto *n_id;
@property (nonatomic, retain) NSString *caption;
@property (nonatomic, retain) TLInputGeoPoint *geo_point;

- (Class)responseClass;

- (int)impliedResponseSignature;

@end

@interface TLRPCphotos_editPhoto$photos_editPhoto : TLRPCphotos_editPhoto


@end

