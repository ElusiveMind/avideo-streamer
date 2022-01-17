# AVideo: Streamer

This is the Streamer for AVideo! AVideo is a video-sharing website, It is an open source solution that is freely available to everyone. With AVideo you can create your own video sharing site, it will help you import and encode videos from other sites like Youtube, Vimeo, etc. and you can share directly on your website. In addition, you can use Facebook or Google login to register users on your site. The service was created in March 2017.  

This Docker container is, in no way, an official distribution of AVideo. Is is the distribution we use on our own web sites. It is based off the Ubuntu 20.04 Linux distribution.  

This container is designed to run as it's own domain or subdomain and not a subdirectory under a current domain. It is designed to be a lone-container on your system or proxied via a reverse proxy such as Nginx. Our set up includes this container running on the same VPS as the AVideo Encoder on a different port and proxied by Nginx.  

Environment variables below are meant to help you get your site configured and tuned for use. Any configurations to Nginx will have to happen on those applications however you have installed them.  

#### Last Updated: January 22, 2022 -- Version 11.1.1

### Environment Variables

**PHP_DISPLAY_ERRORS**  
_Deafult Value: Off_  
This directive controls whether or not and where PHP will output errors, notices and warnings.

**PHP_DISPLAY_STARTUP_ERRORS**  
_Deafult Value: Off_  
The display of errors which occur during PHP's startup sequence are handled separately from display_errors.

**PHP_MAX_EXECUTION_TIME**  
_Default Value: 300_  
Maximum execution time of each script, in seconds. A value of 0 disables the limit. This is of particular interest for AVideo.

**PHP_MAX_INPUT_TIME**  
_Default Value: 300_  
Maximum amount of time each script may spend parsing request data. A value of -1 disables the limit. This is of particular interest for AVideo.

**PHP_MAX_INPUT_VARS**  
_Default Value: 1000_  
How many GET/POST/COOKIE input variables may be accepted.

**PHP_MEMORY_LIMIT**  
_Default Value: 386M_  
Maximum amount of memory a script may consume. This is of particular interest for AVideo.

**PHP_POST_MAX_SIZE**  
_Default Value: 256M_  
Maximum size of POST data that PHP will accept. A value of 0 disables the limit. This is of particular interest for AVideo.  

**PHP_UPLOAD_MAX_FILESIZE**  
_Default Value: 256M_  
Maximum allowed size for uploaded files. This is of particular interest for AVideo.  

