# 使用代码添加约束（原生）
frame的优先级低于constraints

## NSLayoutConstraint
Objective-C：

    + (instancetype)constraintWithItem:(id)view1
                             attribute:(NSLayoutAttribute)attr1
                             relatedBy:(NSLayoutRelation)relation
                                toItem:(id)view2 
                             attribute:(NSLayoutAttribute)attr2
                            multiplier:(CGFloat)multiplier
                              constant:(CGFloat)c
                              
Swift：

    convenience init(item view1: AnyObject, attribute attr1: NSLayoutAttribute, relatedBy relation: NSLayoutRelation, toItem view2: AnyObject?, attribute attr2: NSLayoutAttribute, multiplier multiplier: CGFloat, constant c: CGFloat)
    
### NSLayoutRelation
Objective-C：

    typedef enum: NSInteger {
       NSLayoutAttributeLeft = 1,
       NSLayoutAttributeRight,
       NSLayoutAttributeTop,
       NSLayoutAttributeBottom,
       NSLayoutAttributeLeading,
       NSLayoutAttributeTrailing,
       NSLayoutAttributeWidth,
       NSLayoutAttributeHeight,
       NSLayoutAttributeCenterX,
       NSLayoutAttributeCenterY,
       NSLayoutAttributeBaseline,
       NSLayoutAttributeLastBaseline = NSLayoutAttributeBaseline,
       NSLayoutAttributeFirstBaseline,
       
       NSLayoutAttributeLeftMargin,
       NSLayoutAttributeRightMargin,
       NSLayoutAttributeTopMargin,
       NSLayoutAttributeBottomMargin,
       NSLayoutAttributeLeadingMargin,
       NSLayoutAttributeTrailingMargin,
       NSLayoutAttributeCenterXWithinMargins,
       NSLayoutAttributeCenterYWithinMargins,
       
       NSLayoutAttributeNotAnAttribute = 0
    } NSLayoutAttribute;

Swift：

    enum NSLayoutAttribute : Int {
        case Left
        case Right
        case Top
        case Bottom
        case Leading
        case Trailing
        case Width
        case Height
        case CenterX
        case CenterY
        case Baseline
        static var LastBaseline: NSLayoutAttribute { get }
        case FirstBaseline
        case LeftMargin
        case RightMargin
        case TopMargin
        case BottomMargin
        case LeadingMargin
        case TrailingMargin
        case CenterXWithinMargins
        case CenterYWithinMargins
        case NotAnAttribute
    }
    
在约束生效前，必须将需要改变状态的view的`translatesAutoresizingMaskIntoConstraints`属性设置为false。由代码创建的View该属性默认为true而由IB创建的View该属性默认为false。
>If you want to use Auto Layout to dynamically calculate the size and position of your view, you must set this property to NO, and then provide a non ambiguous, nonconflicting set of constraints for the view.

### Problems
在向IB生成的View中直接添加约束时，将导致约束冲突。原因在于IB会向View中添加自动生成的约束条件。因此在对这种View添加约束时应该先使用IB添加对应的约束，之后勾选约束的`PlaceHolder`选项，将自动生成的约束在构建时移除。即可使代码添加的约束生效。  
**高度和宽度应该添加到需要约束的View，位置信息应该添加到父视图**

## Visual Fromat Language (VFL)
一种象形文字 :)  
 
Swift：

    class func constraintsWithVisualFormat(_ format: String, options opts: NSLayoutFormatOptions, metrics metrics: [String : AnyObject]?, views views: [String : AnyObject]) -> [NSLayoutConstraint]
    
Objective-C:

    + (NSArray<__kindof NSLayoutConstraint *> *)
    constraintsWithVisualFormat:(NSString *)format
                        options:(NSLayoutFormatOptions)opts
                        metrics:(NSDictionary<NSString *,id> *)metrics
                          views:(NSDictionary<NSString *,id> *)views
                          
是`NSLayoutConstraint`的类方法，返回一组约束。  
`format`：VFL语句  
`opts`：  
Swift：

    struct NSLayoutFormatOptions : OptionSetType {
        init(rawValue rawValue: UInt)
        static var AlignAllLeft: NSLayoutFormatOptions { get }
        static var AlignAllRight: NSLayoutFormatOptions { get }
        static var AlignAllTop: NSLayoutFormatOptions { get }
        static var AlignAllBottom: NSLayoutFormatOptions { get }
        static var AlignAllLeading: NSLayoutFormatOptions { get }
        static var AlignAllTrailing: NSLayoutFormatOptions { get }
        static var AlignAllCenterX: NSLayoutFormatOptions { get }
        static var AlignAllCenterY: NSLayoutFormatOptions { get }
        static var AlignAllBaseline: NSLayoutFormatOptions { get }
        static var AlignAllLastBaseline: NSLayoutFormatOptions { get }
        static var AlignAllFirstBaseline: NSLayoutFormatOptions { get }
        static var AlignmentMask: NSLayoutFormatOptions { get }
        static var DirectionLeadingToTrailing: NSLayoutFormatOptions { get }
        static var DirectionLeftToRight: NSLayoutFormatOptions { get }
        static var DirectionRightToLeft: NSLayoutFormatOptions { get }
        static var DirectionMask: NSLayoutFormatOptions { get }
    }
    
Objective-C:

    enum {
       /* choose only one of these */
       NSLayoutFormatAlignAllLeft = NSLayoutAttributeLeft,
       NSLayoutFormatAlignAllRight = NSLayoutAttributeRight,
       NSLayoutFormatAlignAllTop = NSLayoutAttributeTop,
       NSLayoutFormatAlignAllBottom = NSLayoutAttributeBottom,
       NSLayoutFormatAlignAllLeading = NSLayoutAttributeLeading,
       NSLayoutFormatAlignAllTrailing = NSLayoutAttributeTrailing,
       NSLayoutFormatAlignAllCenterX = NSLayoutAttributeCenterX,
       NSLayoutFormatAlignAllCenterY = NSLayoutAttributeCenterY,
       NSLayoutFormatAlignAllBaseline = NSLayoutAttributeBaseline,
       
       NSLayoutFormatAlignmentMask = 0xFF,
       
       /* choose only one of these three */
       NSLayoutFormatDirectionLeadingToTrailing = 0 << 8, // default 
       NSLayoutFormatDirectionLeftToRight = 1 << 8,
       NSLayoutFormatDirectionRightToLeft = 2 << 8,
       
       NSLayoutFormatDirectionMask = 0x3 << 8,
    };
    typedef NSUInteger NSLayoutFormatOptions;
    
`metrics`：一个字典，在VFL中出现的参数值作为Dictionary的Key。若无该键对应的值，程序将Crash。
>A dictionary of constants that appear in the visual format string. The dictionary’s keys must be the string values used in the visual format string. Their values must be NSNumber objects.  

`views`：一个字典，用于获取VFL中出现的View。无对应值同样可能导致Crash。
>A dictionary of views that appear in the visual format string. The keys must be the string values used in the visual format string, and the values must be the view objects.

Example：  
实现四个等大的正方形View水平排列在SuperView水平中心


