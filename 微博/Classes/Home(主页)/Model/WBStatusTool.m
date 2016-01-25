//
//  WBStatusTool.m
//  JW微博JW
//
//  Created by wangjianwei on 16/1/22.
//  Copyright © 2016年 JW. All rights reserved.
//

#import "WBStatusTool.h"
#import "FMDB.h"
#import "WBStatus.h"
static FMDatabase* _db;

@implementation WBStatusTool
+(void)initialize{
    [super initialize];
    if (self == [WBStatusTool self]) {
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSString *dbPath = [cachePath stringByAppendingPathComponent:@"WBStatus.sqlite"];
        //建立数据库
        _db = [FMDatabase databaseWithPath:dbPath];
        if (!_db) {
            JWLog(@"建立数据库失败了");
            return;
        }
        if (![_db open]) {
            JWLog(@"%@",_db.lastErrorMessage);
        }
        //建表
        NSString *createTable = [NSString stringWithFormat:@"create table if not exists t_status(id integer primary key,status blob not null,idstr text not null unique)"];
        [_db executeUpdate:createTable];
    }
}
+(NSArray *)loadNewStatusesByMinStatus:(WBStatus *)status{
    NSString *selectSql = nil;
    if (status) {
        selectSql = [NSString stringWithFormat:@"select status from t_status where idstr >  %@ order by idstr desc limit 20",status.idstr];
    }else{
        selectSql = [NSString stringWithFormat:@"select status from t_status order by idstr desc limit 20"];
    }
    return [self loadStatusBySQL:selectSql];
}
+(NSArray *)loadOldStatusesByMaxStatus:(WBStatus *)status{
    NSString *selectSql = [NSString stringWithFormat:@"select status from t_status where idstr <  %@ order by idstr desc limit 20",status.idstr];
    return [self loadStatusBySQL:selectSql];
}
+(NSArray*)loadStatusBySQL:(NSString*)sql{
    NSMutableArray*statuses = [NSMutableArray array];
    FMResultSet *set = [_db executeQuery:sql];
    while ([set next]) {
        NSData *data = [set dataForColumn:@"status"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (status) {
            [statuses addObject:status];
        }
    }
    return statuses.count > 0?statuses:nil;
}
//可以保存status 数组，但是我们没有保存status 数组，这是因为status 数组在后面已经被处理过了，不是原来的数据了，我们保存原来的数据，反而更加简单些
+(void)saveStatuses:(NSArray *)statuses{
    for (NSDictionary *status  in statuses) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:status];
        [_db executeUpdateWithFormat:@"insert into t_status(status,idstr) values(%@,%@)",data,status[@"idstr"]];
    }
}
@end
