#include"head.h"

int sendfile(FILE *fp, int clntsock)
{
	char buffer[BUF_SIZE]={0};
	int count;
	while( (count = fread(buffer, 1, BUF_SIZE, fp)) >0 )
		write(clntsock, buffer, count);
	shutdown(clntsock, SHUT_WR);
	read(clntsock, buffer, BUF_SIZE);
	return 0;
}
