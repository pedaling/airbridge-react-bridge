
#import "AirbridgeBridge.h"
#import <React/RCTLog.h>
#import <React/RCTConvert.h>
#import <AirBridge/AirBridge.h>
#import <AirBridge/ABUserEvent.h>
#import <AirBridge/ABEcommerceEvent.h>

//#define kTestSuccessFlag @"[SUCCESS]"
//#define kTestFailFlag @"[FAIL]"
#define kSuccessLog [NSString stringWithFormat:@"[%d][SUCCESS]",++testNum]
#define kFailLog [NSString stringWithFormat:@"[%d][FAIL]",++testNum]


static int testNum = 0;

@implementation AirbridgeBridge

- (dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE();

#pragma mark - Airbridge

-(void) testLog:(NSString*)log isSuccess:(BOOL)success{
  if(success){
    RCTLogInfo(@"%@ %@",kSuccessLog,log);
  }
  else{
    RCTLogInfo(@"%@ %@",kFailLog,log);
  }

}
RCT_EXPORT_METHOD(init:(NSString *)appToken appName:(NSString*)appName ){
    testNum = 0;
    RCTLogInfo(@"[test init start]");
    RCTLogInfo(@"[before call method]");

    if([appToken isEqualToString:@"ablog"]){
      
      [self testLog:@"appToken parameter success" isSuccess:YES];
    }
    else{
      [self testLog:@"appToken parameter success" isSuccess:NO];
    }
  
    if([appName isEqualToString:@"38acf1efa9fc4f0987173f5a76516eb1"]){
        [self testLog:@"appName parameter" isSuccess:YES];
    }
      else{
        [self testLog:@"appName parameter" isSuccess:NO];
    }

    [AirBridge getInstance:appToken appName:appName];
    if([AirBridge instance]){
      [self testLog:@"make AirBridge instance" isSuccess:YES];
    }
    else{
      [self testLog:@"make AirBridge instance" isSuccess:NO];
    }
  
    RCTLogInfo(@"[test init end]");
}

RCT_EXPORT_METHOD(setEmail:(NSString *)email){
  RCTLogInfo(@"[test setEmail start]");
  RCTLogInfo(@"[before call method]");
  if([email isEqualToString:@"airbridge@ab180.co"]){
    [self testLog:@"email parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"email parameter" isSuccess:NO];
  }

  [[AirBridge instance] setEmail:email];
  
  RCTLogInfo(@"[test setEmail end]");

  
}

RCT_EXPORT_METHOD(setUser:(NSString *)userID){
  
  RCTLogInfo(@"[test setUser start]");
  RCTLogInfo(@"[before call method]");
  if([userID isEqualToString:@"UserAB"]){
    [self testLog:@"userID parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"userID parameter" isSuccess:NO];
  }
    [[AirBridge instance] setUser:userID];
  
  RCTLogInfo(@"[test setUser end]");
}

RCT_EXPORT_METHOD(goal:(NSString*)category action:(nullable NSString*)action label:(nullable NSString*)label value:(nonnull NSNumber*)value customAttributes:(nullable NSDictionary*)customAttributes){
  RCTLogInfo(@"[test goal start]");
  RCTLogInfo(@"[before call method]");
  
  if([category isEqualToString:@"category"]){
    [self testLog:@"category parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"category parameter" isSuccess:NO];
  }
  if([action isEqualToString:@"action"]){
      [self testLog:@"action parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"action parameter" isSuccess:NO];
  }
  if([label isEqualToString:@"label"]){
    [self testLog:@"label parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"label parameter" isSuccess:NO];
  }
  if([value intValue] == 100){
    [self testLog:@"value parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"value parameter" isSuccess:NO];
  }
  if([[customAttributes objectForKey:@"test"] isEqualToString:@"ok"]){
    [self testLog:@"customAttributes parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"customAttributes parameter" isSuccess:NO];
  }
  
  BOOL isSuccess = [[AirBridge instance] goalWithCategory:category action:action label:label value:value customAttributes:customAttributes];
  
  [self testLog:@"goal Event" isSuccess:isSuccess];
  RCTLogInfo(@"[test goal end]");
  
}


RCT_EXPORT_METHOD(signIn:(NSDictionary*)user){
  
  RCTLogInfo(@"[test signIn start]");
  RCTLogInfo(@"[before call method]");

  ABUser * abUser = [self getABUser:user];
  if([abUser.userID isEqualToString:@"UserAB"]){
    [self testLog:@"userID parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"userID parameter" isSuccess:NO];
  }
  
  if([abUser.userEmail isEqualToString:@"test@a.com"]){
    [self testLog:@"userEmail parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"userEmail parameter" isSuccess:NO];
  }
  
  ABUserEvent *userEvent = [[ABUserEvent alloc] initWithUser:abUser];
  BOOL isSuccess = [userEvent sendSignin];
  [self testLog:@"signIn Event" isSuccess:isSuccess];
  
  RCTLogInfo(@"[test signIn end]");
}

RCT_EXPORT_METHOD(signUp:(NSDictionary*)user){
  
  RCTLogInfo(@"[test signUp start]");
  RCTLogInfo(@"[before call method]");
  
  ABUser * abUser = [self getABUser:user];
  
  if([abUser.userEmail isEqualToString:@"test@a.com"]){
    [self testLog:@"userID parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"userID parameter" isSuccess:NO];
  }
  
  if([abUser.userEmail isEqualToString:@"test@a.com"]){
    [self testLog:@"userEmail parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"userEmail parameter" isSuccess:NO];
  }
  
    ABUserEvent *userEvent = [[ABUserEvent alloc] initWithUser:abUser];
    
   BOOL isSuccess = [userEvent sendSignup];
   [self testLog:@"sendSignup Event" isSuccess:isSuccess];

  
  RCTLogInfo(@"[test signUp end]");
}

RCT_EXPORT_METHOD(sendViewHome){
    RCTLogInfo(@"[test sendViewHome start]");
    RCTLogInfo(@"[before call method]");
  
    ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] init];
    BOOL isSuccess = [ecommerceEvent sendViewHome];
    [self testLog:@"sendViewHome Event" isSuccess:isSuccess];
  
    RCTLogInfo(@"[test sendViewHome end]");

}

//
RCT_EXPORT_METHOD(sendViewProductList:(NSString*)listID products:(NSArray*)products){
  
  RCTLogInfo(@"[test sendViewProductList start]");
  RCTLogInfo(@"[before call method]");
  
  NSArray<ABProduct*> * abProducts = [self getABProductsFromProducts:products];
  
  ABProduct* abProduct = (ABProduct*) abProducts[0];
  
  if([listID isEqualToString:@"ListID-123"]){
    [self testLog:@"listID parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"listID parameter" isSuccess:NO];
  }
  
  if([abProduct.idx isEqualToString:@"1"]){
    [self testLog:@"product id parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"product id parameter" isSuccess:NO];
  }
  if([abProduct.name isEqualToString:@"airbloc"]){
    [self testLog:@"product id parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"product id parameter" isSuccess:NO];
  }
  if([abProduct.price intValue] == 100){
    [self testLog:@"price parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"price parameter" isSuccess:NO];
  }
  
  if([abProduct.currency isEqualToString:@"KRW"]){
    [self testLog:@"currency parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"currency parameter" isSuccess:NO];
  }
  if([abProduct.orderPosition intValue] == 1){
    [self testLog:@"orderPosition  parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"orderPosition parameter" isSuccess:NO];
  }
  
  if([abProduct.quantity intValue] == 2){
    [self testLog:@"quantity  parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"quantity parameter" isSuccess:NO];
  }
  
   ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] initWithProducts:abProducts];
   ecommerceEvent.productListID = listID;
   BOOL isSuccess = [ecommerceEvent sendViewProductList];
  [self testLog:@"sendViewProductList EVENT" isSuccess:isSuccess];
  RCTLogInfo(@"[test sendViewProductList end]");

}

RCT_EXPORT_METHOD(sendViewSearchResult:(NSString*)query products:(NSArray*)products){
  
  RCTLogInfo(@"[test sendViewSearchResult start]");
  RCTLogInfo(@"[before call method]");
  
  if([query isEqualToString:@"Query-123"]){
    [self testLog:@"query  parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"query parameter" isSuccess:NO];
  }
  
    NSArray<ABProduct*> * abProducts = [self getABProductsFromProducts:products];

    ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] initWithProducts:abProducts];
  
    ecommerceEvent.query = query;
  
    BOOL isSuccess = [ecommerceEvent sendViewProductList];

    [self testLog:@"sendViewSearchResult EVENT" isSuccess:isSuccess];
    RCTLogInfo(@"[test sendViewSearchResult end]");

}

RCT_EXPORT_METHOD(sendViewProductDetail:(NSDictionary*)product){
  
  RCTLogInfo(@"[test sendViewProductDetail start]");
  RCTLogInfo(@"[before call method]");
  
    ABProduct * abProduct = [self getABProduct:product];
  
    ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] initWithProducts:@[abProduct]];
    BOOL isSuccess = [ecommerceEvent sendViewProductDetail];
    [self testLog:@"sendViewProductDetail EVENT" isSuccess:isSuccess];

    RCTLogInfo(@"[test sendViewProductDetail end]");

}

RCT_EXPORT_METHOD(sendAddToCart:(NSDictionary*) productDict cartID:(NSString*)cartID currency:(NSString*) currency totalValue:(nonnull NSNumber*) totalValue){
  RCTLogInfo(@"[test sendAddToCart start]");
  RCTLogInfo(@"[before call method]");
  
    ABProduct * abProduct = [self getABProduct:productDict];
    
    ABEcommerceEvent *ecommerceEvent = [[ABEcommerceEvent alloc] initWithProducts:@[abProduct]];
    ecommerceEvent.cartID = cartID;
    ecommerceEvent.eventValue = totalValue;
  
  if([cartID isEqualToString:@"Cart-123"]){
    [self testLog:@"cartID  parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"cartID parameter" isSuccess:NO];
  }
  
  if([currency isEqualToString:@"KRW"]){
    [self testLog:@"currency  parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"currency parameter" isSuccess:NO];
  }
  if([totalValue intValue] == 10000) {
    [self testLog:@"totalValue  parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"totalValue parameter" isSuccess:NO];
  }
  
  BOOL isSuccess = [ecommerceEvent sendAddProductToCart];
  [self testLog:@"sendViewProductDetail EVENT" isSuccess:isSuccess];

  RCTLogInfo(@"[test sendAddToCart end]");

}

RCT_EXPORT_METHOD(sendCompleteOrder:(NSArray*)products transactionID:(NSString*)transsactionID isInAppPurchase:(BOOL)isInAppPurchase currency:(NSString*) currency totalValue:(nonnull NSNumber*) totalValue){
  
  RCTLogInfo(@"[test sendCompleteOrder start]");
  RCTLogInfo(@"[before call method]");
    
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
  
  if([transsactionID isEqualToString:@"Transaction-123"]) {
    [self testLog:@"transsactionID  parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"transsactionID parameter" isSuccess:NO];
  }
  
  if(isInAppPurchase) {
    [self testLog:@"isInAppPurchase  parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"isInAppPurchase parameter" isSuccess:NO];
  }
  
  BOOL isSuccess = [ecommerceEvent sendAddProductToCart];
  [self testLog:@"sendAddProductToCart EVENT" isSuccess:isSuccess];

}

RCT_EXPORT_METHOD(expireUser){
  RCTLogInfo(@"[test expireUser start]");
  RCTLogInfo(@"[before call method]");
  
  ABUserEvent *userEvent = [[ABUserEvent alloc] init];
  BOOL isSuccess = [userEvent expireUser];
  
  [self testLog:@"expireUser EVENT" isSuccess:isSuccess];
  
  RCTLogInfo(@"[test expireUser end]");

}

RCT_EXPORT_METHOD(setCustomSessionTimeOut:(NSInteger)secTime){
  RCTLogInfo(@"[test setCustomSessionTimeOut start]");
  RCTLogInfo(@"[before call method]");
  
  if(secTime == 100){
    [self testLog:@"setCustomSessionTimeOut parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"setCustomSessionTimeOut parameter" isSuccess:NO];
  }
  
    [[AirBridge instance] setCustomSessionTimeOut:secTime];
  
  RCTLogInfo(@"[test setCustomSessionTimeOut end]");

}

RCT_EXPORT_METHOD(setWifiInfoUsability:(BOOL)enable){
  
    RCTLogInfo(@"[test setWifiInfoUsability start]");
    RCTLogInfo(@"[before call method]");
  
  if(enable){
    [self testLog:@"setCustomSessionTimeOut parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"setCustomSessionTimeOut parameter" isSuccess:NO];
  }
  
    [[AirBridge instance] setWifiInfoUsability: enable];
  
    RCTLogInfo(@"[test setWifiInfoUsability end]");

}

RCT_EXPORT_METHOD(deeplinkLaunched:(NSString*)urlString){
  
  RCTLogInfo(@"[test deeplinkLaunched start]");
  RCTLogInfo(@"[before call method]");

  if([urlString isEqualToString:@"http://deeplink?q=123"]){
    [self testLog:@"deeplinkLaunched parameter" isSuccess:YES];
  }
  else{
    [self testLog:@"deeplinkLaunched parameter" isSuccess:NO];
  }

  NSURL *url = [RCTConvert NSURL:urlString];

  //deffered deep link
//  [[AirBridge instance] handleURL:url];
  BOOL isSuccess = [[AirBridge instance] setDeeplink:url];
  [self testLog:@"deeplinkLaunched EVENT" isSuccess:isSuccess];

  RCTLogInfo(@"[test deeplinkLaunched end]");
  [self testLog:@"test0 EVENT" isSuccess:isSuccess];

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


