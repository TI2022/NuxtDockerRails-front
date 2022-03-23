FROM node:17.7.2-alpine
# Alpineベースのnodeをベースイメージとしています。

ARG WORKDIR
ARG CONTAINER_PORT

ENV HOME=/${WORKDIR} \
    LANG=C.UTF-8 \
    TZ=Asia/Tokyo \
    HOST=0.0.0.0
# ENV HOST=0.0.0.0
# これを指定しないとブラウザからhttp://localhost へアクセスすることができません。
# RailsのDockerfileで指定した、CMD ["rails", "server", "-b", "0.0.0.0"]と同じ意味を持つんですね。
# 仮想環境で起動したRailsは、localhostのipアドレス「127.0.0.1」でアクセスできません。
# そこで仮想外部からアクセスできるように、ip「0.0.0.0」に紐付けをする必要があるのです。
# これにより、自分のPC上のブラウザでRailsにアクセスできるようになるのです。
# LANG=C.UTF-8とは何なのか?
# RailsのDockerfileでも指定しましたが、ENV命令にLANG=C.UTF-8を指定しています。
# LANGとは
# language（ランゲージ）を意味するもので、「アプリケーションの中で使用する言語を明示する」役割があります。
# Cとは
# 言語を表すもので、コンピューターのルールに沿ったen_US（英語）を意味します。
# 一見、en_US.UTF-8と同じように思えますが、並べ替えの順序や桁区切り記号、デフォルトの通貨記号などに違いがあるようです。
# ちなみに日本語はja_JPと指定します。
# UTF-8とは
# 文字コードを表します。
# コンピューターはそもそも計算機なので、文字も数字として認識しています。
# そこで、「この文字は○○番」「この記号は○○番」と割り当てる必要があります。
# この割り当てられた番号を文字コードと言います。
# この文字コードには様々な種類があり、その中でもUTF-8は世界中のソフトウェアで最も使用されている文字コードです。
# つまりLANG=C.UTF-8とは、
# コンピューター用の英語を、
# 文字コードUTF-8で利用する
# と明示しています。

# ENV check（このRUN命令は確認のためなので無くても良い）
RUN echo ${HOME}
RUN echo ${CONTAINER_PORT}

WORKDIR ${HOME}

EXPOSE ${CONTAINER_PORT}
# EXPOSE <ポート番号>
# コンテナ公開用のポート番号を指定します。
# 今回は、docker-compose.ymlのportsで「8080」を指定するので、ここには3000番を入れています。