TSXS?=tsxs
BUILDTYPE=Release
MOD_PAGESPEED_DIR=$(HOME)/code/google/mod_pagespeed/src/
PAGESPEED_OUT=$(MOD_PAGESPEED_DIR)out/$(BUILDTYPE)/

INC  = -I$(MOD_PAGESPEED_DIR)\
 -I$(MOD_PAGESPEED_DIR)third_party/chromium/src/\
 -I$(MOD_PAGESPEED_DIR)third_party/google-sparsehash/src\
 -I$(MOD_PAGESPEED_DIR)third_party/google-sparsehash/gen/arch/linux/x64/include\
 -I$(MOD_PAGESPEED_DIR)third_party/protobuf/src\
 -I$(MOD_PAGESPEED_DIR)third_party/re2/src\
 -I$(MOD_PAGESPEED_DIR)third_party/out/$(BUILDTYPE)/obj/gen\
 -I$(MOD_PAGESPEED_DIR)third_party/apr/src/include/\
 -I$(MOD_PAGESPEED_DIR)third_party/aprutil/src/include/\
 -I$(MOD_PAGESPEED_DIR)third_party/apr/gen/arch/linux/x64/include/\
 -I$(MOD_PAGESPEED_DIR)third_party/aprutil/gen/arch/linux/x64/include/\
 -I$(PAGESPEED_OUT)obj/gen/\
 -I$(PAGESPEED_OUT)obj/gen/protoc_out/instaweb/

PSOL_LIBS = $(MOD_PAGESPEED_DIR)net/instaweb/automatic/pagespeed_automatic.a

%.so: %.cc
	g++ $(INC) -shared -o ats_speed.so -g -pipe -Wall -Werror -O3 -fpic *.cc -lstdc++  -lpthread -lrt $(PSOL_LIBS)

all: gzip/gzip.so ats_speed.so

install: all
	$(TSXS) -i -o ats_speed.so 
	cp gzip/gzip.so ./
	$(TSXS) -i -o zip.so 

clean:
	rm -f *.lo *.so *.o
