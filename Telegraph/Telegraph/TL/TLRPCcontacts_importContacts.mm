#import "TLRPCcontacts_importContacts.h"

#import "../NSInputStream+TL.h"
#import "../NSOutputStream+TL.h"

#import "TLcontacts_ImportedContacts.h"

@implementation TLRPCcontacts_importContacts

@synthesize contacts = _contacts;
@synthesize replace = _replace;

- (Class)responseClass
{
    return [TLcontacts_ImportedContacts class];
}

- (int)impliedResponseSignature
{
    return (int)0xd1cd0a4c;
}

- (int)layerVersion
{
    return 8;
}

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

@implementation TLRPCcontacts_importContacts$contacts_importContacts : TLRPCcontacts_importContacts


- (int32_t)TLconstructorSignature
{
    return (int32_t)0xda30b32d;
}

- (int32_t)TLconstructorName
{
    return (int32_t)0x91f82313;
}

- (id<TLObject>)TLbuildFromMetaObject:(std::tr1::shared_ptr<TLMetaObject>)metaObject
{
    TLRPCcontacts_importContacts$contacts_importContacts *object = [[TLRPCcontacts_importContacts$contacts_importContacts alloc] init];
    object.contacts = metaObject->getArray(0x48dc7107);
    object.replace = metaObject->getBool(0x2b90b095);
    return object;
}

- (void)TLfillFieldsWithValues:(std::map<int32_t, TLConstructedValue> *)values
{
    {
        TLConstructedValue value;
        value.type = TLConstructedValueTypeVector;
        value.nativeObject = self.contacts;
        values->insert(std::pair<int32_t, TLConstructedValue>(0x48dc7107, value));
    }
    {
        TLConstructedValue value;
        value.type = TLConstructedValueTypePrimitiveBool;
        value.primitive.boolValue = self.replace;
        values->insert(std::pair<int32_t, TLConstructedValue>(0x2b90b095, value));
    }
}


@end

