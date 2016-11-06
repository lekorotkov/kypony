//
//  QRCodeViewController.swift
//  Kypony
//
//  Created by Александр Карцев on 11/6/16.
//  Copyright © 2016 Alex Kartsev. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeViewController: UIViewController, QRCodeReaderViewControllerDelegate {
    
    lazy var reader = QRCodeReaderViewController(builder: QRCodeReaderViewControllerBuilder {
        $0.reader          = QRCodeReader(metadataObjectTypes: [AVMetadataObjectTypeQRCode])
        $0.showTorchButton = true
    })

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - QRCodeReaderViewControllerDelegate
    
    /*
     Tells the delegate that the reader did scan a code.
     
     - parameter reader: A code reader object informing the delegate about the scan result.
     - parameter result: The result of the scan
     */
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        reader.stopScanning()
        
        dismiss(animated: true) { [weak self] in
            let alert = UIAlertController(
                title: "QRCodeReader",
                message: String (format:"%@ (of type %@)", result.value, result.metadataType),
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            self?.present(alert, animated: true, completion: nil)
        }
    }
    
    /**
     Tells the delegate that the camera was switched by the user
     
     - parameter reader: A code reader object informing the delegate about the scan result.
     - parameter newCaptureDevice: The capture device that was switched to
     */
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        if let cameraName = newCaptureDevice.device.localizedName {
            print("Switching capturing to: \(cameraName)")
        }
    }
    
    /**
     Tells the delegate that the user wants to stop scanning codes.
     
     - parameter reader: A code reader object informing the delegate about the cancellation.
     */
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        dismiss(animated: true, completion: nil)
    }

}
