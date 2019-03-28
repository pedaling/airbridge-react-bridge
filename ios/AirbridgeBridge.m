
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

RCT_EXPORT_METHOD(init:(nonnull NSString *)appName appToken:(nonnull NSString*)appToken ){
  
    [AirBridge getInstance:appToken appName:appName];
}

RCT_EXPORT_METHOD(setEmail:(nonnull NSString *)email){

    [[AirBridge instance] setEmail:email];
}

RCT_EXPORT_METHOD(setUser:(nonnull NSString *)userID){

    [[AirBridge instance] setUser:userID];
}

RCT_EXPORT_METHOD(goal:(nonnull NSString*)category action:(nullable NSString*)action label:(nullable NSString*)label value:(nonnull NSNumber*)value customAttributes:(nullable NSDictionary*)customAttributes){
  
    [[AirBridge instance] goalWithCategory:category action:action label:label value:value customAttributes:customAttributes];
}


RCT_EXPORT_METHOD(signIn:(nonnull NSDictionary*)user){
  
    ABUser * abUser = [self getABUser:user];
    ABUserEvent *userEvent = [[ABUserEvent alloc] initWithUser:abUser];
    [userEvent sendSignin];
}

RCT_EXPORT_METHOD(signUp:(nonnull NSDictionary*)user){
  
    ABUser * abUser = [self getABUser:user];
    ABUserEvent *userEvent = [[ABUserEvent alloc] initWithUser:abUser];
    [userEvent sendSignup];
}

RCT_EXPORT_METHOD(sendViewHome){
  
    ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] init];
    [ecommerceEvent sendViewHome];
}

RCT_EXPORT_METHOD(sendViewProductList:(nullable NSString*)listID products:(nonnull NSArray*)products){
  
  NSArray<ABProduct*> * abProducts = [self getABProductsFromProducts:products];
  ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] initWithProducts:abProducts];
  ecommerceEvent.productListID = listID;
  [ecommerceEvent sendViewProductList];
}

RCT_EXPORT_METHOD(sendViewSearchResult:(nullable NSString*)query products:(nullable NSArray*)products){
  
    NSArray<ABProduct*> * abProducts = [self getABProductsFromProducts:products];
    ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] initWithProducts:abProducts];
    ecommerceEvent.query = query;
    [ecommerceEvent sendViewSearchResult];
}

RCT_EXPORT_METHOD(sendViewProductDetail:(nonnull NSDictionary*)product){
  
    ABProduct * abProduct = [self getABProduct:product];
    ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] initWithProducts:@[abProduct]];
    [ecommerceEvent sendViewProductDetail];
}

RCT_EXPORT_METHOD(sendAddToCart:(nonnull NSDictionary*) productDict cartID:(nullable NSString*)cartID currency:(nullable NSString*) currency totalValue:(nonnull NSNumber*) totalValue){
  
    ABProduct * abProduct = [self getABProduct:productDict];
    ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] initWithProducts:@[abProduct]];
    ecommerceEvent.cartID = cartID;
    ecommerceEvent.eventValue = totalValue;
  
    [ecommerceEvent sendAddProductToCart];
}

RCT_EXPORT_METHOD(sendCompleteOrder:(nonnull NSArray*)products transactionID:(nullable NSString*)transsactionID isInAppPurchase:(BOOL)isInAppPurchase currency:(nullable NSString*) currency totalValue:(nonnull NSNumber*) totalValue){

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

    [ecommerceEvent sendCompleteOrder];
}

RCT_EXPORT_METHOD(expireUser){

    ABUserEvent *userEvent = [[ABUserEvent alloc] init];
    [userEvent expireUser];
}

RCT_EXPORT_METHOD(setCustomSessionTimeOut:(NSInteger)secTime){
  
    [[AirBridge instance] setCustomSessionTimeOut:secTime];
}

RCT_EXPORT_METHOD(setWifiInfoUsability:(BOOL)enable){
  
    [[AirBridge instance] setWifiInfoUsability: enable];
}

RCT_EXPORT_METHOD(deeplinkLaunched:(nonnull NSString*)urlString){

    NSURL *url = [RCTConvert NSURL:urlString];
    [[AirBridge instance] setDeeplink:url];
    //for deffered deep link
    //[[AirBridge instance] handleURL:url];
}

#pragma mark - method

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
    NSString * currency1 = [RCTConvert NSString:productDict[@"currency"]];
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

-(NSArray<ABProduct*>*) getABProductsFromProducts:(NSArray*) products{
 
  NSMutableArray<ABProduct*> * abProducts = [[NSMutableArray alloc] init];
  
  for(int i =0 ; i< [products count] ; i++){
    ABProduct * abProduct = [self getABProduct:products[i]];
    [abProducts addObject:abProduct];
  }
  
  return abProducts;
}

@end


