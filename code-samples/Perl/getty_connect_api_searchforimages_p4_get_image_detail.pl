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
my $token      = "token";
my @imageArray = "imageIDArray";
my $url        = "http://connect.gettyimages.com/v1/search/GetImageDetails";

# create array of data for request
my $json_data = {
	"RequestHeader" => { 
		"Token" => $token, 
		"CoordinationId" => "" 
	},
	"GetImageDetailsRequestBody" => { 
		"ImageIds" => [@imageArray] 
	}
};

#encode data to json
$json_data = encode_json $json_data;


# post set post request
my $req = HTTP::Request->new( POST => $url );
$req->content_type('application/json');
$req->content($json_data);

# send request
my $ua   = LWP::UserAgent->new;
my $response = $ua->request($req);

#decode data to json
$response  = decode_json $response->content;

#print response
print( $response. "\n" );



#print response
print($response."\n");

