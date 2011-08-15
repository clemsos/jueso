# encoding: utf-8
module ApplicationHelper
  
  include ActsAsTaggableOn::TagsHelper #act as taggable on tag cloud
  
  # Return a title on a per-page basis.
    def title
      base_title = "Browse and enjoy"
      if @title.nil?
        base_title
      else
        "#{base_title} | #{@title}"
      end
    end
  
  #highlight the link based on current page

    def is_active?(page_name)
      "active" if params[:action] == page_name
    end
    
  #convert array to list
  def list(stuff, &block)
    content_tag(:ul, stuff.map { |thingie| content_tag(:li, yield(thingie)) })
  end
  
  
  #populate an array with categories
  def mycats
    @mycats = {
      'Film/video' => 'film', 
      'Music' => 'music', 
      'Writing/publishing' => 'publi', 
      'Art' => 'art', 
      'Photography' => 'photo',
      'Dance' => 'dance',
      'Comic' => 'comic', 
      'Game' => 'game',
      'Fashion' => 'fashion',
      'Technology' => 'tech'
    }
  end


  #populate an array with categories
  def myskills
    @myskills = {      
      '插画师/平面设计师' => 'graphist',
      '摄影师' => 'photograph',
      '音乐人/乐队/乐手' => 'musician',
      '动画师' => 'animator',
      '独立导演' => 'director',
      '交互设计师/多媒体艺术' => 'multimedia',
      '服装设计师' => 'fashioner',
      '工业设计师/产品设计师' => 'producter',
      '传统艺术（当代艺术）' => 'artist',
      '街头艺术' => 'streeter'
    }
  end
  
  #populate an array with categories
  def mytypes
    @mytypes = {      
      '媒体' => 'media',
      '品牌' => 'brand',
      '工作室' => 'studio',
      '中介' => 'agency',
      '其他' => 'others'
    }
  end
  
  
end
