#!/usr/bin/perl -w

###	This .pl file is used for storing the lib sub-routine that	###
###	will be used in the assignment.                             ###

use DBI;	#use DataBase Interface
use CGI;
use CGI::Carp qw(warningsToBrowser fatalsToBrowser);
use strict;

###################################################
###	Setup connection to MySQL databast	###
###################################################

my $db_host = $ENV{"OPENSHIFT_MYSQL_DB_HOST"};
my $db_username = $ENV{"OPENSHIFT_MYSQL_DB_USERNAME"};
my $db_password = $ENV{"OPENSHIFT_MYSQL_DB_PASSWORD"};
my $db_name = $ENV{"OPENSHIFT_APP_NAME"};	#default database name is same as the application name, csci4140assig1

my $db_handler;	#GLOBAL VARIABLE

sub db_create()		#create a database if it does not exist
{
	$db_name = "haha";
	my $db_source = "DBI:mysql:;host=$db_host";
	$db_handler = DBI->connect($db_source, $db_username, $db_password) or die $DBI::errstr;
	$db_handler->do("CREATE DATABASE $db_name");
	$db_handler->disconnect() or die $DBI::errstr;
}

sub db_drop()		#drop the database
{
    $db_name = "haha";
	if($db_name eq "haha")	#exist a database
	{
		my $db_source = "DBI:mysql:$db_name;host=$db_host";
        $db_handler = DBI->connect($db_source, $db_username, $db_password) or die $DBI::errstr;
        $db_handler->do("DROP DATABASE $db_name");
        $db_handler->disconnect() or die $DBI::errstr;
	}
}

sub db_connect()	#void sub-routine
{
	my $db_source = "DBI:mysql:$db_name;host=$db_host";
	$db_handler = DBI->connect($db_source, $db_username, $db_password) or die $DBI::errstr;
}

sub db_execute()	#usage: query($query, \@result), parameter ($query) is the SQL query, parameter
			#(\@result) is the array used to store the data get from database
{
	my $query_str = shift @_;
	my $ptr = shift @_;

	my $query = $db_handler->prepare($query_str);
	$query->execute() or die $query->errstr;

	@$ptr = $query->fetchrow_array();	#fetch the result from database
}

sub db_disconnect()
{
	$db_handler->disconnect() or die $DBI::errstr;
}

###################################################
###
###################################################

return 1;	#for header file, it must return 1, otherwise perl will exit with default value 0
