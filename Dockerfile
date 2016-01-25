FROM node:5.5.0

WORKDIR /src/repackager

RUN \
  apt-get update && \
  apt-get install -y \
    unzip \
    icoutils \
    icnsutils \
    && \
  rm -rf /var/lib/apt/lists/*

RUN \
  npm install -g \
    electron-packager && \
  npm install \
    cheerio

RUN \
  rm -rf tmp && \
  mkdir -p tmp && \
  rm -rf dist && \
  mkdir -p dist

WORKDIR /src/repackager/tmp

ENV \
  ELECTRON=0.36.5 \
  PLATFORM=linux \
  ARCH=x64

CMD \
  body=$(wget -O win.html http://kobito.qiita.com/win) && \
  url=$(node -e "console.log(require('cheerio').load(require('fs').readFileSync('win.html'))('a.js-downloadBtn').attr('href'))") && \
  rm win.html && \
  wget -O kobito.zip $url && \
  unzip -d . kobito.zip && \
  name=kobito-$PLATFORM-$ARCH && \
  wrestool -x -o . -t14 kobito/kobito.exe && \
  for i in *.ico; do convert "$i" "$i.png"; done && \
  rm kobito.exe_14_1.ico-2.png && \
  png2icns kobito.icns kobito.exe_14_1.ico-*.png && \
  electron-packager kobito/resources/app kobito \
    --version=$ELECTRON \
    --platform=$PLATFORM \
    --arch=$ARCH \
    --icon=kobito.icns \
    --cache=/src/repackager/cache \
    --out=../dist \
    --overwrite && \
  cp kobito/readme.txt ../dist/$name/readme.txt && \
  cp kobito.exe_14_1.ico-4.png ../dist/$name/icon.png
