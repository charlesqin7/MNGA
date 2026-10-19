import SwiftUI

// All features are available in this self-built edition, without StoreKit.
class PaywallModel: ObservableObject {
  static let shared = PaywallModel()

  @Published var isShowingModal = false

  var isUnlocked: Bool { true }
}

func checkPlus(_ feature: PlusFeature) -> Bool {
  true
}

func withPlusCheck<Result>(_ feature: PlusFeature, _ body: () throws -> Result) rethrows -> Result? {
  try body()
}

extension Binding where Value: Equatable {
  func withPlusCheck(_ feature: PlusFeature) -> Self {
    Binding(
      get: { self.wrappedValue },
      set: { newValue in
        if newValue == self.wrappedValue { return }
        MNGA.withPlusCheck(feature) { self.wrappedValue = newValue }
      },
    )
  }
}

struct PlusCheckNavigationLink<Label, Destination>: View where Label: View, Destination: View {
  let destination: Destination
  let isDetailLink: Bool
  let label: Label

  init(
    destination: Destination,
    feature: PlusFeature,
    isDetailLink: Bool = true,
    @ViewBuilder label: () -> Label,
  ) {
    self.destination = destination
    self.isDetailLink = isDetailLink
    self.label = label()
  }

  var body: some View {
    NavigationLink(destination: destination, label: { label })
      .isDetailLink(isDetailLink)
  }
}

struct DisableWithPlusCheckModifier: ViewModifier {
  let feature: PlusFeature

  func body(content: Content) -> some View {
    content
  }
}

extension View {
  func disableWithPlusCheck(_ feature: PlusFeature) -> some View {
    modifier(DisableWithPlusCheckModifier(feature: feature))
  }
}
