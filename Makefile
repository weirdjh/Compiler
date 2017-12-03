#
# Makefile for CMINUS
# Gnu C Version
# K. Louden 2/3/98
#

CC = gcc

CFLAGS = 

OBJS = main.o util.o scan.o parse.o symtab.o analyze.o code.o cgen.o

cminus: main.o util.o scan.o parse.o symtab.o analyze.o
	$(CC) $(CFLAGS) main.o util.o scan.o parse.o symtab.o analyze.o -o cminus

parse.c y.tab.h: yacc/cminus.y
	yacc -d yacc/cminus.y
	mv y.tab.c parse.c

main.o: main.c globals.h util.h scan.h y.tab.h
	$(CC) $(CFLAGS) -c main.c

util.o: util.c util.h globals.h
	$(CC) $(CFLAGS) -c util.c

scan.o: scan.c scan.h util.h globals.h
	$(CC) $(CFLAGS) -c scan.c

parse.o: parse.c parse.h scan.h globals.h util.h
	$(CC) $(CFLAGS) -c parse.c

symtab.o: symtab.c symtab.h scope.h
	$(CC) $(CFLAGS) -c symtab.c

analyze.o: analyze.c globals.h symtab.h analyze.h util.h
	$(CC) $(CFLAGS) -c analyze.c

code.o: code.c code.h globals.h
	$(CC) $(CFLAGS) -c code.c

cgen.o: cgen.c globals.h symtab.h code.h cgen.h
	$(CC) $(CFLAGS) -c cgen.c

clean:
	-rm cminus
	-rm main.o util.o scan.o parse.o symtab.o analyze.o
	-rm y.tab.h parse.c

tm: tm.c
	$(CC) $(CFLAGS) tm.c -o tm

all: cminus tm

