//
//  WebViewWrapper.swift
//  SwiftUIAdapted
//
//  Created by Brett Clifton on 1/16/24.
//

import SwiftUI
import WebKit

// Custom SwiftUI view that wraps a WKWebView
struct WebViewWrapper: UIViewRepresentable {
    let urlString: String

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.scrollView.isScrollEnabled = false
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            uiView.load(request)
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebViewWrapper

        init(_ parent: WebViewWrapper) {
            self.parent = parent
        }

        // Implement WKNavigationDelegate methods if needed
    }
}

struct WebViewWrapper_Previews: PreviewProvider {
    static var previews: some View {
        WebViewWrapper(urlString: "https://ad.img.qa.adadapted.dev/platform/ads/2800/6318/1212/102110.html?session_id=98ABF46426052F6692482BE92A8D6F0X65A6F388&udid=00000000-0000-0000-0000-000000000000")
    }
}
