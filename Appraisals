%w(3.2 4.0 4.1 4.2).each do |version|
  appraise "rails.#{version}" do
    gem 'activesupport', "~> #{version}.0"
    gem 'activemodel', "~> #{version}.0"
    gem 'activerecord', "~> #{version}.0"
  end
end
