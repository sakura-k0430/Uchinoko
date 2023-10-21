module Public::FosterParentsHelper
  def render_with_foster_parent_hashtags(body)
    body.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/foster_parent/foster_parent_hashtag/#{word.delete("#")}"}.html_safe
  end
end
