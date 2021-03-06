#import "TLGeoPlaceName.h"

#import "../NSInputStream+TL.h"
#import "../NSOutputStream+TL.h"


@implementation TLGeoPlaceName

@synthesize country = _country;
@synthesize state = _state;
@synthesize city = _city;
@synthesize district = _district;
@synthesize street = _street;

- (int32_t)TLconstructorSignature
{
    TGLog(@"constructorSignature is not implemented for base type");
    return 0;
}

- (int32_t)TLconstructorName
{
    TGLog(@"constructorName is not implemented for base type");
    return 0;
}

- (id<TLObject>)TLbuildFromMetaObject:(std::tr1::shared_ptr<TLMetaObject>)__unused metaObject
{
    TGLog(@"TLbuildFromMetaObject is not implemented for base type");
    return nil;
}

- (void)TLfillFieldsWithValues:(std::map<int32_t, TLConstructedValue> *)__unused values
{
    TGLog(@"TLfillFieldsWithValues is not implemented for base type");
}


@end

@implementation TLGeoPlaceName$geoPlaceName : TLGeoPlaceName


- (int32_t)TLconstructorSignature
{
    return (int32_t)0x3819538f;
}

- (int32_t)TLconstructorName
{
    return (int32_t)0x31146b5c;
}

- (id<TLObject>)TLbuildFromMetaObject:(std::tr1::shared_ptr<TLMetaObject>)metaObject
{
    TLGeoPlaceName$geoPlaceName *object = [[TLGeoPlaceName$geoPlaceName alloc] init];
    object.country = metaObject->getString(0xbf857ba3);
    object.state = metaObject->getString(0x449b9b4e);
    object.city = metaObject->getString(0x11a65ceb);
    object.district = metaObject->getString(0x856b3272);
    object.street = metaObject->getString(0x9ff823c4);
    return object;
}

- (void)TLfillFieldsWithValues:(std::map<int32_t, TLConstructedValue> *)values
{
    {
        TLConstructedValue value;
        value.type = TLConstructedValueTypeString;
        value.nativeObject = self.country;
        values->insert(std::pair<int32_t, TLConstructedValue>(0xbf857ba3, value));
    }
    {
        TLConstructedValue value;
        value.type = TLConstructedValueTypeString;
        value.nativeObject = self.state;
        values->insert(std::pair<int32_t, TLConstructedValue>(0x449b9b4e, value));
    }
    {
        TLConstructedValue value;
        value.type = TLConstructedValueTypeString;
        value.nativeObject = self.city;
        values->insert(std::pair<int32_t, TLConstructedValue>(0x11a65ceb, value));
    }
    {
        TLConstructedValue value;
        value.type = TLConstructedValueTypeString;
        value.nativeObject = self.district;
        values->insert(std::pair<int32_t, TLConstructedValue>(0x856b3272, value));
    }
    {
        TLConstructedValue value;
        value.type = TLConstructedValueTypeString;
        value.nativeObject = self.street;
        values->insert(std::pair<int32_t, TLConstructedValue>(0x9ff823c4, value));
    }
}


@end

