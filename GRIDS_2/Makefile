CDF=/opt/ports
#####################################################################
# compiler options
#####################################################################
#FOPT = -O
#FOPT = -fbounds-check

F90 = /opt/ports/bin/gfortran-mp-5
FOPT = -C
FOPT = -fconvert=big-endian

opt1=-Dhycom_024
#opt1=-Dhycom_008
#opt1=-Dhycom_072

optall = $(opt1) $(opt2)

#####################################################################
# 
#####################################################################

OBJS = param.o data.o charstrings.o ocnfields.o icefields.o cdf.o mod_xc.o mod_za.o mod_cice.o zh.o wtime.o grid2cice.o xhygrid.o ocn_dump2cdf.o ice_dump2cdf.o hycom2kiss.o

makeit: $(OBJS) 
	$(F90) $(FOPT) -o makeit $(OBJS) -L$(CDF)/lib -lnetcdff -lnetcdf 

%.o: %.F90
	$(F90) $(FOPT) $(optall) -c -I$(CDF)/include $<
	cpp $(optall) -I$(CDF)/include $*.F90>$*.i

%.o: %.F
	$(F90) $(FOPT) $(optall) -c -I$(CDF)/include $<
	cpp $(optall) -I$(CDF)/include $*.F>$*.i

clean:
	/bin/rm -f makeit *.o *.i *.mod
