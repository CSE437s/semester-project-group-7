//
//  WelcomeSliderImgView.swift
//  group_7
//
//  Created by Byeongjun Oh on 2/18/24.
//

import UIKit

class WelcomeSliderImgView: UIView,UIScrollViewDelegate {
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initView()
    }
    private lazy var backScrollView : UIScrollView = {
        let scrollView = UIScrollView.init(frame: CGRectMake(0,0,SCREEN_WIDTH,wid(250)))
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = self
        self.addSubview(scrollView)
        return scrollView
    }()
    private lazy var pageView : UIPageControl =
    {
        let view = UIPageControl.init(frame: CGRectMake(0,self.height-wid(15),SCREEN_WIDTH,wid(15)))
        view.pageIndicatorTintColor = RBG(199,205,237)
        view.currentPageIndicatorTintColor = RBG(63,87,190)
        view.addTarget(self, action: #selector(pageCilckAction(_:)), for: .valueChanged)
        self.addSubview(view)
        return view
    }()
    private func initView()
    {
        self.backScrollView.alpha = 1
        self.pageView.alpha = 1
    }
    func refreshData (_ imgArr : [String])
    {
        self.backScrollView.removeAllSubs()
        for i in 0..<imgArr.count
        {
            let view = UIView.init(frame: CGRectMake(SCREEN_WIDTH*CGFloat(i),0,SCREEN_WIDTH,wid(250)))
            let img = UIImageView.init(frame: CGRectMake((view.width-wid(262))/2.0,0,wid(262),wid(250)))
            img.image = UIImage(named: "\(i+1)")
            view.addSubview(img)
            self.backScrollView.addSubview(view)
        }
        self.pageView.numberOfPages = imgArr.count
        self.pageView.currentPage = 0
        self.backScrollView.contentSize = CGSizeMake(SCREEN_WIDTH*CGFloat(imgArr.count),0)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.pageView.currentPage = Int(scrollView.contentOffset.x/SCREEN_WIDTH)
    }
    @objc func pageCilckAction(_ sender : UIPageControl)
    {
        self.backScrollView.setContentOffset(CGPointMake(CGFloat(sender.currentPage)*SCREEN_WIDTH,0), animated: true)
    }
}
