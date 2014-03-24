import web

urls = (
  '/', 'index'
)

class index:
    def GET(self):
        return "Hello world!"

if __name__ == "__main__": 
    app = web.application(urls, globals())
    app.run() 
