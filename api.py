from flask import Flask, render_template
 
app = Flask(__name__)
 
@app.route("/image")
def home():
    return render_template('image.html')

if __name__ == '__main__':
    app.debug = True
    app.run(port=5000, host='0.0.0.0')