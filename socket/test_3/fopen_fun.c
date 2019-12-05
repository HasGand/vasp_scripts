#include"head.h"

FILE *openfile()
{
	char *fname;
	FILE *fp;
	printf("Please input the file name: ");
	gets(fname);
	if( (fp=fopen(fname, "rb")) == NULL )
	{
		perror(fname);
		exit(1);
	}
	else
		printf("打开%s文件成功！\n", fname);;
	return fp;
}
