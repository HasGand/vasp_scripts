#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>
#include <netinet/in.h>
#define BUF_SIZE 100

int main(void)
{
	struct sockaddr_in sockAddr;
	memset(&sockAddr, 0, sizeof(sockAddr));
	sockAddr.sin_family = AF_INET;
	sockAddr.sin_addr.s_addr = inet_addr("10.64.17.159");
	sockAddr.sin_port = htons(1234);
	
	char bufRead[BUF_SIZE] = {0};
	char bufWrite[BUF_SIZE] = {0};

	while(1)
	{
		int clit_sock = socket(AF_INET, SOCK_STREAM, 0);
		connect(clit_sock, (struct sockaddr*)&sockAddr, sizeof(sockAddr));
		printf("Please input a strings: ");
		LOPO:	gets(bufWrite);
		if(strlen(bufWrite) == 0) goto LOPO;
		write(clit_sock, bufWrite, strlen(bufWrite));
		read(clit_sock, bufRead, BUF_SIZE);
		printf("Message from server:%s\n", bufRead);
		
		memset(bufWrite, 0, BUF_SIZE);
		memset(bufRead, 0, BUF_SIZE);
		close(clit_sock);
	}
	return 0;
}
