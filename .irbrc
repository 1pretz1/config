require 'rubygems'
require 'pp'

# copy variable, string etc to clipboard
def pbcopy(arg); IO.popen('pbcopy', 'w') { |io| io.puts arg.inspect }; end
