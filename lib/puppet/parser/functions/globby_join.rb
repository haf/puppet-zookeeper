# https://projects.puppetlabs.com/issues/4248
module Puppet::Parser::Functions
  newfunction(:globby_join, :type => :rvalue, :doc => <<-DOC) do |*args|
    Get the matches based on glob pattern joined with separator.
  DOC

    if args[0].is_a? Array
        args = args[0]
    end

    raise(Puppet::ParseError, "globby_join(): Wrong number of arguments " +
          "given (#{args.size} for 2 expected); args: #{args.inspect}") if args.size != 2


    Dir.glob(args[0]).join(args[1])
  end
end
