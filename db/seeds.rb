# encoding: utf-8

require 'open-uri'

types = %w{astronomy physics philosophy}

25.times do
  doc = Nokogiri::HTML(open("http://referats.yandex.ru/#{types.sample}.xml"))
  h1 = doc.at_css("h1")

  Post.create! do |post|
    puts post.title = h1.content.match(/Тема: «(.+)»/)[1]
    post.published = [true, false].sample
    post.created_at = rand(30).days.ago + rand(10**5).seconds
    post.updated_at = post.created_at + rand(Time.now - post.created_at).seconds if post.published
    post.text = h1.parent.css('p').map(&:content).join("\n\n")
  end
end
