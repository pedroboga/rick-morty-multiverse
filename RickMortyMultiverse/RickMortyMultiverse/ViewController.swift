//
//  ViewController.swift
//  RickMortyMultiverse
//
//  Created by Pedro Boga on 01/10/21.
//

import UIKit

class ViewController: UIViewController {
    private var charactersCollectionView: UICollectionView?
    var viewModel = ViewModel()
    var characterCount = 0
    
    //var service = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        charactersCollectionView?.frame = view.bounds
    }
    
    func configView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width/3.2, height: view.frame.size.width/3.2)
        layout.sectionInset = UIEdgeInsets.zero
        charactersCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        charactersCollectionView?.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
        charactersCollectionView?.delegate = self
        charactersCollectionView?.dataSource = self
        charactersCollectionView?.backgroundColor = .white
        view.addSubview(charactersCollectionView!)
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        
        charactersCollectionView?.addGestureRecognizer(gesture)
    }
    
    func loadData() {
        DispatchQueue.main.async {
            //self.viewModel.getCharacters()
            self.viewModel.getCharactersCount { count in
                self.characterCount = count
                self.charactersCollectionView?.reloadData()
            }
        }
    }
    
    @objc func handleLongPressGesture(_ gesture: UILongPressGestureRecognizer) {
        guard let collectionView = charactersCollectionView else { return }
        switch gesture.state {
        case .began:
            guard let targetIndexPath = collectionView.indexPathForItem(at: gesture.location(in: collectionView)) else { return }
            collectionView.beginInteractiveMovementForItem(at: targetIndexPath)
        case .changed:
            collectionView.updateInteractiveMovementTargetPosition(gesture.location(in: collectionView))
        case .ended:
            collectionView.endInteractiveMovement()
        default:
            collectionView.cancelInteractiveMovement()
        }
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characterCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        cell.backgroundColor = .systemRed
        DispatchQueue.main.async {
            self.viewModel.getImage(with: indexPath.row) { image in
                cell.cellAvatar.image = image
            }
        }
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.size.width/3.2, height: view.frame.size.width/3.2)
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        //let item = colors.remove(at: sourceIndexPath.row)
        //colors.insert(item, at: destinationIndexPath.row)
    }
    
}

