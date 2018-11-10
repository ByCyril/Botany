//
//  ViewController.swift
//  CustomCamera
//
//  Created by Cyril Garcia on 9/19/18.
//  Copyright © 2018 Cyril Garcia. All rights reserved.
//

import UIKit
import AVKit

protocol CameraDelegate {
    func getImage(_ image: UIImage)
}

class CameraController: UIViewController, AVCapturePhotoCaptureDelegate {

    private var cancelButton: UIButton!
    private var captureButton: UIButton!

    public var delegate: CameraDelegate!

    private var capturePhotoOutput: AVCapturePhotoOutput!
    private var captureSession: AVCaptureSession!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setupButtons()
        self.addButtonsToSubView()
        self.setupCamera()

    }

    private func setupButtons() {
        self.cancelButton = {
            let button = self.button("Cancel")
            button.frame.size = CGSize(width: 100, height: 35)
            button.center = CGPoint(x: self.view.frame.size.width / 6, y: self.view.frame.size.height * 0.15)
            button.addTarget(self, action: #selector(CameraController.cancel), for: .touchUpInside)
            return button
        }()

        self.captureButton = {
            let button = self.button("Capture")
            button.frame.size = CGSize(width: 100, height: 35)
            button.center = CGPoint(x: self.view.frame.size.width / 2, y: self.view.frame.size.height * 0.80)
            button.addTarget(self, action: #selector(CameraController.capture), for: .touchUpInside)
            return button
        }()
    }

    private func addButtonsToSubView() {
        self.view.addSubview(self.cancelButton)
        self.view.addSubview(self.captureButton)
    }

    private func button(_ title: String) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.layer.zPosition = 5
        return button
    }

    @objc private func cancel() {
        self.captureSession.stopRunning()
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func capture() {
    
        let photoSettings = AVCapturePhotoSettings()
        photoSettings.isAutoStillImageStabilizationEnabled = true
        photoSettings.isHighResolutionPhotoEnabled = true
        photoSettings.flashMode = .auto
        self.capturePhotoOutput.capturePhoto(with: photoSettings, delegate: self)
        self.hapticFeedback()
    }

    private func setupCamera()  {
        self.captureSession = AVCaptureSession()

        do {
            let input = try AVCaptureDeviceInput(device: AVCaptureDevice.default(for: .video)!)
            self.captureSession.addInput(input)
        } catch {
            fatalError("Could not load Camera")
        }

        let preview_layer = AVCaptureVideoPreviewLayer(session: self.captureSession)
        preview_layer.videoGravity = .resizeAspectFill
        preview_layer.connection?.videoOrientation = .portrait
        preview_layer.frame = self.view.layer.bounds
        self.view.layer.addSublayer(preview_layer)

        self.capturePhotoOutput = AVCapturePhotoOutput()
        self.capturePhotoOutput.isHighResolutionCaptureEnabled = true
        self.capturePhotoOutput.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
        self.captureSession.addOutput(self.capturePhotoOutput)

        self.captureSession.startRunning()

    }

    
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {

        let data = photo.fileDataRepresentation()!
        let image = UIImage(data: data)
        self.delegate.getImage(image!)
        self.captureSession.stopRunning()
        self.dismiss(animated: true, completion: nil)

    }

    private func hapticFeedback() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
}



