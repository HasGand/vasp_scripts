#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<unistd.h>
#include<arpa/inet.h>
#include<sys/socket.h>
#include<netinet/in.h>

#define BUF_SIZE 1024

int main()
{
	// 先输入文件名，看文件是否能创建成功
	char filename[100] = {0};  //文件名
	printf("Input filename to save: ");
	gets(filename);
        FILE *fp = fopen(filename, "wb");  //以二进制方式打开（创建）文件
        if(fp == NULL){
        printf("Cannot open file, press any key to exit!\n");
        system("pause");
        exit(0);
        }               
        int sock = socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);
        struct  sockaddr_in sockAddr;
        memset(&sockAddr, 0, sizeof(sockAddr));
        sockAddr.sin_family = PF_INET;
	char ip[100];
	printf("Please input the ip addr: ");
	gets(ip);
        sockAddr.sin_addr.s_addr = inet_addr(ip);
        sockAddr.sin_port = htons(1234);
        connect(sock, (struct sockaddr*)&sockAddr, sizeof(sockAddr));
        //循环接收数据，直到文件传输完毕
        char buffer[BUF_SIZE] = {0};  //文件缓冲区
        int nCount;
        while( (nCount = read(sock, buffer, BUF_SIZE)) > 0 ){
        	fwrite(buffer, nCount, 1, fp);
	}
        puts("File transfer success!");
	//文件接收完毕后直接关闭套接字，无需调用shutdown()
        fclose(fp);
        close(sock);
                                                                                                                                                        return 0;
}
