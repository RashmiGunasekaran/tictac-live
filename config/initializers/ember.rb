EmberCli.configure do |c|
  c.app :frontend, path: Rails.root.join('frontend').to_s, build_timeout: 60
end
