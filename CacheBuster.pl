#!/usr/bin/perl
use File::Copy;


#Declare Key Variables
my $PROJECT_DIR = $ENV{'PROJECT_DIR'};
my $IOS_TARGET  = substr($ENV{'SDK_NAME'}, -3, 3); 
my $BINARY_NAME = $ENV{'CONTENTS_FOLDER_PATH'};
my $SIMULATOR_PATH    = '~/Library/Application\ Support/iPhone\ Simulator/' . $IOS_TARGET . '/Applications/';
my $APP_SIMULATOR_DIRECTORY = ''; #By default, this is a random alphanumeric string that changes with each sim. install.

print "Looking for binary in Simulator folders. . .\n";

#Determine Filepath for KCI App in Simulator
my @files = <$SIMULATOR_PATH/*>;
foreach my $node (@files)
{
    my $binary_check = "$node/$BINARY_NAME";
    if( -e $binary_check )
    {
        print "Found Binary at: " . $binary_check . "\n";
        $APP_SIMULATOR_DIRECTORY = $node;
    }
}

#The filesystem changed from 5.1 Simulator to 6.0 Simulator.
#Consequently, a runtime check should be performed to target appropriate versions.
my $cache_directory = '';
my $file0_filepath  = '';
if( substr($IOS_TARGET, 0, 1) >= 6 )
{
    print "Busting cache for >= 6.0 Simulator\n";
    $file0_filepath  = "$APP_SIMULATOR_DIRECTORY/Library/WebKit/LocalStorage/file__0.localstorage";
    $cache_directory = "$APP_SIMULATOR_DIRECTORY/Caches/*";
}
else #Assume 5.x filesystem
{
    print "Busting cache for 5.x Simulator\n";
    $file0_filepath  = "$APP_SIMULATOR_DIRECTORY/Library/Caches/file__0.localstorage";
    $cache_directory = "$APP_SIMULATOR_DIRECTORY/Documents/Backups/*";
}

#Bail if we don't already have a local cache.
#This means that we won't be able to make changes until 2nd "Build & Run".
if(! (-e $file0_filepath) )
{
    print "Bailing. . .No Cache to Bust.\n";
    exit;
}

print "Beginning Cache Bust. . .\n";

#"Bust" All Local Cache Files
@DEL_FILES = ("$APP_SIMULATOR_DIRECTORY/Documents/Data/config12.json",
              "$APP_SIMULATOR_DIRECTORY/Documents/Data/content8.json",
              $file0_filepath,
              $cache_directory);
unlink @DEL_FILES;

#Copy working directory copies to cache folders
copy($PROJECT_DIR . "/www/data/config12.json", $APP_SIMULATOR_DIRECTORY . "/Documents/Data/config12.json");
copy($PROJECT_DIR . "/www/data/content8.json", $APP_SIMULATOR_DIRECTORY . "/Documents/Data/content8.json");

print "Cache bust completed.\n";