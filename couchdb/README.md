dockerfiles-fedora-couchdb
========================

Fedora dockerfile for couchdb

Tested on Docker 0.7.0

To build:

Over the net via git -


# docker build -rm -t <username>/couchdb git://github.com/scollier/dockerfiles-fedora-couchdb.git


or

Copy the sources down -


# docker build -rm -t <username>/couchdb .



To run:


# docker run -d -p 5984:5984 <username>/couchdb


Test:


# curl -X PUT http://localhost:5984/test/
{"error":"file_exists","reason":"The database could not be created, the file already exists."}

# curl -X GET http://localhost:5984/test/
{"db_name":"test","doc_count":0,"doc_del_count":0,"update_seq":0,"purge_seq":0,"compact_running":false,"disk_size":79,"data_size":0,"instance_start_time":"1387384723608413"}


