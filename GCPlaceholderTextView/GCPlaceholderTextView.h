//
//  GCPlaceholderTextView.h
//  GCLibrary
//
//  Created by Guillaume Campagna on 10-11-16.
//  Copyright 2010 LittleKiwi. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface GCPlaceholderTextView : UITextView 

@property (nonatomic, assign) id<UITextInput> next;
@property (nonatomic, assign) id<UITextInput> prev;
@property (nonatomic, strong) NSString *placeholder;

@property (nonatomic, strong) UIColor *realTextColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIColor *placeholderColor UI_APPEARANCE_SELECTOR;
@property (nonatomic, strong) UIFont *placeholderFont;

- (void)goPrev;
- (void)goNext;
- (void)done;

@end
