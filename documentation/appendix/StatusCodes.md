Appendix A: Status Codes
------------------------
The Status codes are:

| Field 						| Description 																							|
|:------------------------------|:------------------------------------------------------------------------------------------------------|
| DateCreatedRangeNotApplicable	| Indicates there is a DateCreatedRange but the editorial image family is not in scope of the query.	|
| ImageNotFound					| Indicates the image does not exist; usually due to an incorrectly specified ImageId.					|
| InvalidRequest				| Indicates a problem with the request. See the message field for additional details about the problem.	|
| MaxExceeded					| Indicates the specified ItemCount exceeds the maximum allowed for the operation.						|
| NoImages						| Indicates no images were found that match the specified Query and possibly Filters.					|
| StartPastTotal				| Indicates the specified ItemStartNumber is beyond the total available items.							|
| SystemError					| Indicates an unknown error.																			|

