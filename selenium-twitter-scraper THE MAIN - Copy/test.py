

data = {
    'Content': ['hello #cat here we #go', 'test #project etc'],
    'Tags' : []
}


hashtags = []
for tweet in data['Content']:
    current = ''
    for word in tweet.split(' '):
        if word.startswith('#') :
            current = current + word + " "

    hashtags.append(current.strip())


data['Tags']= hashtags

print(data)