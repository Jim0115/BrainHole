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
