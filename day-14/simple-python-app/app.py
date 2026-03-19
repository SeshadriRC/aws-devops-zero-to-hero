from flask import Flask

app = Flask(__name__)

@app.route('/')
def hello():
    return 'Hello, world! This is my second application-created new codebuild. removed base directory line from buildspec'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
