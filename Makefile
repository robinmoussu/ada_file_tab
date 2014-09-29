FILE := file_tab

all: install run

run: install
	./$(FILE)_test

install: *.adb *.ads clean
	gnatmake $(FILE).adb $(FILE)_test.adb

clean:
	rm *.{o,ali} $(FILE)_test -f

.PHONY : clean
