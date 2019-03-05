FROM gcc:4.6
MAINTAINER Takeshi Kojima <kojima@tokushima-u.ac.jp>

ENV USER yourname
ENV HOME /home/${USER}

RUN mkdir tmp; cd tmp &&\
    wget http://www.nets.ne.jp/~matsu/MH/mh-6.8.4-JP-3.05.tar.gz &&\
    tar xzf mh-6.8.4-JP-3.05.tar.gz &&\
    cd mh-6.8.4-JP-3.05 &&\
    wget http://www.nets.ne.jp/~matsu/MH/mh-6.8.4-JP-3.05-linux-20090227.patch &&\
    wget http://www.nets.ne.jp/~matsu/MH/mh-6.8.4-JP-3.05-docomo-20100214.patch &&\
    wget http://www.nets.ne.jp/~matsu/MH/mh-6.8.4-JP-3.05-getline-20120829.patch &&\
    wget http://www.nets.ne.jp/~matsu/MH/mh-6.8.4-JP-3.05-errno-20120829.patch &&\
    patch -p1 < ./mh-6.8.4-JP-3.05-linux-20090227.patch &&\
    patch -p1 < ./mh-6.8.4-JP-3.05-docomo-20100214.patch &&\
    patch -p1 < ./mh-6.8.4-JP-3.05-getline-20120829.patch &&\
    patch -p1 < ./mh-6.8.4-JP-3.05-errno-20120829.patch &&\
    wget -O config.guess 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.guess;hb=HEAD' &&\
    wget -O config.sub 'http://git.savannah.gnu.org/gitweb/?p=config.git;a=blob_plain;f=config.sub;hb=HEAD' &&\
    yes | ./configure  &&\
    make &&\
    make install

RUN useradd -m ${USER}
USER ${USER}
WORKDIR ${HOME}
ADD --chown=yourname:yourname ./Mail ${HOME}/Mail
ADD --chown=yourname:yourname ./.mh_profile ${HOME}/.mh_profile



