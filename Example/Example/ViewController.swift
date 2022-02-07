//
//  ViewController.swift
//  Example
//
//  Created by yosshi4486 on 2022/02/06.
//

import UIKit
import EmojiPickerViewController

class ViewController: UIViewController {

    let resultLabel: UILabel = .init(frame: .zero)

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(resultLabel)
        resultLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            resultLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            resultLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: 50)
        ])

        resultLabel.text = ""

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Pick Emoji", image: nil, primaryAction: UIAction(handler: { [unowned self] _ in
            self.showPicker()
        }))

    }

    func showPicker() {

        let emojiPicker = EmojiPickerViewController()
        emojiPicker.delegate = self

        /*
         You can specify a language for searching and voiceover.
         */
        emojiPicker.emojiContainer.annotationResource = EmojiAnnotationResource(localeIdentifier: "ja")!

        let navigationController = UINavigationController(rootViewController: emojiPicker)

        if traitCollection.userInterfaceIdiom == .pad {

            navigationController.modalPresentationStyle = .popover

            let popover = navigationController.popoverPresentationController!
            popover.barButtonItem = navigationItem.rightBarButtonItem
            popover.delegate = self

            let sheet = popover.adaptiveSheetPresentationController
            sheet.delegate = self
            sheet.detents = [.medium(), .large()]

        } else {

            navigationController.modalPresentationStyle = .pageSheet

            let sheet = navigationController.sheetPresentationController!
            sheet.delegate = self
            sheet.detents = [.medium(), .large()]

        }

        present(navigationController, animated: true)

    }

}

extension ViewController: EmojiPickerViewControllerDelegate {

    func emojiPickerViewController(_ emojiPickerViewController: EmojiPickerViewController, didPick emoji: Emoji) {
        print("The user picked \(emoji)")
        resultLabel.text!.append(emoji.character)

        /*
         Dismiss the `emojiPickerViewController` here if you don't want to allow multiple picking.
         */

        // emojiPickerViewController.dismiss(animated: true, completion: nil)
    }

    func emojiPickerViewController(_ emojiPickerViewController: EmojiPickerViewController, didReceiveError error: Error) {
        print(error)
    }

}

extension ViewController: UISheetPresentationControllerDelegate {

    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        print("EmojiPickerViewController did dismiss.")
    }

}

extension ViewController: UIPopoverPresentationControllerDelegate {

}
