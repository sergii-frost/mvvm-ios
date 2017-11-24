//
//  UserProfileViewController.swift
//  mvvm-ios
//
//  Created by Sergii Frost on 2017-11-23.
//  Copyright © 2017 Frost Experience AB. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

public class UserProfileViewController: UIViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var createdLabel: UILabel!
    @IBOutlet weak var companyContainerView: UIView!
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var locationContainerView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var linkContainerView: UIView!
    @IBOutlet weak var linkLabel: UILabel!
    @IBOutlet weak var reposContainerView: UIView!
    @IBOutlet weak var reposLabel: UILabel!
    @IBOutlet weak var gistsContainerView: UIView!
    @IBOutlet weak var gistsLabel: UILabel!
    
    var viewModel: UserProfileViewModel?
    let disposeBag = DisposeBag()
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter
    }()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        viewModel?.fetchProfile()
    }
    
    fileprivate func setupBindings() {
        guard let viewModel = viewModel else {
            return
        }
        viewModel.name.asObservable().bind(to: nameLabel.rx.text).disposed(by: disposeBag)
        viewModel.login.asObservable().bind(to: loginLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.avatarUrl.asObservable()
            .map { avatarUrl -> URL? in
                return URL(string: avatarUrl)
            }.bind { [weak self] url in
                self?.avatarImageView.kf.setImage(with: url)
            }.disposed(by: disposeBag)
        
        viewModel.bio.asObservable().bind(to: bioTextView.rx.text).disposed(by: disposeBag)
        viewModel.createdAt.asObservable()
            .map { [weak self] date -> String? in
                return self?.dateFormatter.string(from: date)
            }.bind(to: createdLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.company.asObservable().bind(to: companyLabel.rx.text).disposed(by: disposeBag)
        viewModel.location.asObservable().bind(to: locationLabel.rx.text).disposed(by: disposeBag)
        viewModel.email.asObservable().bind(to: emailLabel.rx.text).disposed(by: disposeBag)
        viewModel.blog.asObservable().bind(to: linkLabel.rx.text).disposed(by: disposeBag)
        viewModel.publicRepos.asObservable()
            .map { repos -> String in
                return "Public Repos #: \(repos)"
            }.bind(to: reposLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.publicGists.asObservable()
            .map { gists -> String in
                return "Public Gists #: \(gists)"
            }.bind(to: gistsLabel.rx.text)
            .disposed(by: disposeBag)
        
        setupVisibilityBindings()
    }
    
    fileprivate func setupVisibilityBindings() {
        guard let viewModel = viewModel else {
            return
        }
        //Binding hiding views - yeah, a bit tricky
        viewModel.bio.asObservable()
            .map { bio -> Bool in
                return bio?.isEmpty ?? true
            }.bind(onNext: { [weak self] isHidden in
                self?.bioTextView.isHidden = isHidden
            }).disposed(by: disposeBag)
        
        viewModel.company.asObservable()
            .map { company -> Bool in
                return company?.isEmpty ?? true
            }.bind(onNext: { [weak self] isHidden in
                self?.companyContainerView.isHidden = isHidden
            }).disposed(by: disposeBag)
        
        viewModel.location.asObservable()
            .map { location -> Bool in
                return location?.isEmpty ?? true
            }.bind(onNext: { [weak self] isHidden in
                self?.locationContainerView.isHidden = isHidden
            }).disposed(by: disposeBag)
        
        viewModel.email.asObservable()
            .map { email -> Bool in
                return email?.isEmpty ?? true
            }.bind(onNext: { [weak self] isHidden in
                self?.emailContainerView.isHidden = isHidden
            }).disposed(by: disposeBag)
        
        viewModel.blog.asObservable()
            .map { blog -> Bool in
                return blog?.isEmpty  ?? true
            }.bind(onNext: { [weak self] isHidden in
                self?.linkContainerView.isHidden = isHidden
            }).disposed(by: disposeBag)
        
        viewModel.publicRepos.asObservable()
            .map { repos -> Bool in
                return repos == 0
            }.bind(onNext: { [weak self] isHidden in
                self?.reposContainerView.isHidden = isHidden
            }).disposed(by: disposeBag)
        
        viewModel.publicGists.asObservable()
            .map { gists -> Bool in
                return gists == 0
            }.bind(onNext: { [weak self] isHidden in
                self?.gistsContainerView.isHidden = isHidden
            }).disposed(by: disposeBag)

    }
    
    //MARK: IBActions
    
    @IBAction func showRepos(_ sender: Any) {
        //TODO: implement
    }
    
    @IBAction func showGists(_ sender: Any) {
        //TODO: implement
    }

}
