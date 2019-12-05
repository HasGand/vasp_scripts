#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>
#include<arpa/inet.h>
#include<sys/socket.h>
#include<netinet/in.h>

#define BUF_SIZE 1024

int main(int argc, char *argv[])
{
	int ServSock = socket(AF_INET, SOCK_STREAM, 0);
	struct sockaddr_in ServAddr;

	FILE *fp;
	char *fname;

	int ClntSock;
        struct sockaddr_in ClntAddr;
	socklen_t CAddrlen;

	int max;

	char buffer[BUF_SIZE]={0};
        int count;

//打开文件
	if(argc == 1)
	{
		printf("Input the file name: ");
		gets(fname);
	}
	else
	{
		fname=argv[1];
		printf("The file name is %s\n", argv[1]);
	}

	if( (fp=fopen(fname, "rb")) == NULL )
	{
		perror(fname);
		exit(1);
	}
	else
		printf("打开%s文件成功！\n", fname);


//绑定
	memset(&ServAddr, 0, sizeof(ServAddr));
	ServAddr.sin_family = AF_INET;
	ServAddr.sin_addr.s_addr = htonl(INADDR_ANY);
	ServAddr.sin_port = htons(1234);
	if( bind(ServSock, (struct sockaddr*)&ServAddr, sizeof(ServAddr)) < 0 )
		puts("与服务器绑定失败！"), exit(1);
	puts("套接字与服务器ip与端口绑定成功!");

//监听
	max = 2;
	if( listen(ServSock, max) < 0 )
	{
		puts("监听失败！");
		exit(1);
	}
	puts("监听成功！");

//接受客户端请求
	CAddrlen = sizeof(ClntAddr);
	ClntSock = accept(ServSock, (struct sockaddr*)&ClntAddr, &CAddrlen);
	if( ClntSock > 0 ) puts("已接受客户端请求！");
	else
	{
		puts("接受客户端请求失败！");
		exit(1);
	}


//发送文件
	while( (count = fread(buffer, 1, BUF_SIZE, fp)) >0 )
		write(ClntSock, buffer, count);
	shutdown(ClntSock, SHUT_WR);
	read(ClntSock, buffer, BUF_SIZE);

	fclose(fp);
	close(ServSock);
	close(ClntSock);
	return 0;
}
