gcc /home/node/rjh/gcc/socket/chatroom/source_file/service.c -o service.out -lpthread
gcc /home/node/rjh/gcc/socket/chatroom/source_file/client.c -o client.out -lpthread
mkdir service client
mv service.out service
mv client.out client
