#!/usr/bin/env bash

pip3 install --upgrade wheel setuptools
pip3 install --upgrade psutil

# java8
apt-get --yes --no-install-recommends install openjdk-8-jre
export _JAVA_OPTIONS="-Djava.io.tmpdir=$TMPDIR"

# cwltool 1.0.20190228155703
pip3 install 'cwltool==1.0.20190228155703'

# shellcheck 0.6.0
wget -q "https://shellcheck.storage.googleapis.com/shellcheck-v0.6.0.linux.x86_64.tar.xz" -O "shellcheck-v0.6.0.linux.x86_64.tar.xz" \
    && tar -xJf "shellcheck-v0.6.0.linux.x86_64.tar.xz" \
    && mv shellcheck-v0.6.0/shellcheck /usr/local/bin \
    && rm "shellcheck-v0.6.0.linux.x86_64.tar.xz" \
    && rm -r shellcheck-v0.6.0/

# memUsage (both python 2 & 3) (Olga)
# psutil >= 2.2.1 (Tested with 5.6.1 - ok; 1.2.1 - err) - additional python package required for memUsage.
wget -q "https://raw.githubusercontent.com/ozolotareva/housekeeping-scr/master/memUsage.py" -O - | tr -d '\r' > "/usr/local/bin/memUsage.py" \
    && sed -i -e '1i#!/usr/bin/env python' "/usr/local/bin/memUsage.py" \
    && chmod +x "/usr/local/bin/memUsage.py"
export MEMUSAGE="/usr/local/bin/memUsage.py"


export SOFT="/soft"
mkdir -p "$SOFT"

exit # from pip update
