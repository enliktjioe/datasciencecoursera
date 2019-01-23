## Accessing Twitter from R
myapp = oauth_app("twitter",
                    key = "dHwVYzoehTMjpxHQStu48g", 
                    secret = "KO96Shze0cSd7RDFToyW5z054fhKFQgPZgZBr5yC44I")
sig = sign_oauth1.0(myapp,
                      token = "70602408-lIPXob7ct9ESG3Bmpslqkhe0ycfuoL9vJaedja5ti",
                      token_secret = "GV6UQvIVSpqMy5In5OyFjm82lX70AQlg4Mnd9Rq38DOI8")
homeTL = GET("https://api.twitter.com/1.0/statutes/home_timeline.json", sig)

## Converting the json object
json1 = content(homeTL)
json2 = jsonlite::fromJSON(toJSON(json1))
json2[1, 1:4]