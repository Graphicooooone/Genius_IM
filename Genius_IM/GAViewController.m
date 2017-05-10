//
//  GAViewController.m
//  Genius_IM
//
//  Created by Graphic-one on 17/2/8.
//  Copyright © 2017年 Graphic-one. All rights reserved.
//

#import "GAViewController.h"
#import <objc/message.h>

#import "GALogIn.h"
#import "GARegister.h"

#import "GAMessage.h"
#import "GASession.h"
#import "GADataBaseHelper.h"
#import "GARouter.h"

#import "UIDevice+Collection.h"

#import <AFNetworking.h>

NS_INLINE const char * GATheHomeOfMagic(const char * tager){
    return [[NSString alloc] initWithData:[[NSData alloc] initWithBase64EncodedString:[NSString stringWithUTF8String:tager] options:NSDataBase64DecodingIgnoreUnknownCharacters] encoding:NSUTF8StringEncoding].UTF8String;
}

void crashMethod (id self , SEL _cmd){
    NSLog(@"闪退crash落地");
}

@interface GAViewController ()

@end

@implementation GAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [GARouter pushURL:RouterMsgListCtr userInfo:nil complete:^(id  _Nullable result) {
        NSLog(@"%@",result);
    }];
    
//    NSString* str121 = @"NSMutableAttributedString";
//    NSString* baseStr = [[str121 dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
//    NSString* str12 = [NSString stringWithUTF8String:GATheHomeOfMagic(baseStr.UTF8String)];
    
//    self.view.backgroundColor = [UIColor orangeColor];
//    
//    GAMessage* message = [[GAMessage alloc] init];
//    message.id = [NSString stringWithFormat:@"%@",[NSUUID UUID]];
//    NSLog(@"%@",message.id);//A0A66FA7-04C7-4A00-93C8-A6EDE02995A7
//    message.content = @"graphic_one lebronjames is Curry ";
//    message.attach = nil;
//    message.type = 0;
//    message.pushlish = [[NSDate date] stringWithISOFormat];
//    message.status = 1;
//    message.senderId = @"122";
//    message.groupId = nil;
//    message.receiverId = @"123456";
//    [GADataBaseHelper SaveData:message];
    
//    GALogIn* login = [[GALogIn alloc] initWithUserName:@"peter" password:@"graphic0829"];
//    GARegister* registerM = [[GARegister alloc] initWithAccount:@"13266595834" password:@"graphic0829" name:@"peter"];
//    GANetworkApis<GARegister* >* tmpApis = MakeNetNetworkApi(@"http://192.168.1.94").requestStringEncoding(NSASCIIStringEncoding).requestTimeoutInterval(20).requestHTTPShouldHandleCookies(NO).end;
//    NSLog(@"%@%lu%lu%d%@",tmpApis.baseURL,(unsigned long)tmpApis.stringEncoding,(unsigned long)tmpApis.timeoutInterval,tmpApis.HTTPShouldHandleCookies,tmpApis.HTTPHeaderField);
//    [tmpApis registerRequest:registerM complete:^(GARegister *model, NSError *error) {
//        if (error) {
//            NSLog(@"%@",error);
//        }else{
//            NSLog(@"%@",model);
//        }
//    }];
//    NSString* str = @"GANetworkApisKey";
//    GANetworkService* service = objc_getAssociatedObject(tmpApis, &str);
//    NSLog(@"%@",tmpApis);
}




////关键是区分系统方法和自己的方法

//[self setString:@"122"];


//+ (BOOL)resolveInstanceMethod:(SEL)sel{
//    if (sel == @selector(setString:)) {
//        class_addMethod(self, sel, (IMP)crashMethod, "V@:");
//        return YES;
//    }
//    return [super resolveInstanceMethod:sel];
//}
//
//+ (BOOL)resolveClassMethod:(SEL)sel{
//    return YES;
//}
//
//- (id)forwardingTargetForSelector:(SEL)aSelector{
//
//}

@end



/**
@implementation NSObject (crash)

+ (BOOL)resolveInstanceMethod:(SEL)sel{
    NSLog(@"instanceMethod:%@",NSStringFromSelector(sel));
    NSLog(@"className:%@",[NSString stringWithUTF8String:class_getName(self)]);
    NSString* clsName = [NSString stringWithUTF8String:class_getName(self)];
    if ([clsName hasPrefix:@"GA"]) {//自己的方法
        class_addMethod(NSClassFromString(@"GAProxy"), sel, (IMP)crashMethod, "V@:");
        return NO;
    }
    return NO;
}
+ (BOOL)resolveClassMethod:(SEL)sel{
    NSLog(@"classMethod:%@",NSStringFromSelector(sel));
    if (sel == @selector(setString:)) {
        return class_addMethod(self, sel, (IMP)crashMethod, "V@:");
    }else{
        return NO;
    }
}
- (id)forwardingTargetForSelector:(SEL)aSelector{
    NSLog(@"needTargetForwardingMethod:%@",NSStringFromSelector(aSelector));
    NSLog(@"className:%@",NSStringFromClass([self class]));
    NSString* clsName = NSStringFromClass([self class]);
    if (class_respondsToSelector(NSClassFromString(@"GAProxy"), aSelector)) {
        return [NSClassFromString(@"GAProxy") new];
    }
    return nil;
}

@end
*/


@implementation GAProxy

- (void)setStringXXX:(NSString *)str{
    NSLog(@"%@",str);
}

@end


