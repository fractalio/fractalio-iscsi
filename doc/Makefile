# for doc

top_srcdir = ..
srcdir   = .

prefix   = /usr/local
exec_prefix = ${prefix}
bindir   = ${exec_prefix}/bin
sbindir  = ${exec_prefix}/sbin
sysconfdir = ${prefix}/etc
datarootdir = ${prefix}/share
datadir  = ${datarootdir}
libexecdir = ${exec_prefix}/libexec
mandir   = ${datarootdir}/man

configdir = /usr/local/etc/istgt
mediadir = /var/istgt

SED      = /bin/sed
INSTALL  = /usr/bin/install -c
MKDIR_P  = /bin/mkdir -p

source   = 
header   = 
document = QUICKSTART QUICKSTART.jp
sample   = 
MANPAGES = $(patsubst %.1.in, %.1, $(wildcard *.1.in))

DISTDIR = $(top_srcdir)/`cat $(top_srcdir)/distdir`
DISTFILES = Makefile.in \
	$(header) $(source) \
	$(document) $(sample)
DISTFILES += $(MANPAGES)

#########################################################################

.PHONY: all install install-doc install-dirs install-doc-dirs
all: $(MANPAGES)

$(MANPAGES):
	$(SED) -e 's:%%PREFIX%%:$(prefix):g' \
		-e 's:%%CONFIGDIR%%:$(configdir):g' \
		-e 's:%%MEDIADIR%%:$(mediadir):g' < $(patsubst %.1, %.1.in, $@) > $@

dist: $(DISTFILES)
	$(MKDIR_P) $(DISTDIR)/$(subdir)
	cd $(srcdir); thisdir=`pwd`; \
	for file in $(DISTFILES); do \
	    cp -p $$thisdir/$$file $(DISTDIR)/$(subdir); \
	done

install: install-dirs
	set -e
	for file in $(MANPAGES) ; \
	do \
		$(INSTALL) -c -m 0644 $$file $(DESTDIR)$(mandir)/man1/ ; \
		rm -f $(DESTDIR)$(mandir)/man1/$$file.gz ; \
		gzip -9 $(DESTDIR)$(mandir)/man1/$$file ; \
	done

install-doc: install-doc-dirs
	$(INSTALL) -m 0644 $(top_srcdir)/README $(DESTDIR)$(datadir)/doc/istgt/
	$(INSTALL) -m 0644 $(top_srcdir)/ChangeLog.jp $(DESTDIR)$(datadir)/doc/istgt/
	$(INSTALL) -m 0644 QUICKSTART $(DESTDIR)$(datadir)/doc/istgt/
	$(INSTALL) -m 0644 QUICKSTART.jp $(DESTDIR)$(datadir)/doc/istgt/

install-dirs:
	$(MKDIR_P) $(DESTDIR)$(mandir)/man1

install-doc-dirs:
	$(MKDIR_P) $(DESTDIR)$(datadir)/doc/istgt

.PHONY: clean distclean depend
clean:
	-rm -f $(MANPAGES)
	-rm -f a.out *.o *.core
	-rm -f *~

distclean: clean
	-rm -f Makefile config.status config.cache config.log config.h

depend:

#########################################################################
