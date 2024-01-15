//
//  VisualEffectView.swift
//  taxi_driver
//
//  Created by CodeForAny on 10/10/23.
//

import SwiftUI

struct VisualEffectView: UIViewRepresentable {
    @State var blurRadius: CGFloat
    
    func makeUIView(context: UIViewRepresentableContext<VisualEffectView>) -> VisualEffectViewUI {
        let view = VisualEffectViewUI()
        view.colorTint = UIColor.black
       view.colorTintAlpha = 0.1
       view.blurRadius = blurRadius
        return  view
    }
    
    func updateUIView(_ uiView: VisualEffectViewUI, context: UIViewRepresentableContext<VisualEffectView>) {
        uiView.blurRadius = blurRadius
    }
}

#Preview {
    VisualEffectView(blurRadius: 15.0)
}

open class VisualEffectViewUI: UIVisualEffectView {
    private let blurEffect = (NSClassFromString("_UICustomBlurEffect") as! UIBlurEffect.Type ).init()
    open var colorTint: UIColor? {
        get {
            if #available(iOS 14, tvOS 14, *) {
                return ios14_colorTint
            } else {
                return _value(forKey: .colorTint)
            }
        }
        
        set {
            if #available(iOS 14, tvOS 14, *) {
                ios14_colorTint = newValue
            } else {
                _setValue(newValue, forKey: .colorTint)
            }
        }
    }
    
    open var colorTintAlpha: CGFloat {
            get { return _value(forKey: .colorTintAlpha) }
            set {
                if #available(iOS 14 , tvOS 14, *) {
                    ios14_colorTint = ios14_colorTint?.withAlphaComponent(newValue)
                } else {
                    _setValue(newValue, forKey: .colorTintAlpha)
                }
            }
        }
    
    open var blurRadius: CGFloat {
            get {
                if #available(iOS 14, tvOS 14, *) {
                    return ios14_blurRadius
                } else {
                    return _value(forKey: .blurRadius)
                }
            }
            set {
                if #available(iOS 14, tvOS 14, *) {
                    ios14_blurRadius = newValue
                } else {
                    _setValue(newValue, forKey: .blurRadius)
                }
            }
        }
    
    open var scale: CGFloat {
            get { return _value(forKey: .scale) }
            set { _setValue(newValue, forKey: .scale) }
        }
    
    public override init(effect: UIVisualEffect?) {
           super.init(effect: effect)
           self.isUserInteractionEnabled = false
           scale = 1
       }
       
       required public init?(coder aDecoder: NSCoder) {
           super.init(coder: aDecoder)
           
           scale = 1
       }
    
}


@available(iOS 14, tvOS 14, *)
extension UIVisualEffectView {
    var ios14_blurRadius: CGFloat {
        get {
            return gaussianBlur?.requestedValues?["inputRadius"] as? CGFloat ?? 0
        }
        set {
            prepareForChanges()
            gaussianBlur?.requestedValues?["inputRadius"] = newValue
            applyChanges()
        }
    }
    
    var ios14_colorTint: UIColor? {
        get {
            return sourceOver?.value(forKeyPath: "color") as? UIColor
        }
        set {
            prepareForChanges()
            sourceOver?.setValue(newValue, forKeyPath: "color")
            sourceOver?.perform(Selector(("applyRequestedEffectToView:")), with: overlayView)
            applyChanges()
            overlayView?.backgroundColor = newValue
        }
    }
}

private extension VisualEffectViewUI {
    
    func _value<T>(forKey key: Key) -> T {
        return blurEffect.value(forKeyPath: key.rawValue) as! T
    }
    
    func _setValue<T>(_ value: T, forKey key: Key) {
        blurEffect.setValue(value, forKeyPath: key.rawValue)
        if #available(iOS 14, *) {} else {
            self.effect = blurEffect
        }
    }
    
    enum Key: String {
        case colorTint, colorTintAlpha, blurRadius, scale
    }
    
}

private extension UIVisualEffectView {
    var backdropView: UIView? {
        return subview(of: NSClassFromString("_UIVisualEffectBackdropView"))
    }
    
    var overlayView: UIView? {
        return subview(of: NSClassFromString("_UIVisualEffectSubview"))
    }
    
    var gaussianBlur: NSObject? {
        return backdropView?.value(forKey: "filters", withFilterType: "gaussianBlur" )
    }
    
    var sourceOver: NSObject? {
        return overlayView?.value(forKey: "viewEffects", withFilterType: "sourceOver" )
    }
    
    func prepareForChanges(){
        self.effect = UIBlurEffect(style: .light)
        gaussianBlur?.setValue(1.0, forKey: "requestedScaleHint")
    }
    
    func applyChanges(){
        backdropView?.perform(Selector("applyRequestedFilterEffects"))
    }
}

private extension NSObject {
    var requestedValues:[String: Any]? {
        get {
            return value(forKeyPath: "requestedValues") as? [String: Any]
        }
        set {
            setValue(newValue, forKeyPath: "requestedValues")
        }
    }
    
    func value(forKey key: String, withFilterType filterType: String) -> NSObject? {
        return ( value(forKeyPath: key) as? [NSObject] )?.first { $0.value(forKeyPath: "filterType") as? String == filterType }
    }
}


private extension UIView {
    func subview(of classType: AnyClass?) -> UIView? {
        return subviews.first  { type(of: $0) == classType }
    }
}
