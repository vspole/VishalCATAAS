//
//  ActivityViewController.swift
//  VishalCATAAS
//
//  Created by Vishal Polepalli on 6/30/22.
//

import SwiftUI
import UIKit

/// This is a view from which to be able to present a `UIActivityViewController`.  It will present when the shared `items` is not empty.  Keep the view as part of the hierarchy such as in the background.
///
/// Note* It is not a normal implementation of `UIViewControllerRepresentable` where I would just return the `UIViewControllerRepresentable` directly, because when using SwiftUI to
/// present, it goes straight to the full sheet modal.  In order to keep the usual half/bottom sheet presentation, I present from another `UIViewController` and it works automatically.

struct ActivityViewController: UIViewControllerRepresentable {
    @Binding var items: [Any]
    
    func makeUIViewController(context: Context) -> UIViewController {
        UIViewController()
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        if uiViewController.presentedViewController == nil && !items.isEmpty {
            let activityVC = UIActivityViewController(activityItems: items, applicationActivities: nil)
            activityVC.completionWithItemsHandler = { _, _, _, _ in
               items = []
            }
            uiViewController.present(activityVC, animated: true)
        }
    }
}
