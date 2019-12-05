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
	//创建套接字
	int serv_sock = socket(AF_INET, SOCK_STREAM, 0);

	//将该套接字与IP和端口绑定
	struct sockaddr_in serv_addr;
	memset(&serv_addr, 0, sizeof(serv_addr)); //每个字节用0填充
	serv_addr.sin_family = AF_INET;
	serv_addr.sin_addr.s_addr = htonl(INADDR_ANY);
	serv_addr.sin_port = htons(1234);
	bind(serv_sock, (struct sockaddr*)&serv_addr, sizeof(serv_addr));
	
	//进入监听状态
	listen(serv_sock, 20);
	
	//接受客户端请求
	struct sockaddr_in clntAddr;
	socklen_t clntAddr_size = sizeof(clntAddr);
	char buffer[BUF_SIZE] = {0};
	while(1)
	{
		int clntSock = accept(serv_sock, (struct sockaddr*)&clntAddr, &clntAddr_size);
		int strLen = read(clntSock, buffer, BUF_SIZE); //接受客户端数据
		write(clntSock, buffer, strLen); //原样返回数据
		puts(buffer);
		
		close(clntSock);
		memset(buffer, 0, BUF_SIZE);
	}

	close(serv_sock);
	return 0;
}
