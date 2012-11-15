Appendix A: Status Codes
------------------------
The Status codes are:

| Field 						| Description 																							|
|:------------------------------|:------------------------------------------------------------------------------------------------------|
| AlternativeAgreement			| Indicates that an alternative qualifying agreement was used for download authorization.				|
| AssetIdListExceedsMaxAllowed	| Indicates that the quantity of asset ids specified in the request exceeds the maximum allowed of 500.	|
| AssetNotAvailable				| Indicates that one or more of the assets specified is not available.									|
| AUTH-002                      | Indicates that the request must be made over a secure transport (e.g. SSL). 							|
| AUTH-023                      | Indicates that only a secure token can be used with the requested operation. 							|
| AUTH-014                      | Indicates that the requested operation does not allow a secure token with http.						|
| DefaultLanguageUsed			| Indicates that the request specifies an unsupported or missing language. Using language 'en-us'. 		|
| DateCreatedRangeNotApplicable	| Indicates that DateCreatedRange can only be used with the editorial or default image family.			|
| DependentServiceDown          | Indicates that a dependent system is unreachable.                                                     |
| DuplicateUsername				| Indicates that the username is already in use.														|
| EventNotFound					| Indicates that one or more of the requested events could not be found.								|
| ExpiredDownloadToken			| Indicates that the download token has expired.														|
| FailedToCreateCustomer		| Indicates that the customer was not created. 															|
| FailedToGetDownloadUrl		| Indicates that a download URL could not be gotten for the asset, size, and agreement specified.		|
| FailedToRenewToken			| Indicates that the system security token was unable to be renewed.									| 
| ImageNotFound					| Indicates that the image does not exist; usually due to an incorrectly specified image id.			|
| InternalError					| Indicates an internal error.																			|
| InvalidAssets				    | Indicates that there are invalid asset id(s) in the request.											|
| InvalidCollectionId			| Indicates that the collection id specified is not valid.												|
| InvalidEditorialSegment		| Indicates that the editorial segment specified is not valid.											|
| InvalidEditorialSourceId		| Indicates that the editorial source id specified is not valid.										|
| InvalidEventSortType			| Indicates that the event sort type is not available.													|
| InvalidDownloadToken			| Indicates that the download token is not in a valid format.                             				|
| InvalidIncludeExcludeMode		| Indicates that the IncludeExcludeMode specified is not valid. 										|
| InvalidItemCount				| Indicates that the item count must be greater than zero. 												|
| InvalidItemStartNumber		| Indicates that the item start number must be greater than zero.										|
| InvalidLanguageCode			| Indicates that the specified language is unrecognized.												|
| InvalidLightboxName			| Indicates that the LightboxName cannot be null or empty.												|
| InvalidOrientation			| Indicates that the orientation specified is not valid. 												|
| InvalidProductOffering		| Indicates that the specified product offering is not valid.     										|
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
| LightboxIdDoesNotExist		| Indicates that the specified lightbox id does not exist.												|
| MaxExceeded					| Indicates the specified item count exceeds the maximum allowed.										|
| MissingEventIds				| Indicates	the request is missing an event id.															|
| MissingImageId				| Indicates	the request is missing an image id.															|
| MissingSizeKey				| Indicates the request is missing a size key.															|
| NoAgreement					| Indicates that the user has no active agreement.														|
| NoAuthorizations				| Indicates that no authorizations were found for one or more assets.									|
| NoImages						| Indicates that no images were found that match the specified query and possibly filters.				|
| NonExistingCollectionId		| Indicates that the requested collection id does not exist.											|
| NoVideos						| Indicates that no videos were found that match the specified query.									|
| OperationValidOnlyForLightboxOwner| Indicates that this operation is valid only for the lightbox owner.								|
| PasswordTooShort				| Indicates that the password length is less than 3 characters.											|
| StartPastTotal				| Indicates that the specified item start number is beyond the total available items.					|
| SystemError					| Indicates an unknown error.																			|
| TransactionIdDuplicate		| Indicates that a usage report with the provided transaction id has already been successfully recorded.|
| UnauthorizedProductOffering	| Indicates that the active download agreement does not authorize the requested product offerings. 		|
| UnauthorizedToReportUsage     | Indicates that the user is not authorized to report usage.											|
| UsernameEqualsPassword		| Indicates that the password matches the username. Username and password can't be the same. 			|
