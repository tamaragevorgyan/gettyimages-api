Single Step Download
-------------------------------------
The single step download call returns a redirect to download the largest image available. 
This end point currently does not support image pack or royalty free subscriptions.

###Download Limits
Most product offerings have enforced periodic download limits such as monthly, 
weekly, and daily. When this operation executes, the count of allowed downloads is 
decremented by one. Once the download limit is reached, no further downloads 
may be requested until the next download period.

The download limit for a given download period is covered in your product 
agreement established with Getty Images.


###Endpoint
Use the following endpoint (HTTPS only) to access this operation:

  https://connect.gettyimages.com/v2/download

###Request
  POST https://connect.gettyimages.com/v2/download/{ImageId}

####HTTP Headers
| Name               | Value              | Use      | 
|:-------------------|:-------------------|:---------|
| Authorization      | Bearer AccessToken | Required |
| GI-Coordination-Id | CoordinationId     | Optional |

###Response
| HTTP Status   | Type    | Description                                         |
|:--------------|:--------|:----------------------------------------------------|
| 302           | Success | Redirects to download URI                           |
| 403           | Error   | Product offering can not be used with this resource |
| 403           | Error   | No product offering found                           |
| 404           | Error   | Image not found                                     |
| 404           | Error   | No authorizations were found for the asset          |

####HTTP Headers
| Name               | Value              |  
|:-------------------|:-------------------|
| Location           | download URI       |
| GI-Coordination-Id | CoordinationId     |