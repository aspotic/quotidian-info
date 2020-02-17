#!/usr/bin/env python

from collections import namedtuple

# The name of the default CSS style
style = "default"

# The file name for the default template
base = "base.html"

# The standard number of entries to pull from the data store at one time
request_size = 20

# Default sub categories for website catagories
default_software = "android"
default_graphicArt = "photography"


# Meta Data Tag Objects
HTMLMetaData = namedtuple('HTMLMetaData', 'description keywords top3Keywords')

metaData_Admin       = HTMLMetaData(
                                        '',
                                        '',
                                        '',
                                    )

metaData_Bio         = HTMLMetaData(
                                        'Quotidian.Info is the central storage location for much of what I have built, designed, or developed.',
                                        'quotidian,info,adam,profile,bio,biography,portrait,image,self,life',
                                        'adam,profile,bio',
                                    )

metaData_GraphicArt  = HTMLMetaData(
                                        'My favorite work produced through the persuit of my many graphic art hobbies.',
                                        'photography,drawings,drafting,portraits,pencil,websites,adamk9,breadway,bull,canola,saskatchewan,canada',
                                        'photography,drawings,drafting',
                                    )

metaData_Software    = HTMLMetaData(
                                        'The software projects I have done on my own time and for University.',
                                        'software,development,dev,java,android,c,csharp,sharp,c#,c++,cpp,mosync,.net,web,developer,physics,math,science,download,calorie,alarm,easy,password,product,finder',
                                        'software,android,java'
                                    )



