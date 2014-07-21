#!/usr/bin/perl -w
# $Rev: 1 $
# $Application: Getty Connect $
# $Date: 2012-02-21 $
#
# Requires Json
#

use strict;
use warnings;
use JSON;
use CGI;
use LWP::UserAgent;

#set params
my $token = "token"; 
my $downloadToken = ""; 
my $url = "https://connect.gettyimages.com/v1/download/CreateDownloadRequest";

# create array of data for request
my $json_data = {
	"RequestHeader" => {
		"CoordinationId" => "",
		"Token" => $token
	},
	"GetImageDownloadAuthorizationsRequestBody"  =>
	  {"CreateDownloadRequestBody" => 
	  	{"DownloadItems" =>
	  		{"DownloadToken" => $downloadToken}
	  	}
	  }
};

#encode data to json
$json_data = encode_json $json_data;

# set method to POST
my $req = HTTP::Request->new(POST => $url);
$req->content_type('application/json');
$req->content($json_data);

# dispatch request, returns
my $ua = LWP::UserAgent->new;
my $response = $ua->request($req);

#decode data to json
$response = decode_json $response->content;

#print response
print($response."\n");

