## HTML parsing
con = url("http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en")
htmlCode = readLines(con)
close(con)
htmlCode

## GET from the httr package
url <- "http://scholar.google.com/citations?user=HI-I6C0AAAAJ&hl=en"
library(httr); html2 = GET(url)
content2 = content(html2, as = "text")
parsedHtml = htmlParse(content2, asText = TRUE)
xpathSApply(parsedHtml, "//title", xmlValue)

## Accessing websites with passwords
pg2 = GET("http://httpbin.org/basic-auth/user/passwd",
          authenticate("user", "passwd"))
pg2
names(pg2)






