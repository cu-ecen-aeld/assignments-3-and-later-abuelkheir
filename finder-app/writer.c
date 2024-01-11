#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdio.h>
#include <string.h>
#include <syslog.h>
#include <unistd.h>

// argc : argument count 
// argv : argument vector 


    /*O_CREAT
If the file denoted by name does not exist, the kernel will create it. If the file already
exists, this flag has no effect unless O_EXCL is also given.
*/
/*
O_EXCL
When given with O_CREAT , this flag will cause the call to open() to fail if the file
given by name already exists. This is used to prevent race conditions on file creation.
If O_CREAT is not also provided, this flag has no meaning.
*/

int main(int argc, char *argv[]) {
    // Opening log
    openlog("", LOG_PID, LOG_USER);

    if (argc < 3) {
        syslog(LOG_ERR, "Not enough parameters specified");
        return 1; // error
    }

    const char *writefile = argv[1]; // file path where we will write the value
    const char *writestr = argv[2]; // string that will be written to the file

    int filedescriptor = open(writefile, O_CREAT | O_EXCL | O_RDWR, S_IRWXO);

    if (filedescriptor == -1) {
        // error logging
        syslog(LOG_ERR, "Directory not available");
        closelog();
        return 1;
    }

    ssize_t nr;

    nr = write(filedescriptor, writestr, strlen(writestr));
    if (nr == -1) {
        // error logging
        syslog(LOG_ERR, "Writing to file failed");
        closelog();
        close(filedescriptor); // Close the file descriptor before returning
        return 1;
    }

    syslog(LOG_DEBUG, "Writing %s to %s", writestr, writefile);

    close(filedescriptor); // Close the file descriptor after successful write
    closelog();
    return 0;
}
