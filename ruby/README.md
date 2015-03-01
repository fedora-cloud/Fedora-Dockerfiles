fedora-cloud ruby Dockerfile
============================

Try out a simple build:

```
$ sudo docker build -t <username>/ruby .
..
..
Complete!
Cleaning repos: fedora updates
Cleaning up everything
 ---> 5fbcdaa353c5
Removing intermediate container cda594a8b622
Successfully built 5fbcdaa353c5
```

Now launch an interactive ruby shell:

``` ruby
$ sudo docker run -it <username>/ruby irb
irb(main):001:0> 2 + 3
=> 5
```

