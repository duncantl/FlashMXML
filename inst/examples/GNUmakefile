MXMLC_FLAGS=--show-actionscript-warnings=true --strict=true
FLEX_DIR=$(HOME)/Projects/Animation/Flex
FLEX_LIB=$(FLEX_DIR)/lib
MXMLC=$(FLEX_DIR)/bin/mxmlc
MXMLC_LIBS=-library-path+=$(FLEX_LIB)

RFLASH_LIB=../RFlash
FLARE_LIB=$(HOME)/Projects/Animation/prefuse.flare-alpha-20080808/build/flare.swc 
EXTRA_LIBS= -library-path+=$(FLARE_LIB) -compiler.source-path+=$(HOME)/Books/XMLTechnologies/Rpackages/FlashMXML/inst/

#%.swf: %.xml 
#	$(MXMLC) $(MXMLC_FLAGS) -file-specs $<

%.swf: %.mxml 
	$(MXMLC) $(MXMLC_FLAGS) $(MXMLC_LIBS) $(EXTRA_LIBS) -file-specs $<

usaMap.swf: usaMap.mxml usaMap.as usaPolygons.as

bob.swf: bob.mxml bob.as bobAnnotate.as

reg.swf: reg.mxml reg.as


