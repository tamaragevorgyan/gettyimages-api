## Pagination ##

The Connect API provides an abundance of information about the images found that match your search.  Sometimes, even most of the time, you will find you are asking for *too much* information, and to keep our servers (and your applications) happy, the Connect API will automatically paginate your search results.  

- The Connect API will return your results in groups called ***pages***.
- The number of items in a page is its ***page size***.
- By default, Search uses a page size of 30 items per page.
- The ***last*** page returned to you may be as few as one item or as many ***page size*** items.    You will never receive more than *page size* items in any page.
- You may specify how many items you receive in a page 

 