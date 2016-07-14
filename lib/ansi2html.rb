require 'sinatra'
require 'sinatra/reloader' if development?

require 'terminal'

post '/render' do
  content = params[:content]

  erb :render, locals: {
    output: Terminal.render(content)
  }
end
