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

# set params
my $systemId       = "systemId";
my $systemPassword = "systemPassword";
my $coordinationId = "coordinationId"; 
my $oldtoken       = "token"; 
my $url = "http://connect.gettyimages.com/v1/session/RenewSession";

 	# create array of data for request
	my $json_data = {
		"RequestHeader" => { 
			"Token" => $oldtoken, 
			"CoordinationId" => ""
		},
		"RenewSessionRequestBody" => { 
			"SystemId" => $systemId, 
			"SystemPassword" => $systemPassword
		}
	};

#encode data to json
$json_data = encode_json $json_data;

# set method to POST
my $req = HTTP::Request->new( POST => $url );
$req->content_type('application/json');
$req->content($json_data);

# dispatch request, returns
my $ua   = LWP::UserAgent->new;
my $response = $ua->request($req);
$response  = $response->content;

#decode data to json
my $token = decode_json $response;

if ($response) {

	#retrieve normal token
	$token = $response->{RenewSessionResult}->{Token};

	#or retrieve secure token
	$token = $response->{RenewSessionResult}->{SecureToken};

}

#print token 
print( $token . "\n" );


