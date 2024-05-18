from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()

class Tweet(db.Model):
    __tablename__ = 'Tweets'
    t_ID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    Name = db.Column(db.String)
    Username = db.Column(db.String)
    Timestamp = db.Column(db.DateTime)
    Verified = db.Column(db.Boolean, default=False)
    Content = db.Column(db.String)
    Comments = db.Column(db.String)
    Retweets = db.Column(db.String)
    Likes = db.Column(db.String)
    Analytics = db.Column(db.String)
    Tags = db.Column(db.String)
    Mentions = db.Column(db.String)
    Emojis = db.Column(db.String)
    Profile_Image = db.Column(db.String, name="Profile Image")  # Corrected column name
    Tweet_Link = db.Column(db.String, name="Tweet Link")  # Corrected column name
    Tweet_Image = db.Column(db.String, name="Tweet Image")

class Hashtag(db.Model):
    __tablename__ = 'Hashtags'
    h_ID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    Username = db.Column(db.String)
    Content = db.Column(db.String)
    Tweet_Image = db.Column(db.String, name="Tweet Image")
    

class Tag(db.Model):
    __tablename__ = 'Tag'
    tag_ID = db.Column(db.Integer, primary_key=True)
    t_ID = db.Column(db.Integer, db.ForeignKey('Tweets.t_ID'))
    h_ID = db.Column(db.Integer, db.ForeignKey('Hashtags.h_ID'))

    tweet = db.relationship('Tweet', backref=db.backref('tags', lazy=True))
    hashtag = db.relationship('Hashtag', backref=db.backref('tags', lazy=True))
    def __repr__(self):
        return f"<Tag id={self.tag_ID}, t_ID={self.t_ID}, h_ID={self.h_ID}>"
    
class Community(db.Model):
    __tablename__ = 'Community'
    c_ID = db.Column(db.Integer, primary_key=True, autoincrement=True)
    Name = db.Column(db.String)
    Username = db.Column(db.String)
