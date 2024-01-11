CC = gcc
file = writer.c

ifdef CROSS_COMPILER
	compile = $(CROSS_COMPILER)$(CC)
endif

default: writer.c 				
	$(CC) $(file) -o writer

clean:
	# rm *.o
	rm writer
