FROM arpagaus/oraclelinux

ADD linuxamd64_12102_database_1of2.zip /tmp/install/linuxamd64_12102_database_1of2.zip
ADD linuxamd64_12102_database_2of2.zip /tmp/install/linuxamd64_12102_database_2of2.zip
RUN yum -y install oracle-rdbms-server-12cR1-preinstall unzip sudo
RUN cd /tmp/install && \
  unzip linuxamd64_12102_database_1of2.zip && \
  unzip linuxamd64_12102_database_2of2.zip && \
  rm *.zip && \
  echo "oracle:oracle" | chpasswd

ENV ORACLE_BASE /u01/app/oracle

RUN mkdir -p $ORACLE_BASE && \
  chown -R oracle:oinstall $ORACLE_BASE && \
  chmod -R 775 $ORACLE_BASE && \
  mkdir -p /u01/app/oraInventory && \
  chown -R oracle:oinstall /u01/app/oraInventory && \
  chmod -R 775 /u01/app/oraInventory
ADD oraInst.loc /etc/oraInst.loc
RUN chmod 664 /etc/oraInst.loc

ADD sysctl.conf /etc/sysctl.conf
RUN echo "oracle soft stack 10240" >> /etc/security/limits.conf

ADD db_install.rsp /tmp/db_install.rsp
ADD install.sh /tmp/install/install.sh
RUN sed -i -e 's/Defaults    requiretty/#Defaults    requiretty/g' /etc/sudoers && \
  /tmp/install/install.sh && \
  rm -rf /tmp/install.sh

ENV ORACLE_SID ORCL
ENV ORACLE_HOME $ORACLE_BASE/product/12.1.0/dbhome_1
ENV PATH $ORACLE_HOME/bin:$PATH

RUN $ORACLE_HOME/root.sh

RUN mkdir -p $ORACLE_BASE/oradata && \
  chown -R oracle:oinstall $ORACLE_BASE/oradata && \
  chmod -R 775 $ORACLE_BASE/oradata && \
  mkdir -p $ORACLE_BASE/fast_recovery_area && \
  chown -R oracle:oinstall $ORACLE_BASE/fast_recovery_area && \
  chmod -R 775 $ORACLE_BASE/fast_recovery_area

ADD oracle-.bashrc /home/oracle/.bashrc

ADD initORCL.ora $ORACLE_HOME/dbs/initORCL.ora
ADD createdb.sql $ORACLE_HOME/config/scripts/createdb.sql
ADD create.sh /tmp/create.sh
RUN /tmp/create.sh && \
  rm /tmp/create.sh

EXPOSE 1521

ADD startdb.sql $ORACLE_HOME/config/scripts/startdb.sql
ADD start.sh /tmp/start.sh
CMD /tmp/start.sh

