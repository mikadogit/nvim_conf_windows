#
# Cross Platform Makefile
# Compatible with MSYS2/MINGW, Ubuntu  and Mac OS X
#
# Auteur : Mikael JOUANS 
# Version : V 1.0
#-------------------------------------------------------

# Changer CXX pour specifier un compilo C ou C++ 
# Changer CXXFLAGS pour specifier Flags C ou C++

########################################################
#--------------- CONFIGURATION -------------------------
########################################################
#The source file types (headers excluded).
# .c indicates C source files, and others C++ ones.
SRCEXTS = .c .C .cc .cpp .CPP .c++ .cxx .cp
# The header file types.
HDREXTS = .h .H .hh .hpp .HPP .h++ .hxx .hp .i

########################################################
# --------------- SPECIFICATION -------------------
########################################################
# The C++/C program compiler :  
CXX = C:/mingw64/bin/g++.exe

#The C++/C compilation flags : 
CXXFLAGS = -g3 -O0 -Wall -Wconversion -Wsign-conversion -fmessage-length=0 -std=c++20 -Wa,-mbig-obj

#Create a dll or so 
DLL_FLAGS = -shared

#The archive builder flages : 
ARFLAGS = rc

#Bin name generation
EXE =experimentation.exe

#Archive component : 
AR = src/main.o src/test.o
#Lib NAME : 
#or LIBRARY = lidexp.dll
LIBRARY = libexp.a

#Build destination
BUILDFOLDER =debug_experimentation
#FOLDERS sources LIST (automatically processing)
SRCDIRS =	src \
			
#FOLDERS headers LIST (automatically processing)
IDIR =	src \
		C:/tsw_lib/internal_libs/bluebox-2.0/src \
		C:/tsw_lib/external_libs/spdlog-1.0.0/include \
		C:/tsw_lib/external_libs/serialib-2.0/src
# IDIR =	C:\\mingw64\\include\\ \
			# src
			# C:\\mingw64\\x86_64-w64-mingw32\\include\\ \
			# C:\\mingw64\\mingw32\\lib\\ \
#ADD Libs  : 
# ex : LIBS = -lGL -ldl `sdl2-config --libs`
LIBS = -lbluebox -lspdlog -lserialib

#LD FLags :
#WARNING : separator must be type of / in this section 
LDFLAGS = -LC:/tsw_lib/internal_libs/bluebox-2.0 \
		  -LC:/tsw_lib/external_libs/spdlog-1.0.0 \
		  -LC:/tsw_lib/external_libs/serialib-2.0

#WARNING : separator must be type of / in this section 
EXCLUDEFILES=/

#For a standalone installation  
INSTALL_DIR = C:/Users/lbo/Downloads

########################################################
#------------------- PRE PROCESSING --------------------
########################################################
RM     = rm -rf
SHELL   = /bin/sh
SPACE   = $(EMPTY) $(EMPTY)
ifeq ($(EXE),)
	CUR_PATH_NAMES = $(subst /,$(SPACE),$(subst $(SPACE),_,$(CURDIR)))
	EXE = $(word $(words $(CUR_PATH_NAMES)),$(CUR_PATH_NAMES))
		ifeq ($(EXE),)
			EXE = a.out
		endif
endif
ifeq ($(SRCDIRS),)
	SRCDIRS = .
