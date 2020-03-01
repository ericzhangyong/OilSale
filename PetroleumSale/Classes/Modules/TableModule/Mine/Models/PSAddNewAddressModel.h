//
//  FSAddNewAddressModel.h
//  FireStore
//
//  Created by eric on 2019/8/31.
//  Copyright © 2019 eric. All rights reserved.
//

#import "BaseModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger,FSAddNewAddressType){
    
    FSAddNewAddressTypeNickName,
    FSAddNewAddressTypePhone,
    FSAddNewAddressTypeCity,
    FSAddNewAddressTypeDetail
};

@interface PSAddNewAddressModel : BaseModel


/** title */
@property (nonatomic,copy) NSString *title;

/** content */
@property (nonatomic,copy) NSString *content;


/** placeHolder */
@property (nonatomic,copy) NSString *placeHolder;

/** type */
@property (nonatomic,assign) FSAddNewAddressType addNewType;


/// 标题
//@property (nonatomic,copy) NSString *label;
/// 是否可编辑
@property (nonatomic,assign) BOOL edit_enable;

/// 回显的值
//@property (nonatomic,copy) NSString *edit_text_value;

/// 编辑类型 input:输入框 checkbox:复选框 radio:单选框 select：下拉框
@property (nonatomic,copy) NSString *edit_type;

/// 当前信息修改后提交的json key
@property (nonatomic,copy) NSString *form_name;
/*{
  "option_value": "上海",
  "option_name": "上海",
  "selected": false
}*/
@property (nonatomic,strong) NSArray *option_values;


@end



NS_ASSUME_NONNULL_END
