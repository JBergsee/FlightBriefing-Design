import Foundation

// MARK: - SlideCommander

/// Commands that the cover view may issue to its container.
///
/// The container is the sole conformer, via its private ``SlideContainerCoordinator``.
/// The cover's underlying `UIViewController` holds a `weak` reference to the coordinator,
/// breaking the retain cycle that would otherwise form between container and cover.
///
/// `@MainActor` constrains all call sites to the main thread, matching both UIKit's
/// requirement and SwiftUI's execution context. Without it, Swift 6 strict concurrency
/// flags the conformance in ``SlideContainerCoordinator`` as a potential data race.
@MainActor
public protocol SlideCommander: AnyObject {

    /// Animates the cover to the fully-visible position (normalised 1.0).
    /// Calls `onCoverDidReachTop` on completion.
    func slideUp()

    /// Animates the cover to the collapsed position (normalised 0.0).
    /// Calls `onCoverDidGoToBottom` on completion.
    func slideDown()
}

// MARK: - SlideCommandable

/// Contract that a cover must satisfy to receive its ``SlideCommander`` reference
/// from the container.
///
/// ## Motivation
/// The container cannot assign `cover.slideCommander = coordinator` directly
/// because that would require Cover to be a class (for the assignment to persist
/// on the original object rather than a copy). SwiftUI enforces that all `View`
/// conformers are value types, so Cover must be a struct.
///
/// The solution: a **method** call. A `UIViewControllerRepresentable` struct holds
/// a reference to its `UIViewController` (a class). Calling `setSlideCommander(_:)`
/// on the struct forwards to the VC and mutates it in-place — no `AnyObject`
/// constraint needed on this protocol.
///
/// ## UIViewControllerRepresentable usage
/// ```swift
/// struct CoverRepresentable: UIViewControllerRepresentable, SlideCommandable {
///     let viewController: CoverViewController
///
///     func makeUIViewController(context: Context) -> CoverViewController { viewController }
///     func updateUIViewController(_ vc: CoverViewController, context: Context) {}
///
///     func setSlideCommander(_ commander: any SlideCommander) {
///         viewController.slideCommander = commander   // mutates VC in-place
///     }
/// }
///
/// class CoverViewController: UIViewController {
///     weak var slideCommander: (any SlideCommander)?   // weak: VC doesn't own the container
/// }
/// ```
///
/// `@MainActor` matches ``SlideCommander`` and ``SlideContainerView``'s execution
/// context, keeping Swift 6 concurrency checks clean.
@MainActor
public protocol SlideCommandable {
    /// Called by the container immediately after construction.
    /// Forward this to the underlying `UIViewController` (or equivalent class) that
    /// will issue slide commands. That class should store the reference `weak`.
    func setSlideCommander(_ commander: any SlideCommander)
}
