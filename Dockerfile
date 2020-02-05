FROM ubuntu:xenial

# Set metadata
LABEL maintainer="Philipp Dubach <dubachphil@hotmail.com>"
LABEL description="Creates an Ubuntu container serving a CUPS"

# Set environment
ENV LANG en_US.UTF-8
ENV TERM xterm

# Set workdir
WORKDIR /opt/cups

# Install CUPS/AVAHI
RUN apt-get update && apt-get upgrade -y
RUN apt-get install printer-driver-gutenprint hplip -y
RUN apt-get install cups cups-filters avahi-daemon inotify-tools -y

# Install Gutenprint Printdrivers
# RUN apt-get install curl
# RUN curl https://netcologne.dl.sourceforge.net/project/gimp-print/gutenprint-5.3/5.3.3/gutenprint-5.3.3.tar.xz --output gutenprint.tar.xz
# RUN tar xjvf gutenprint-5.0.0.tar.bz2

# Copy configuration files
COPY root /

# Prepare CUPS container
RUN chmod 755 /srv/run.sh

# Expose SMB printer sharing
EXPOSE 137/udp 139/tcp 445/tcp

# Expose IPP printer sharing
EXPOSE 631/tcp

# Expose avahi advertisement
EXPOSE 5353/udp

# Start CUPS instance
CMD ["/srv/run.sh"]
