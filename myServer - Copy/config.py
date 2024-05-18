import os

basedir = os.path.abspath(os.path.dirname(__file__))
#badek tghyri esm l @DESKTOP-INL8SD9\\SQLEXPRESS lal esem taba3 l server name tb3k 
class Config:
    SQLALCHEMY_DATABASE_URI = 'mssql+pyodbc://@DESKTOP-INL8SD9\\SQLEXPRESS/Tweetsdb?driver=ODBC+Driver+17+for+SQL+Server&Trusted_Connection=yes'
    SQLALCHEMY_TRACK_MODIFICATIONS = False