endif
SOURCES = $(foreach d,$(SRCDIRS),$(wildcard $(addprefix $(d)/*,$(SRCEXTS))))
HEADERS = $(foreach d,$(IDIR),$(wildcard $(addprefix $(d)/*,$(HDREXTS))))
#USEFULL for C compilation into C++ projects 
#SOURCES_EXC = $(filter-out %.c),$(SOURCES))

#Files to exclude :
SOURCES_EXC = $(filter-out $(EXCLUDEFILES),$(SOURCES)) 
OBJS = $(addsuffix .o, $(basename $(SOURCES_EXC)))	

INC_PARAM=$(foreach d, $(IDIR), -I$d)
#The C++ flags (with the include dir):
CXXFLAGS += $(INC_PARAM)
#absolute path to genere .o and bin into build folder
BUILDDIR = $(CURDIR)/$(BUILDFOLDER)
#object to compile in order to make the AR
AROBJ = $(addsuffix .o, $(basename $(AR)))


########################################################
#----------- BUILD FLAGS PER PLATFORM ------------------
########################################################
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S), Linux) #LINUX
	ECHO_MESSAGE = "Linux"
	# ex : LIBS += -lGL -ldl `sdl2-config --libs`
	#LIBS+= -lGL -ldl `sdl2-config --libs`
	# ex :CXXFLAGS += `sdl2-config --cflags`
	#CXXFLAGS += `sdl2-config --cflags`
	#file to exclude depending on OS
	#SOURCES_EXC = $(filter-out $(EXCLUDEFILES),$(SOURCES))
endif

ifeq ($(UNAME_S), Darwin) #APPLE
	ECHO_MESSAGE = "Mac OS X"
	#LIBS += -framework OpenGL -framework Cocoa -framework IOKit -framework CoreVideo `sdl2-config --libs`
	#LIBS += -L/usr/local/lib -L/opt/local/lib
	#CXXFLAGS += `sdl2-config --cflags`
	#CXXFLAGS += -I/usr/local/include -I/opt/local/include
	#file to exclude depending on OS
	#SOURCES_EXC = $(filter-out $(EXCLUDEFILES),$(SOURCES))
endif

ifeq ($(OS), Windows_NT)
	ECHO_MESSAGE = "MinGW"
	#LIBS += -lgdi32 -lopengl32 -limm32 `pkg-config --static --libs sdl2`
	#CXXFLAGS += `pkg-config --cflags sdl2`
	#file to exclude depending on OS
	#SOURCES_EXC = $(filter-out $(EXCLUDEFILES),$(SOURCES))
endif

########################################################
# BUILD RULES
########################################################
.PHONY: dir objs all clean help show clean_obj ar clean_ar install
.DEFAULT_GOAL := all
.SUFFIXES:
objs: $(OBJS) $(AROBJ)
%.o:%.c
	$(CXX) $(CXXFLAGS) -c -o $@ $<
		# cp $@ $(BUILDDIR)/
%.o:%.C
	$(CXX) $(CXXFLAGS) -c -o $@ $<
		# cp $@ $(BUILDDIR)/
%.o:%.cc
	$(CXX) $(CXXFLAGS) -c -o $@ $<
		# cp $@ $(BUILDDIR)/
%.o:%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $<
		# cp $@ $(BUILDDIR)/
%.o:%.CPP
	$(CXX) $(CXXFLAGS) -c -o $@ $<
		# cp $@ $(BUILDDIR)/
%.o:%.c++
	$(CXX) $(CXXFLAGS) -c -o $@ $<
		# cp $@ $(BUILDDIR)/
%.o:%.cp
	$(CXX) $(CXXFLAGS) -c -o $@ $<
		# cp $@ $(BUILDDIR)/
%.o:%.cxx
	$(CXX) $(CXXFLAGS) -c -o $@ $<
		# cp $@ $(BUILDDIR)/

all: dir $(BUILDDIR)/$(EXE)
	@echo Build complete for $(ECHO_MESSAGE)
	@for libpath in $(LDFLAGS); do \
		dir=$$(echo $$libpath | cut -c3-); \
		for lib in $(LIBS); do \
			libname1=$$(echo $$lib | sed 's/-l/lib/').dll; \
			libname2=$$(echo $$lib | sed 's/-l//').dll; \
			if [ -f "$$dir/$$libname1" ]; then \
				cp "$$dir/$$libname1" $(BUILDDIR); \
				echo "$$libname1 copié"; \
			elif [ -f "$$dir/$$libname2" ]; then \
				cp "$$dir/$$libname2" $(BUILDDIR); \
				echo "$$libname2 copié"; \
			fi \
		done \
	done
	
dir :
	mkdir -p $(BUILDDIR)

#(BUILDDIR)/$(EXE): $(OBJS)
#	$(CXX) -o $@ $^ $(CXXFLAGS) $(LDFLAGS) $(LIBS)
$(BUILDDIR)/$(EXE): $(OBJS)
	$(CXX) $(LDFLAGS) $^ $(LIBS) -o $@

#/!!!!\ DO NOT USE -j compilation (parallele) for building an archive !!
ar : dir $(LIBRARY)
$(LIBRARY) : $(AROBJ)
	ar $(ARFLAGS) $@ $(AROBJ)
	ranlib $@

#Attention valable que sur windows 
install : all
	@echo "Création du répertoire d'installation..."
	mkdir -p "$(INSTALL_DIR)/$(BUILDFOLDER)"
	
	@echo "Collecte des dépendances..."
	@ldd $(BUILDFOLDER)/$(EXE) | grep "=> /" | awk '{print $$3}' | while read dep; do \
		win_dep=$$(echo $$dep | sed -e 's|^/|C:/|' -e 's|/|\\\\|g'); \
		echo "Copie de $$win_dep dans $(INSTALL_DIR)/$(BUILDFOLDER)"; \
		cp "$$win_dep" "$(INSTALL_DIR)/$(BUILDFOLDER)"; \
	done
	@echo "Copie du binaire..."
	cp $(BUILDFOLDER)/* "$(INSTALL_DIR)/$(BUILDFOLDER)"

dll : $(OBJS)
	  $(CXX) $(LDFLAGS) $^ $(LIBS) $(DLL_FLAGS) -o $(LIBRARY)

clean:
	$(RM) $(OBJS) $(BUILDDIR)

clean_obj:
	$(RM) $(OBJS)
	
clean_lib: clean_obj
	$(RM) $(BUILDDIR)/$(LIBRARY)

help:
	@echo '  all       (=make) compile and link.'
	@echo '  install   build the binary and copy all dependencies to the install dir'
	@echo '  ar        (=make) compile and build a library.'
	@echo '  dll       (=make) compile and build a dll.'
	@echo '  clean_obj clean objects only.'
	@echo '  clean_lib  clean archive or lib.'
	@echo '  clean_ar  clean archive.'
	@echo '  show      show variables (for debug use only).'
	@echo '  help      print this message.'
	@echo

show:
	@echo 'PROGRAM     :' $(EXE)
	@echo 'SRCDIRS     :' $(SRCDIRS)
	@echo 'HEADERS     :' $(HEADERS)
	@echo 'SOURCES     :' $(SOURCES_EXC)
	@echo 'LIBS        :' $(LIBS)
	@echo 'OBJS        :' $(OBJS)
	@echo 'EXLUDE      :' $(EXCLUDEFILES)

