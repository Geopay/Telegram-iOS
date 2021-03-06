#import "TGSendCodeRequestBuilder.h"

#import "TGTelegraph.h"

#import "TGSchema.h"

#import "ActionStage.h"
#import "SGraphObjectNode.h"

#import "TGSession.h"

#import "TGTimer.h"

@interface TGSendCodeRequestBuilder ()

@property (nonatomic, strong) TGTimer *timer;
@property (nonatomic) bool sendingCall;

@end

@implementation TGSendCodeRequestBuilder

@synthesize actionHandle = _actionHandle;

@synthesize timer = _timer;
@synthesize sendingCall = _sendingCall;

+ (NSString *)genericPath
{
    return @"/tg/service/auth/sendCode/@";
}

- (id)initWithPath:(NSString *)path
{
    self = [super initWithPath:path];
    if (self != nil)
    {
        _actionHandle = [[ASHandle alloc] initWithDelegate:self];
        self.cancelTimeout = 0;
    }
    return self;
}

- (void)dealloc
{
    if (_timer != nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
    
    [_actionHandle reset];
}

- (void)execute:(NSDictionary *)options
{
    NSString *phone = [options objectForKey:@"phoneNumber"];
    
    if ([[options objectForKey:@"requestCall"] boolValue])
    {
        _sendingCall = true;
        self.cancelToken = [TGTelegraphInstance doSendPhoneCall:phone phoneHash:[options objectForKey:@"phoneHash"] requestBuilder:self];
    }
    else
    {
        if ([[TGSession instance] isConnecting] && [[TGSession instance] isOffline])
        {
            [ActionStageInstance() actionFailed:self.path reason:TGSendCodeErrorNetwork];
        }
        else
        {
            ASHandle *actionHandle = _actionHandle;
            _timer = [[TGTimer alloc] initWithTimeout:15.0 repeat:false completion:^
            {
                [actionHandle requestAction:@"networkTimeout" options:nil];
            } queue:[ActionStageInstance() globalStageDispatchQueue]];
            [_timer start];
            
            self.cancelToken = [TGTelegraphInstance doSendConfirmationCode:phone requestBuilder:self];
        }
    }
}

- (void)sendCodeRequestSuccess:(TLauth_SentCode *)sendCode
{
    if (_timer != nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
    
    TLauth_SentCode$auth_sentCode *concreteCode = (TLauth_SentCode$auth_sentCode *)sendCode;
    
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
    [dict setObject:concreteCode.phone_code_hash forKey:@"phoneCodeHash"];
    [dict setObject:[NSNumber numberWithBool:concreteCode.phone_registered] forKey:@"phoneRegistered"];
    
    [ActionStageInstance() actionCompleted:self.path result:[[SGraphObjectNode alloc] initWithObject:dict]];
}

- (void)sendCodeRequestFailed:(TGSendCodeError)errorCode
{
    if (_timer != nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
    
    [ActionStageInstance() actionFailed:self.path reason:errorCode];
}

- (void)sendCallRequestSuccess
{
    if (_timer != nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
    
    [ActionStageInstance() actionCompleted:self.path result:nil];
}

- (void)sendCallRequestFailed
{
    if (_timer != nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
    
    [ActionStageInstance() actionFailed:self.path reason:-1];
}

- (void)cancel
{
    if (_timer != nil)
    {
        [_timer invalidate];
        _timer = nil;
    }
    
    if (self.cancelToken != nil)
    {
        [TGTelegraphInstance cancelRequestByToken:self.cancelToken];
        self.cancelToken = nil;
    }
    
    [super cancel];
}

#pragma mark -

- (void)actionStageActionRequested:(NSString *)action options:(id)__unused options
{
    if ([action isEqualToString:@"networkTimeout"])
    {
        if (self.cancelToken != nil)
        {
            [TGTelegraphInstance cancelRequestByToken:self.cancelToken];
            self.cancelToken = nil;
        }
        
        if (_sendingCall)
            [self sendCallRequestFailed];
        else
            [self sendCodeRequestFailed:TGSendCodeErrorNetwork];
    }
}

@end
