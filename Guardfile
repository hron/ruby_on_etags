guard 'ego' do
  watch('Guardfile')
end

guard 'rspec', :cli => "--format nested", :notification => false do
  watch(%r{^spec/.+_spec\.rb})
  watch(%r{^lib/(.+)\.rb})     { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb') { "spec" }
end

guard 'cucumber', do
  watch(%r{features/.+\.feature}) do |m|
    ENV['CUCUMBER_FORMAT'] = 'pretty'
    m[0]
  end

  watch(%r{features/support/.+})          { 'features' }
  watch(%r{features/step_definitions/.+}) { 'features' }
end

guard 'bundler' do
  watch('Gemfile')
  watch(/^.+\.gemspec/)
end
