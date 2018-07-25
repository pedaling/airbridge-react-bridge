
#import "AirbridgeBridge.h"
#import <React/RCTLog.h>
#import <React/RCTConvert.h>
#import <AirBridge/AirBridge.h>
#import <AirBridge/ABUserEvent.h>
#import <AirBridge/ABEcommerceEvent.h>

@implementation AirbridgeBridge

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE();

#pragma mark - Airbridge

RCT_EXPORT_METHOD(init:(NSString *)appToken appName:(NSString*)appName ){
    
    [AirBridge getInstance:appToken appName:appName];
}

RCT_EXPORT_METHOD(setEmail:(NSString *)email){
    
    [[AirBridge instance] setEmail:email];
}

RCT_EXPORT_METHOD(setUser:(NSString *)userID){
    
    [[AirBridge instance] setUser:userID];
}

RCT_EXPORT_METHOD(goal:(NSString*)category action:(NSString*)action label:(NSString*)label value:(nonnull NSNumber*)value customAttributes:(NSDictionary*)customAttributes){
    [[AirBridge instance] goalWithCategory:category action:action label:label value:value customAttributes:customAttributes];
}


RCT_EXPORT_METHOD(signIn:(NSDictionary*)user){
    
    ABUser * abUser = [self getABUser:user];
    ABUserEvent *userEvent = [[ABUserEvent alloc] initWithUser:abUser];
    [userEvent sendSignin];
}

//RCT_EXPORT_METHOD(signIn:(NSString*)userID email:(NSString*)email){
//
//    ABUser *user = [[ABUser alloc] init];
//    user.userEmail = email;
//    user.userID = userID;
//    ABUserEvent *userEvent = [[ABUserEvent alloc] initWithUser:user];
//
//    [userEvent sendSignin];
//
//}

RCT_EXPORT_METHOD(signUp:(NSDictionary*)user){
    
    ABUser * abUser = [self getABUser:user];
    ABUserEvent *userEvent = [[ABUserEvent alloc] initWithUser:abUser];
    
    [userEvent sendSignup];
}

//RCT_EXPORT_METHOD(signUp:(NSString*)userID email:(NSString*)email){
//
//    ABUser *user = [[ABUser alloc] init];
//    //when userID is same with userEmail
//    user.userEmail = email;
//    user.userID = userID;
//    ABUserEvent *userEvent = [[ABUserEvent alloc] initWithUser:user];
//
//    [userEvent sendSignup];
//}

RCT_EXPORT_METHOD(sendViewHome){
    ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] init];
    [ecommerceEvent sendViewHome];
}

//
RCT_EXPORT_METHOD(sendViewProductList:(NSString*)listID products:(NSArray*)products){
    
    ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] initWithProducts:products];
    ecommerceEvent.productListID = listID;
    [ecommerceEvent sendViewProductList];
}

RCT_EXPORT_METHOD(sendViewSearchResult:(NSString*)query products:(NSArray*)products){
    
    ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] initWithProducts:products];
    ecommerceEvent.query = query;
    [ecommerceEvent sendViewProductList];
}

RCT_EXPORT_METHOD(sendViewProductDetail:(NSDictionary*)product){
    
    ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] initWithProducts:@[product]];
    [ecommerceEvent sendViewProductDetail];
}

RCT_EXPORT_METHOD(sendAddToCart:(NSDictionary*) productDict cartID:(NSString*)cartID currency:(NSString*) currency totalValue:(NSNumber*) totalValue){
    
    ABProduct * abProduct = [self getABProduct:productDict];
    
    ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] initWithProducts:@[abProduct]];
    ecommerceEvent.cartID = cartID;
    ecommerceEvent.eventValue = totalValue;
    
    [ecommerceEvent sendAddProductToCart];
}

RCT_EXPORT_METHOD(sendCompleteOrder:(NSArray*)products transactionID:(NSString*)transsactionID isInAppPurchase:(BOOL)isInAppPurchase currency:(NSString*) currency totalValue:(NSNumber*) totalValue){
    
    NSMutableArray * abProducts = [[NSMutableArray alloc] init];
    for(int i =0 ; i< [products count]; i++){
        
        NSDictionary * productDict = products[i];
        ABProduct * abProduct = [self getABProduct:productDict];
        [abProducts addObject:abProduct];
    }
    
    ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] initWithProducts:abProducts];
    ecommerceEvent.transactionID = transsactionID;
    ecommerceEvent.isInAppPurchase = isInAppPurchase;
    ecommerceEvent.eventValue = totalValue;
    
    [ecommerceEvent sendAddProductToCart];
}

RCT_EXPORT_METHOD(expireUser){
    
    ABUserEvent *userEvent = [[ABUserEvent alloc] init];
    [userEvent expireUser];
}

RCT_EXPORT_METHOD(setCustomSessionTimeOut:(NSInteger)secTime){
    [[AirBridge instance] setCustomSessionTimeOut:secTime];
}

RCT_EXPORT_METHOD(setWifiInfoUsability:(BOOL)enable){
    
    [[AirBridge instance] setWifiInfoUsability:enable];
}

RCT_EXPORT_METHOD(deeplinkLaunched:(NSURL*)url){
    
    [[AirBridge instance] handleURL:url];
}

-(ABUser*) getABUser:(NSDictionary*) userDict{
    
    NSString * userID = [RCTConvert NSString:userDict[@"userId"]];
    NSString * userEmail = [RCTConvert NSString:userDict[@"userEmail"]];
    
    ABUser * user = [[ABUser alloc] init];
    user.userID = userID;
    user.userEmail = userEmail;
    
    return user;
}

-(ABProduct*) getABProduct:(NSDictionary*) productDict{
    
    NSString * productID = [RCTConvert NSString:productDict[@"productId"]];
    NSString * name = [RCTConvert NSString:productDict[@"name"]];
    NSNumber * price = [RCTConvert NSNumber:productDict[@"price"]];
    NSString * currency1 = [RCTConvert NSString:productDict[@"currecny"]];
    NSNumber * quantity = [RCTConvert NSNumber:productDict[@"quantity"]];
    NSNumber * positionInList = [RCTConvert NSNumber:productDict[@"positionInList"]];
    
    ABProduct * abProduct = [[ABProduct alloc] init];
    abProduct.idx = productID;
    abProduct.name = name;
    abProduct.price = price;
    abProduct.currency = currency1;
    abProduct.quantity = quantity;
    abProduct.orderPosition = positionInList;
    
    return abProduct;
}

@end


