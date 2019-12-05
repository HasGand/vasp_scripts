#include"head.h"

int acclnt(int sock)
{
	int clntsock;
	struct sockaddr_in clntaddr;
	socklen_t addrlen = sizeof(clntaddr);
	clntsock = accept(sock, (struct sockaddr*)&clntaddr, &addrlen);
	if( clntsock > 0 ) puts("已接受客户端请求！");
	else
	{
		puts("接受客户端请求失败！");
		return 1;
	}
	return clntsock;
}
