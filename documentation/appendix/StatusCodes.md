Appendix A: Status Codes
------------------------
The Status codes are:

| Field 						| Description 																							|
|:------------------------------|:------------------------------------------------------------------------------------------------------|
| DateCreatedRangeNotApplicable	| Indicates there is a DateCreatedRange but the editorial image family is not in scope of the query.	|
| InvalidRequest				| Indicates a problem with the request. See the message field for additional details about the problem.	|
| SystemError					| Indicates an unknown error.																			|
| InvalidSystemIdOrPassword		| Indicates that an invalid systemId or password was sent in.											|
| InvalidUsernameOrPassword		| Indicates that an invalid username or password was sent in.											|
| OperationRequiresHttps		| Indicates an error that the operation in use requires HTTPs.											|
| OperationRequiresSecureToken	| Indicates an error stating that this operation requires using a secure token. 						|
| SecureTokenPassedOverHttp		| Indicates an error stating that this operation does not allow a secure token with http.				|
| FailedToRenewToken			| Indicates that this Token is unable to be Renewed. Please call CreateSession to get a new token.		|
| DefaultLanguageUsed			| Indicates a warning for the user that the default language of 'en-us' was used because language was not specified. |
| InvalidLanguageCode			| Indicates that the specified language is not recognized.												|
| MaxExceeded					| Indicates the specified ItemCount exceeds the maximum allowed for the operation.						|
| StartPastTotal				| Indicates the specified ItemStartNumber is beyond the total available items.							|
| NoImages						| Indicates no images were found that match the specified Query and possibly Filters.					|
| NoVideos						| Indicates that no videos were found that match the specified Query and possibly Filters.				|
| ImageNotFound					| Indicates the image does not exist; usually due to an incorrectly specified ImageId.					|
| MissingImageId				| Indicates that the request is missing required ImageId.												|
| InvalidCollectionId			| Indicates that the CollectionId is not valid.															|																		
| NonExistingCollectionId		| Indicates that the CollectionId does not exist.														|
| InvalidSearchForVideoByAssetId | Indicates that the AssetId cannot be combined with other query parameters, because they will be ignored and only AssetId will be used. |
| AssetIdListExceedsMaxAllowed  | Indicates that the quantity of asset ids specified exceeds the maximum allowed of 500.				|
| CollectionModeEmpty			| Indicates that the Collection Mode cannot be empty if Collections is specified.						|
| CollectionIdsEmpty			| Indicates that Collection Ids cannot be empty if Collections is specified.							|
| InvalidLightboxName			| Indicates that the LightboxName cannot be null or empty.												|
| LightboxIdDoesNotExist		| Indicates that the Lightbox Id specified does not exist.												|
| LightboxesNotFound			| Indicates that no lightboxes were found.																|
| AssetNotAvailable				| Indicates that one or more of the Assets specified is not available.									|
| OperationValidOnlyForLightboxOwner | Indicates that the Operation is valid only for the Lightbox Owner.								|
| InvalidItemCount				| Indicates the ItemCount stated must be greater than 0.												|
| InvalidItemStartNumber		| Indicates the ItemStartNumber stated must be greater than 0.											|
| FailedToCreateCustomer		| Indicates that the attempt to create a customer failed.												|
| DuplicateUsername				| Indicates that the Username specified is a duplicate.													|
| PasswordTooShort				| Indicates that the minimum password length is 3 characters.											|
| UsernameEqualsPassword		| Indicates that the Username cannot be same as password.												|


