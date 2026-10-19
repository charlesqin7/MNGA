import SwiftUI

struct PlusView: View {
  var body: some View {
    List {
      Section {
        Label("All Features Available", systemImage: "checkmark.circle")
        Text("All features are available. No purchase or trial is required.")
          .foregroundStyle(.secondary)
      }
      Section("Features") {
        ForEach(PlusFeature.allCases, id: \.self) { feature in
          Label(LocalizedStringKey(feature.name), systemImage: feature.icon)
        }
      }
    }
    .fontWeight(.regular)
    .navigationTitle("All Features Available")
  }
}

struct PlusSheetView: View {
  var body: some View {
    NavigationStack {
      PlusView()
    }
  }
}
