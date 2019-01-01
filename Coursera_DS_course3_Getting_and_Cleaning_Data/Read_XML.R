library(XML)
fileUrl <- "http://www.w3schools.com/xml/simple.xml"
doc <- xmlTreeParse(fileUrl, useInternal = TRUE) ## still error
## Unknown IO error2: failed to load external entity "http://www.w3schools.com/xml/simple.xml"

rootNode <- xmlRoot(doc)
xmlName(rootNode)

##########
fileUrl <- "http://espn.go.com/nfl/team/_/name/bal?baltimore_ravens"
doc <- htmlTreeParse(fileUrl, useInternal = TRUE)
scores <- xpathSApply(doc, "//li[@class='score']", xmlValue)
teams <- xpathSApply(doc, "//li[@class='team-name']", xmlValue)
scores