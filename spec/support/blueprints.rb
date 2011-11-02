require 'machinist/active_record'

Post.blueprint do
  title { "Post #{sn}" }
  body_markdown { "Lorem ipsum dolor sit amet #{sn}..." }
  published { true }
end
