import Foundation
import UIKit
import AssetsLibrary

@objc(ShareSheet)
class ShareSheet: NSObject {
  
  let InstagramExtension = ".igo"
  var documentController: UIDocumentInteractionController?

  @objc func callbackMethod(callback: RCTResponseSenderBlock) -> Void {
    let resultsDict = [
      "success" : true
    ];
    
    let assetsLibrary = ALAssetsLibrary()
    print(assetsLibrary)
    
    callback([NSNull() ,resultsDict])
  }
  @objc func open(config: Dictionary<String, AnyObject>)  {
    open(config, callback: { (o) -> Void in })
  }
  
  @objc func open(config: Dictionary<String, AnyObject>, callback: RCTResponseSenderBlock)  {
    let text = config["text"] as? String;
    let url = config["url"] as? String
    
    let success: () -> Void = {
      callback([NSNull(), ["status":"OK"]])
    }
    
    let fail: (msg: String) -> Void = { msg in
      callback([msg, NSNull()])
    }
    
    // do share
    let shareWithImage: (imageUrl: String, image: UIImage?) -> Void = { [unowned self] imageUrl, image in
      if image == nil {
        fail(msg: "Error loading image at: \(imageUrl)")
      } else {
        self.openShareSheet(text, url: url, image: image, callback: success)
      }
    }
    
    // handle imageUrl
    if let imageUrl = config["imageUrl"] as? String {
      if imageUrl.hasPrefix("assets-library://") {
        getImageFromAssetUrl(imageUrl, callback: { (image) -> Void in
          shareWithImage(imageUrl: imageUrl, image: image)
        })
      } else {
        getImageFromUrl(imageUrl, callback: { (image) -> Void in
          shareWithImage(imageUrl: imageUrl, image: image)
        })
      }
      return
    }
    
    openShareSheet(text, url: url, image: Optional.None, callback: success)
  }

  
  @objc func getImageFromUrl(imageUrl: String, callback: (UIImage?) -> Void) -> Void {
    let url = NSURL(string: imageUrl)
    let data = NSData(contentsOfURL: url!)
    if data != nil {
      callback(UIImage(data: data!))
    } else {
      callback(Optional.None)
    }
  }
  
  // e.g. assets-library://asset/asset.JPG?id=AD5F82E6-E4EE-4046-9155-63CC56ED923D&ext=JPG
  @objc func getImageFromAssetUrl(imageUrl: String, callback: (UIImage?) -> Void) {
    let assetsLibrary = ALAssetsLibrary()
    let url = NSURL(fileURLWithPath: imageUrl)
    var image: UIImage?
    assetsLibrary.assetForURL(url, resultBlock: { (asset) -> Void in
      if asset == nil {
        callback(image)
      } else {
        image = UIImage(CGImage: asset.defaultRepresentation().fullResolutionImage().takeUnretainedValue())
        callback(image)
      }
      }, failureBlock: { (error) -> Void in
        callback(image)
    })
  }
  
  @objc func openShareSheet(text: String?, url: String?, image: UIImage?, callback: () -> Void) {
    var activityItems = [AnyObject]();
    
    if text != nil {
      activityItems.append(text!)
    }
    if image != nil {
      activityItems.append(image!)
    }
    
    if url != nil {
      activityItems.append(NSURL(string: url!)!)
    }
  
    let activityViewController = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
    dispatch_async(dispatch_get_main_queue(), { () -> Void in
      if let rootViewController = UIApplication.sharedApplication().delegate?.window??.rootViewController {
        rootViewController.presentViewController(activityViewController, animated: true) { () -> Void in
          callback()
        }
      }
    })
    
  }
  
}