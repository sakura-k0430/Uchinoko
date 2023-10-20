module Public::LostPetsHelper
  def render_with_hashtags(body)
    body.gsub(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/){|word| link_to word, "/lost_pet/lost_pet_hashtag/#{word.delete("#")}"}.html_safe
  end
end
