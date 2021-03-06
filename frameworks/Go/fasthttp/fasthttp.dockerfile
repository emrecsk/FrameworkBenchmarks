FROM golang:1.12

ADD ./ /fasthttp
WORKDIR /fasthttp

RUN mkdir bin
ENV GOPATH /fasthttp
ENV PATH ${GOPATH}/bin:${PATH}

RUN rm -rf ./pkg/*
RUN go get -d -u github.com/go-sql-driver/mysql
RUN go get -d -u github.com/valyala/fasthttp/...
RUN go get -u github.com/valyala/quicktemplate/qtc
RUN go get -u github.com/mailru/easyjson/...

RUN rm -f ./server-mysql
RUN go generate templates
RUN easyjson -all src/common/common.go
RUN go build -gcflags='-l=4' server-mysql

CMD ./server-mysql
