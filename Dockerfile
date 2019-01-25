FROM golang
RUN mkdir -p /go/src/bee-go-vue
WORKDIR /go/src/bee-go-vue
COPY . /go/src/bee-go-vue
CMD ["bee-go-vue-wrapper", "run"]
ONBUILD COPY . /go/src/bee-go-vue
ONBUILD RUN bee-go-vue-wrapper download
ONBUILD RUN bee-go-vue-wrapper install
RUN go get github.com/astaxie/beego
RUN go get -d -v
RUN go install -v
