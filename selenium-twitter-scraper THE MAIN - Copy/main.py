#IMPORTANT
#When you want to enter the max tweets enter  form 1 to 3 so the user the scrapper is using doesn't get banned.!!!!!!!!!!

# uvicorn main:app --reload
# http://127.0.0.1:8000/docs

#steps
# install anaconda or conda
# conda create -n isd python=3.10
# open a terminal
# conda activate isd
# pip install "fastapi[all]"
# pip install "uvicorn[standard]"
# pip install -r requirements.txt
# uvicorn main:app --reload
# http://127.0.0.1:8000/docs


from typing import Union
from fastapi import FastAPI, HTTPException
from sqlalchemy import create_engine, types
import os
import sys
import pandas as pd
import urllib
import pyodbc
import json
from dotenv import load_dotenv
sys.path.append('scraper/')
from scraper.twitter_scraper import Twitter_Scraper 

load_dotenv()
USER_UNAME = os.environ['TWITTER_USERNAME']
USER_PASSWORD = os.environ['TWITTER_PASSWORD']

sqlalchemy_url = "mssql+pyodbc:///?odbc_connect=" + urllib.parse.quote_plus("DRIVER={ODBC Driver 17 for SQL Server};SERVER=DESKTOP-INL8SD9\SQLEXPRESS;DATABASE=Tweetsdb;Trusted_Connection=yes")


scraper = Twitter_Scraper(
        username=USER_UNAME,
        password=USER_PASSWORD,
        # max_tweets=10,
        # scrape_username="something",
        # scrape_hashtag= hashtag,
        # scrape_query="something",
        # scrape_latest=False,
        # scrape_top=True,
        # scrape_poster_details=True
    )

scraper.login()

app = FastAPI()


@app.get("/hashtag_tweets")
def get_hashtag_tweets(hashtag: str, max_tweets:int):
    
    scraper.scrape_tweets(
        max_tweets=max_tweets,
        # scrape_username=username,
         scrape_hashtag= hashtag,
        # scrape_query= query,
         scrape_latest= True,
        # scrape_top=True,
        # scrape_poster_details=True,
    )

    data = {
                "Name": [tweet[0] for tweet in scraper.data],
                "Username": [tweet[1] for tweet in scraper.data],
                "Timestamp": [tweet[2] for tweet in scraper.data],
                "Verified": [tweet[3] for tweet in scraper.data],
                "Content": [tweet[4] for tweet in scraper.data],
                "Comments": [tweet[5] for tweet in scraper.data],
                "Retweets": [tweet[6] for tweet in scraper.data],
                "Likes": [tweet[7] for tweet in scraper.data],
                "Analytics": [tweet[8] for tweet in scraper.data],
               "Tags": [tweet[9] for tweet in scraper.data],
                "Mentions": [tweet[10] for tweet in scraper.data],
                "Emojis": [tweet[11] for tweet in scraper.data],
                "Profile Image": [tweet[12] for tweet in scraper.data],
                "Tweet Link": [tweet[13] for tweet in scraper.data],
                #"Tweet ID": [f"tweet_id:{tweet[14]}" for tweet in scraper.data],
                "Tweet Image": [tweet[14] for tweet in scraper.data],
            }

    

    hashtags = []
    for tweet in data['Content']:
        current = ''
        for word in tweet.split(' '):
            if word.startswith('#') :
                current = current + word + " "
        hashtags.append(current.strip())

    data['Tags'] = hashtags

    # Create a connection to the database
    engine = create_engine(sqlalchemy_url)
    conn = engine.connect()

        # Specify the data types for the columns
    dtype = {
    "Name": types.UnicodeText,
    "Username": types.String(length=255),
    "Timestamp": types.DateTime(),
    "Verified": types.Integer(),
    "Content": types.UnicodeText(),
    "Comments": types.UnicodeText(),
    "Retweets": types.UnicodeText(),
    "Likes": types.UnicodeText(),
    "Analytics": types.UnicodeText(),
    "Tags": types.UnicodeText(),
    "Mentions": types.UnicodeText(),
    "Emojis": types.UnicodeText(),
    "Profile Images": types.UnicodeText(),
    "Tweet Link": types.UnicodeText(),
    #"Tweet ID": types.String(length=255),
    "Tweet Image": types.UnicodeText(),
    }
    
    
    # Insert the data into the "Tweets" table
    df = pd.DataFrame(data)
    df.to_sql("Tweets", conn, if_exists="append", index=False, dtype=dtype)

        # Create a new table for hashtags
    hashtag_dtype = {
        "HashtagID": types.Integer(),
        "Username": types.String(length=255),
        "Content": types.UnicodeText(),
        "Tweet Image": types.UnicodeText(),
    }
    hashtag_df = pd.DataFrame({"Username": data["Username"], "Content": hashtags, "Tweet Image": data["Tweet Image"]})
    hashtag_df.to_sql("Hashtags", conn, if_exists="append", index=False, dtype=hashtag_dtype)

    # Close the database connection
    conn.close()
    engine.dispose()
    # print(data)

    return data
@app.post("/search_tweets")
def search_tweets(query: str):
    max_tweets = 2

    scraper.scrape_tweets(
        max_tweets=max_tweets,
        scrape_query=query,
        scrape_latest=True,
    )

    if not scraper.data:
        raise HTTPException(status_code=404, detail="No tweets found")

    tweets = []
    for tweet in scraper.data:
        tweet_data = {
            "Name": tweet[0],
            "Username": tweet[1],
            "Timestamp": tweet[2],
            "Verified": tweet[3],
            "Content": tweet[4],
            "Image_URL": tweet[5],
            "Comments": tweet[5],
            "Retweets": tweet[6],
            "Likes": tweet[7],
            "Analytics": tweet[8],
            "Tags": tweet[9],
            "Mentions": tweet[10],
            "Emojis": tweet[11],
            "Profile Image": tweet[12],
            "Tweet Link": tweet[13],
            #"Tweet ID": f"tweet_id:{tweet[14]}",
            "Tweet Image": tweet[14],
        }
        tweets.append(tweet_data)

    return json.dumps(tweets)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
