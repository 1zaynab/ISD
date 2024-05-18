#python app.py

#http://127.0.0.1:5000/tweets
#http://127.0.0.1:5000/hashtags
#http://127.0.0.1:5000/tags
#http://127.0.0.1:5000/community


from flask import Flask, jsonify
from models import db, Tweet, Hashtag, Tag, Community

from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# Configuration for connecting to the SQL Server database with Windows authentication
app.config['SQLALCHEMY_DATABASE_URI'] = (
    'mssql+pyodbc://@DESKTOP-INL8SD9\\SQLEXPRESS/Tweetsdb?driver=ODBC+Driver+17+for+SQL+Server&Trusted_Connection=yes'
)
db.init_app(app)


@app.route('/tweets', methods=['GET'])
def get_tweets():
    tweets = Tweet.query.all()
    tweets_list = [
        {
            "t_ID": tweet.t_ID,
            "Name": tweet.Name,
            "Username": tweet.Username,
            "Timestamp": tweet.Timestamp,
            "Verified": tweet.Verified,
            "Content": tweet.Content,
            "Comments": tweet.Comments,
            "Retweets": tweet.Retweets,
            "Likes": tweet.Likes,
            "Analytics": tweet.Analytics,
            "Tags": tweet.Tags,
            "Mentions": tweet.Mentions,
            "Emojis": tweet.Emojis,
            "Profile Image": tweet.Profile_Image,
            "Tweet Link": tweet.Tweet_Link,
            "Tweet Image": tweet.Tweet_Image,
        }
        for tweet in tweets
    ]
    return jsonify(tweets_list)

@app.route('/hashtags', methods=['GET'])
def get_hashtags():
    hashtags = Hashtag.query.all()
    hashtags_list = [
        {
            "h_ID": hashtag.h_ID,
            "Username": hashtag.Username,
            "Content": hashtag.Content,
            "Tweet Image":hashtag.Tweet_Image
        }
        for hashtag in hashtags
    ]
    return jsonify(hashtags_list)

@app.route('/tags', methods=['GET'])
def get_tags():
    tags = Tag.query.all()
    tags_list = [
        {
            "tag_ID": tag.tag_ID,
            "t_ID": tag.t_ID,
            "h_ID": tag.h_ID,
        }
        for tag in tags
    ]
    return jsonify(tags_list)

@app.route('/community', methods=['GET'])
def get_community():
    community = Community.query.all()
    community_list = [
        {
            "c_ID": member.c_ID,
            "Name": member.Name,
            "Username": member.Username,
        }
        for member in community
    ]
    return jsonify(community_list)


if __name__ == '__main__':
    with app.app_context():
        app.run(host='0.0.0.0', port=5000, debug=True)
