FROM docker.io/library/ubuntu:jammy

USER root

ENV LANG=ja_JP.UTF-8
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64

ENV SPARK_HOME=/opt/spark
ENV SPARK_CONF_DIR="${SPARK_HOME}/conf"
ENV SPARK_LOG_DIR="${SPARK_HOME}/logs"
ENV SPARK_PID_DIR="${SPARK_HOME}/pid"

ENV PATH="${JAVA_HOME}/bin:${SPARK_HOME}/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

COPY files /

RUN \
    TARGET_USER=spark && \
    TARGET_USER_BASHRC="/home/${TARGET_USER}/.bashrc" && \
    TARGET_USER_LOCAL="/home/${TARGET_USER}/.local" && \
    TARGET_USER_SUDOERS="/etc/sudoers.d/${TARGET_USER}" && \
    adduser -q --gecos "" --disabled-login "${TARGET_USER}" && \
    echo "${TARGET_USER}:${TARGET_USER}" | chpasswd && \
    \
    apt -y update && \
    DEBIAN_FRONTEND=noninteractive apt -y install \
    curl \
    dumb-init \
    language-pack-ja \
    openjdk-17-jdk \
    python3 \
    python-is-python3 \
    python3-pip \
    sudo \
    tzdata \
    vim \
    wget \
    && \
    cp /usr/share/zoneinfo/Asia/Tokyo /etc/localtime && \
    dpkg-reconfigure -f noninteractive tzdata && \
    \
    localedef -i ja_JP -c -f UTF-8 -A /usr/share/locale/locale.alias ja_JP.UTF-8 && \
    \
    echo "${TARGET_USER} ALL=(ALL) NOPASSWD: ALL" > "${TARGET_USER_SUDOERS}" && \
    chmod 440 "${TARGET_USER_SUDOERS}" && \
    chmod 644 /etc/profile.d/* && \
    \
    mkdir -p "${SPARK_HOME}" && \
    curl -o /tmp/spark-3.4.4-bin-hadoop3.tgz https://archive.apache.org/dist/spark/spark-3.4.4/spark-3.4.4-bin-hadoop3.tgz && \
    tar -zxf /tmp/spark-3.4.4-bin-hadoop3.tgz -C "${SPARK_HOME}" --strip-components 1 && \
    rm -f /tmp/spark-3.4.4-bin-hadoop3.tgz && \
    rm -f "${SPARK_CONF_DIR}/\*.template" && \
    \
    echo '' >> "${TARGET_USER_BASHRC}" && \
    echo '. /etc/profile.d/custom_profile.sh' >> "${TARGET_USER_BASHRC}" && \
    mkdir -p "${TARGET_USER_LOCAL}" && \
    chown -R "${TARGET_USER}:${TARGET_USER}" "${TARGET_USER_LOCAL}"

RUN \
    TARGET_USER=spark && \
    chown -R "${TARGET_USER}" "${SPARK_HOME}"

USER spark
WORKDIR "${SPARK_HOME}"

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["sh", "-c", "while :; do echo 'Container is running'; sleep 60; done"]
