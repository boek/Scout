//
//  ContentBlockerRequestHandler.swift
//  ContentBlocker
//
//  Created by Jeff Boek on 9/10/22.
//

import UIKit
import MobileCoreServices
import LibContentBlocker

extension NSExtensionContext: @unchecked Sendable {}

class ContentBlockerRequestHandler: NSObject, NSExtensionRequestHandling {
    func beginRequest(with context: NSExtensionContext) {
        let contentBlocker = ContentBlocker.live

        do {
            let url = try contentBlocker.combinedListURL()

            Task {
                if !FileManager.default.fileExists(atPath: url.path()) {
                    let _ = await contentBlocker.createCombinedList(BlockList.all)
                }

                let attachment = NSItemProvider(contentsOf: url)!
                let item = NSExtensionItem()
                item.attachments = [attachment]

                context.completeRequest(returningItems: [item], completionHandler: nil)
            }
        } catch {
            context.completeRequest(returningItems: [])
        }
    }
}
