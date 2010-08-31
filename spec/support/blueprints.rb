require 'machinist/active_record'

Post.blueprint do
  title { "Post #{sn}" }
  text { "Lorem ipsum dolor sit amet #{sn}..." }
  published { true }
end

