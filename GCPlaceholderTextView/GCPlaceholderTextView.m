//
//  GCPlaceholderTextView.m
//  GCLibrary
//
//  Created by Guillaume Campagna on 10-11-16.
//  Copyright 2010 LittleKiwi. All rights reserved.
//

#import "GCPlaceholderTextView.h"

@interface GCPlaceholderTextView () 

@property (unsafe_unretained, nonatomic, readonly) NSString* realText;

- (void) beginEditing:(NSNotification*) notification;
- (void) endEditing:(NSNotification*) notification;

@end

@implementation GCPlaceholderTextView

#pragma mark -
#pragma mark Initialisation

- (id) initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        [self awakeFromNib];
    }
    return self;
}

- (void)awakeFromNib {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(beginEditing:) name:UITextViewTextDidBeginEditingNotification object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(endEditing:) name:UITextViewTextDidEndEditingNotification object:self];
    
    self.realTextColor = self.textColor;
    self.placeholderColor = [UIColor lightGrayColor];
    self.realFont = self.font;
    self.placeholderFont = self.font;
}

#pragma mark -
#pragma mark Setter/Getters

- (void) setPlaceholder:(NSString *)aPlaceholder {
    if ([self.realText isEqualToString:_placeholder] && ![self isFirstResponder]) {
        self.text = aPlaceholder;
    }
    if (aPlaceholder != _placeholder) {
        _placeholder = aPlaceholder;
    }
    
    
    [self endEditing:nil];
}

- (void)setPlaceholderColor:(UIColor *)aPlaceholderColor {
    _placeholderColor = aPlaceholderColor;
    
    if ([super.text isEqualToString:self.placeholder]) {
        self.textColor = self.placeholderColor;
    }
}

- (void)setPlaceholderFont:(UIFont *)aPlaceholderFont {
    _placeholderFont = aPlaceholderFont;
    
    if ([super.text isEqualToString:self.placeholder]) {
        self.font = self.placeholderFont;
    }
}

- (NSString *) text {
    NSString* text = [super text];
    if ([text isEqualToString:self.placeholder]) return @"";
    return text;
}

- (void) setText:(NSString *)text {
    if (([text isEqualToString:@""] || text == nil) && ![self isFirstResponder]) {
        super.text = self.placeholder;
    }
    else {
        super.text = text;
    }
    
    if ([text isEqualToString:self.placeholder] || text == nil) {
        self.textColor = self.placeholderColor;
        self.font = self.placeholderFont;
    }
    else {
        self.textColor = self.realTextColor;
        self.font = self.realFont;
    }
}

- (NSString *) realText {
    return [super text];
}

- (void) beginEditing:(NSNotification*) notification {
    if ([self.realText isEqualToString:self.placeholder]) {
        super.text = nil;
        self.textColor = self.realTextColor;
        self.font = self.realFont;
    }
}

- (void) endEditing:(NSNotification*) notification {
    if ([self.realText isEqualToString:@""] || self.realText == nil) {
        self.textColor = self.placeholderColor;
        super.text = self.placeholder;
    }
}

- (void) setTextColor:(UIColor *)textColor {
    if ([self.realText isEqualToString:self.placeholder]) {
        if ([textColor isEqual:self.placeholderColor]){
             [super setTextColor:textColor];
        } else {
            self.realTextColor = textColor;
        }
    }
    else {
        self.realTextColor = textColor;
        [super setTextColor:textColor];
    }
}

- (void)setFont:(UIFont *)font {
    if ([self.realText isEqualToString:self.placeholder]) {
        if ([font isEqual:self.placeholderFont]){
            [super setFont:font];
        } else {
            self.realFont = font;
        }
    }
    else {
        self.realFont = font;
        [super setFont:font];
    }
}

- (void)goPrev {
    [self.prev becomeFirstResponder];
}

- (void)goNext {
    [self.next becomeFirstResponder];
}

- (void)done {
    [self resignFirstResponder];
}

#pragma mark -
#pragma mark Dealloc

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
