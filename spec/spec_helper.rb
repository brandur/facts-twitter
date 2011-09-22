$: << File.expand_path('lib')

require 'facts'

# Alternate version of #mock that yields to a given block in which the newly 
# created mock can be configured.
def mockb(*args, &block)
  obj = mock(args)
  yield obj if block_given?
  obj
end
