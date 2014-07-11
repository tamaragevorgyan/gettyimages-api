## Pagination ##

The Connect API provides an abundance of information about the images found that match your search.  Sometimes, even most of the time, you will find you are asking for *too much* information, and to keep our servers (and your applications) happy, the Connect API will automatically paginate your search results.  

- The Connect API will return your results in groups called ***pages***.
- The number of items in a page is its ***page size***.
- You may specify how many items you receive in a page using the ***page-size*** query parameter.  By default, Search uses a page size of 30 items per page.  The maximum number of items per page is 100.
- You should specify the desired page number on each search.  If omitted, page will default to 1, returning the same  ***page-size*** results on each call.
- The ***last*** page returned to you may be as few as one item or as many ***page size*** items.    You will never receive more than *page size* items in any page.

The following example shows how to add a page and page-size query parameter to your search request using curl:

    C:\>curl -I "https://connect.gettyimages.com/v3/search/images?phrase=vampire0cows&page=1&page-size=20"   -H "Api-Key:x2xx9xx74x69xxxxx6xxx3xx"   -H "Authorization:Bearer XXX.....XXX"

Please note: the authorization token has been reduced in size.
