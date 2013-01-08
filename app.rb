require 'sinatra'
require 'sass'
require 'yaml'
require 'hashie'

set :views, :sass => 'views/sass', :haml => 'views', :default => 'views'

helpers do # http://www.sinatrarb.com/intro#Looking%20Up%20Template%20Files
  def find_template(views, name, engine, &block)
    _, folder = views.detect { |k,v| engine == Tilt[k] }
    folder ||= views[:default]
    super(folder, name, engine, &block)
  end
end

get '/styles.css' do
  content_type 'text/css', :charset => 'utf-8'
  sass :styles
end

get '/' do
  @title = "hello"
  @beers = Hashie::Mash.new(YAML.load_file('data/beer.yml'))
  haml :index
end

get '/*' do
  redirect to('/')
end