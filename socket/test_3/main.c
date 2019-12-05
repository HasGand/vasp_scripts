#include"head.h"

int main()
{
	int ServSock = socket(AF_INET, SOCK_STREAM, 0);
	struct sockaddr_in ServAddr;
	int ClntSock;
	FILE *fp;

	fp = openfile();
	creat(ServSock, ServAddr);
	monitor(ServSock, 20);
	acclnt(ServSock);
	ClntSock = acclnt(ServSock);
	sendfile(fp, ClntSock);

	fclose(fp);
	close(ServSock);
	close(ClntSock);
	return 0;
}
