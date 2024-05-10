# Procfs2

Browse /proc fs on Linux.

This is a draft version.


## Installation

Manual install, with:

    $ gem install procfs2

Add to Gemfile with:

    $ bundle add procfs2


## Usage

This is a draft version.

It may change or not.

Comments / PR welcome !

Example of usage:

``` ruby
@p = Procfs2.proc

puts @p
puts @p.version._path
puts @p.version._raw_content
puts @p.version.version
puts @p.version.timestamp

puts @p.pid('self').fd._path
puts @p.pid('self').fd.id(0)

puts @p.pid(1091714).fd.id(3).type
puts @p.pid(1091714).fd.select { |fd| fd.type == 'socket' }
puts @p.pid(1091714).fd.select { |fd| fd.type == 'socket' }.map { |fd| fd.inode }

puts @p.net.tcp.by_inode(2235042).id
puts @p.net.tcp.by_inode(2235042).remote_address
puts @p.net.tcp.by_inode(2235042).remote_port
puts @p.net.tcp.by_inode(2235042).state_str
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/procfs2.


## References

- https://www.kernel.org/doc/html/latest/filesystems/proc.html


## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
