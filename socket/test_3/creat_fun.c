#include"head.h"

int creat(int sock, struct sockaddr_in addr)
{
	memset(&addr, 0, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = htonl(INADDR_ANY);
	addr.sin_port = htons(12345);
	if( bind(sock, (struct sockaddr*)&addr, sizeof(addr)) < 0 )
		puts("与服务器绑定失败！"), exit(1);
	puts("套接字与服务器ip与端口绑定成功!");
	return 0;
}
