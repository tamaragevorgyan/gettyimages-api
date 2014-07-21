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
my $searchPhrase = "tree";   
my $url = "http://connect.gettyimages.com/v1/search/SearchForImages";
my $itemCount = "25" ; 
my $filters = {"ImageFamily" => "creative"};

# create array of data for request
my $json_data = {
		"RequestHeader" => { 
			"Token" => $token,
			"CoordinationId" => "" 
		},
		"SearchForImages2RequestBody" => {
			"Query"         => { 
				"SearchPhrase" => $searchPhrase 
			},
			"Filter"        => { 
				"ImageFamily"  => $filters->{ImageFamily}
			},
			"ResultOptions" => {
				"IncludeKeywords" => "false",
				"ItemCount"       => $itemCount,
				"ItemStartNumber" => 25
			}
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









