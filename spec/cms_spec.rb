require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe 'Capistrano TYPO3 CMS main module' do

	before do
		@configuration = Capistrano::Configuration.new
		@configuration.extend(Capistrano::Spec::ConfigurationExtension)

		# Common parameters
		@configuration.set :application, 'testapp'
		#@configuration.set :latest_release,          '/var/www/releases/20120927'
		#@configuration.set :shared_path,             '/var/www/shared'
		#@configuration.set :maintenance_basename,    'maintenance'
		#@configuration.set :try_sudo,                ''
		#@configuration.set :interactive_mode,        false

		Capistrano::Typo3::Cms.load_into(@configuration)
	end

	subject { @configuration }

	it 'Defines TYPO3 CMS version' do
		@configuration.fetch(:version_typo3cms).should == nil
	end

	it 'Defines enviroment variables' do
		@configuration.fetch(:env_development).should == 'development'
		@configuration.fetch(:env_staging).should == 'staging'
		@configuration.fetch(:env_production).should == 'production'
		@configuration.fetch(:env_default).should == 'staging'
	end

	it 'Defines system variables' do
		@configuration.fetch(:php_bin).should == 'php'
	end

	it 'Defines directory path variables' do
		@configuration.fetch(:deploy_to).should == '/var/www/testapp/deploy'
		@configuration.fetch(:dir_source).should == 'src'
		@configuration.fetch(:dir_deploy).should == 'deploy'
	end

	it 'Defines directory source path variables' do
		@configuration.fetch(:dir_htdocs).should == 'src/htdocs'
		@configuration.fetch(:dir_fileadmin).should == 'src/htdocs/fileadmin'
		@configuration.fetch(:dir_uploads).should == 'src/htdocs/uploads'
		@configuration.fetch(:dir_vendor).should == 'src/vendor'
	end

	context 'When setting up other directories settings' do
		before do
			@configuration.set :dir_source, '/volumes/s2'
			@configuration.set :dir_deploy, '/volumes/s2/deploy'
			@configuration.set :dir_htdocs, '/volumes/s2/htdocs'
			@configuration.set :dir_fileadmin, '/volumes/s2/htdocs/fileadmin'
			@configuration.set :dir_uploads, '/volumes/s2/htdocs/uploads'
			@configuration.set :dir_vendor, '/volumes/s2/vendor'
		end

		it 'Defined globals variables can be overridden' do
			@configuration.fetch(:dir_source).should == '/volumes/s2'
			@configuration.fetch(:dir_deploy).should == '/volumes/s2/deploy'
			@configuration.fetch(:dir_htdocs).should == '/volumes/s2/htdocs'
			@configuration.fetch(:dir_fileadmin).should == '/volumes/s2/htdocs/fileadmin'
			@configuration.fetch(:dir_uploads).should == '/volumes/s2/htdocs/uploads'
			@configuration.fetch(:dir_vendor).should == '/volumes/s2/vendor'
		end
	end
end