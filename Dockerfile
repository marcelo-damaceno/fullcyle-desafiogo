#01 - estagio de construção
FROM golang:1.18-alpine as builder

#configura o diretorio de trabalho dentro do container
WORKDIR /app

#copia os arquivos do projeto para o container
COPY go.mod ./
COPY main.go ./

#baixa das dependencias do modulo
RUN go mod download

#configura as variaveis de ambiente para linux
RUN GOOS=linux
RUN GOARCH=adm64

#compila o binario
RUN go build -o desafio-go

#02 - estagio final
FROM scratch

#configura o diretorio de trabalho dentro do container
WORKDIR /app

#copia o binario compilado da etapa de construcao
COPY --from=builder /app/desafio-go .

#define o comando padrao para o container
CMD ["/app/desafio-go"]



