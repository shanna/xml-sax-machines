# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{xml-sax-machines}
  s.version = "0.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Shane Hanna"]
  s.date = %q{2009-03-21}
  s.description = %q{XML SAX Machines}
  s.email = %q{shane.hanna@gmail.com}
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.files = ["VERSION.yml", "README.rdoc", "lib/xml-sax-machines", "lib/xml-sax-machines/filter.rb", "lib/xml-sax-machines/debug.rb", "lib/xml-sax-machines/pipeline.rb", "lib/xml-sax-machines/builder.rb", "lib/xml-sax-machines/fragment_builder.rb", "lib/xml-sax-machines.rb", "test/pipeline_test.rb", "test/filter_test.rb", "test/builder_test.rb", "test/test_helper.rb", "test/debug_test.rb", "test/fragment_builder_test.rb", "LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/shanna/xml-sax-machines}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{Assorted XML SAX readers, filters and writers.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<nokogiri>, ["~> 1.2.2"])
    else
      s.add_dependency(%q<nokogiri>, ["~> 1.2.2"])
    end
  else
    s.add_dependency(%q<nokogiri>, ["~> 1.2.2"])
  end
end
