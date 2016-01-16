void
_sleepUntil( unsigned long t_tv_sec,unsigned long t_tv_nsec,int t_clock_type  )
  CODE:
    gpr_sleep_until(pl_init_gpr_timespec(t_tv_sec,t_tv_nsec,t_clock_type));
  OUTPUT:

long
_similar( \
      unsigned long t1_tv_sec,unsigned long t1_tv_nsec,int t1_clock_type, \
      unsigned long t2_tv_sec,unsigned long t2_tv_nsec,int t2_clock_type, \
      unsigned long tr_tv_sec,unsigned long tr_tv_nsec,int tr_clock_type  )
  CODE:
    gpr_timespec t1 = pl_init_gpr_timespec(t1_tv_sec,t1_tv_nsec,t1_clock_type);
    gpr_timespec t2 = pl_init_gpr_timespec(t2_tv_sec,t2_tv_nsec,t2_clock_type);
    gpr_timespec tr = pl_init_gpr_timespec(tr_tv_sec,tr_tv_nsec,tr_clock_type);
    long result = gpr_time_similar(t1,t2,tr);
    RETVAL = result;
  OUTPUT: RETVAL

long
_compare( \
      unsigned long t1_tv_sec,unsigned long t1_tv_nsec,int t1_clock_type, \
      unsigned long t2_tv_sec,unsigned long t2_tv_nsec,int t2_clock_type  )
  CODE:
    gpr_timespec t1 = pl_init_gpr_timespec(t1_tv_sec,t1_tv_nsec,t1_clock_type);
    gpr_timespec t2 = pl_init_gpr_timespec(t2_tv_sec,t2_tv_nsec,t2_clock_type);
    long result = gpr_time_cmp(t1,t2);
    RETVAL = result;
  OUTPUT: RETVAL

SV *
_substract( \
      unsigned long t1_tv_sec,unsigned long t1_tv_nsec,int t1_clock_type, \
      unsigned long t2_tv_sec,unsigned long t2_tv_nsec,int t2_clock_type  )
  CODE:
    HV* hash = newHV();
    gpr_timespec t1 = pl_init_gpr_timespec(t1_tv_sec,t1_tv_nsec,t1_clock_type);
    gpr_timespec t2 = pl_init_gpr_timespec(t2_tv_sec,t2_tv_nsec,t2_clock_type);
    pl_wrap_gpr_timespec(hash,gpr_time_sub(t1,t2));
    RETVAL = newRV_noinc((SV *)hash);
  OUTPUT: RETVAL

SV *
_add( \
      unsigned long t1_tv_sec,unsigned long t1_tv_nsec,int t1_clock_type, \
      unsigned long t2_tv_sec,unsigned long t2_tv_nsec,int t2_clock_type  )
  CODE:
    HV* hash = newHV();
    gpr_timespec t1 = pl_init_gpr_timespec(t1_tv_sec,t1_tv_nsec,t1_clock_type);
    gpr_timespec t2 = pl_init_gpr_timespec(t2_tv_sec,t2_tv_nsec,t2_clock_type);
    pl_wrap_gpr_timespec(hash,gpr_time_add(t1,t2));
    RETVAL = newRV_noinc((SV *)hash);
  OUTPUT: RETVAL

SV *
now()
  CODE:
    HV* hash = newHV();
    pl_wrap_gpr_timespec(hash,gpr_now(GPR_CLOCK_REALTIME));
    RETVAL = newRV_noinc((SV *)hash);
  OUTPUT: RETVAL

SV *
zero()
  CODE:
    HV* hash = newHV();
    pl_wrap_gpr_timespec(hash,gpr_time_0(GPR_CLOCK_REALTIME));
    RETVAL = newRV_noinc((SV *)hash);
  OUTPUT: RETVAL

SV *
infFuture()
  CODE:
    HV* hash = newHV();
    pl_wrap_gpr_timespec(hash,gpr_inf_future(GPR_CLOCK_REALTIME));
    RETVAL = newRV_noinc((SV *)hash);
  OUTPUT: RETVAL

SV *
infPast()
  CODE:
    HV* hash = newHV();
    pl_wrap_gpr_timespec(hash,gpr_inf_past(GPR_CLOCK_REALTIME));
    RETVAL = newRV_noinc((SV *)hash);
  OUTPUT: RETVAL
