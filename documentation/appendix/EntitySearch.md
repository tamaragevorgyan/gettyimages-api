Searching for Specific People or Other Entities
===============================================
Connect offers several ways to find specific entities--people, sports teams and musical groups. You can search for entities using keywords in the SearchPhrase parameter (such as the name of a person or group, plus related concepts such as "headshot" or "red carpet"). You can also use various search filters (such as specifying "Editorial" under ImageFamilies or specifying "MostPopular" or "Trending" under EditorialSortOrder).

Beginning in December 2013, Connect released a beta for a new query parameter to automatically retrieve accurate, targeted and unambiguous search results by searching with exact entity IDs rather than keywords. This functionality ties in to the expanding <a href="http://lod-cloud.net/">Linked Open Data community</a> of metadata using the common language of Uniform Resource Identifiers (URIs).

###Linked Data Sources
We've linked more than 60,000 individuals to the metadata in the following external data sources:
*	DBPedia
*	Freebase
*	MusicBrainz

We continually review search trends and add names to our named persons list as people become well-known or frequently searched for.

###Tell Me How
You can specify the Linked Data URI in the EntityUris query parameter of our Search operations (SearchForImages and SearchForVideos).

If you aren't already mapping to a linked data source and referencing linked data URIs, you can obtain the URI as follow:

| Data Source | How to Build Your URI | Example URIs |
|:------------|:----------------------|:-------------|
| DBPedia | Search for the entity at <a href="http://en.wikipedia.org">http://en.wikipedia.org</a>, and then append the named suffix to <a href="http://dbpedia.org/resource/">http://dbpedia.org/resource/</a>. | <a href="http://dbpedia.org/resource/Robert_Smith_(musician)">http://dbpedia.org/resource/Robert_Smith_(musician)</a> <br/> <a href="http://dbpedia.org/resource/Beyoncé_Knowles">http://dbpedia.org/resource/Beyoncé_Knowles</a> |
| Freebase | Search for the entity at <a href="http://www.freebase.com/">http://www.freebase.com/</a>. | <a href="http://rdf.freebase.com/ns/m.01tp5bj">http://rdf.freebase.com/ns/m.01tp5bj</a> <br/> <a href="http://rdf.freebase.com/ns/m.01mpq7s">http://rdf.freebase.com/ns/m.01mpq7s</a> |
| MusicBrainz | Search for the entity at <a href="http://musicbrainz.org/">http://musicbrainz.org/</a>. | <a href="http://musicbrainz.org/artist/7d1a1624-784b-4f89-8ff9-b9b493cd059d ">http://musicbrainz.org/artist/7d1a1624-784b-4f89-8ff9-b9b493cd059d </a> <br/> <a href="http://musicbrainz.org/artist/859d0860-d480-4efd-970c-c05d5f1776b8">http://musicbrainz.org/artist/859d0860-d480-4efd-970c-c05d5f1776b8</a> |

###Frequently Asked Questions
<b>What if the entity URI I'm searching for isn't among the 60,000 people you've mapped?</b>
In this case, Connect will return the UriResolutionFailed status code. We recommend that you remove the URI from query parameter and try a free text keyword search (using the SearchPhrase query parameter). If you use this workaround, be sure to also set the ImageFamilies filter to "Editorial" and the EditorialSortOrder filter to "MostPopular" or "Trending" to get the most relevant images first in your results.

<b>What if the entity is not a person, such as a sports team, band, movie or event?</b>
We plan to expand this service and link to different types of entities over time, so be sure to let us know what you'd like to see next!

<b>Why am I getting an error about an invalid entity URI?</b>
Connect will return the InvalidEntityUri status code when one or more of the URIs you provided is malformed. You can refer to the details in the informational status codes that follow in the response. For example, Connect will reference one of the following status codes after InvalidEntityUri:

* IncorrectlyFormedDbpediaURI: Issue in the root of the DBpedia URI
* IncorrectlyFormedFreebaseURI: Issue in the root of the Freebase URI
* IncorrectlyFormedMusicbrainzURI: Issue in the root of the MusicBrainz URI
* IncorrectlyFormedURI: Issue in the suffix of the URI (where the entity reference appears)

Refer to the table in the "Tell Me How" section for how to properly format each URI.

<b>What should I do when I get the error entity search failure?</b>
Connect will return the EntitySearchFail status code if there's a failure with our internal entity mapping systems. You can try your request in a few minutes. If you continue to receive this error, please contact our <a href="http://api.gettyimages.com/forum/read/161199">Network Operations Center and note that you're experiencing issues with our Taxonomy Service on Connect.

<b>Why am I getting the error unknown provider URI?</b>
Connect will return the UnknownProviderUri status code if the entity URI is from a data source other than those we have linked to. If you rely on a particular data source for your business, be sure to let us know so that we can review our providers and consider it for the future.

<b>How do I get images of just that person or otherwise refine the results?</b>
You have a few options to work with. We recommend using a combination of EditorialSortOrder and SearchPhrase query parameter. For example:

* Set the ImageFamilies filter to "Editorial."
* Set the EditorialSortOrder filter to "MostPopular" or "Trending." (Note that you'll need to set ImageFamilies to "Editorial" to use this filter.)
* Add "one person" in the SearchPhrase query parameter to get results for just that person.
* Add keywords in the SearchPhrase query parameter such as "headshot," "head and shoulders," or "waist up" to tailor your results to images that show a close-up of the entity.

If you have any questions about your specific use case, let us know so that we can provide other input.
