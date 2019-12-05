#include"head.h"

int monitor(int sock, int max)
{
	if( listen(sock, max) < 0 )
	{
		puts("监听失败！");
		exit(1);
	}
	puts("监听成功！");
	return 0;
}
