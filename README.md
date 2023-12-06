# README

API desenvolvida com o Rails API para avaliação de filmes e séries.

## Versão do Ruby

* ruby-3.2.2

## Configuração

O projeto possui um Dockerfile e um docker-compose.yml preparado para conseguir rodá-lo localmente.

Para executar a aplicação antes é necessário executar este setup abaixo:

> O projeto possui integração com a API do  TMDB (The Movie Database), então para rodá-lo localmente, alem do setup abaixo, é necessário [criar uma chave no site do TMDB](https://www.themoviedb.org/) e salvá-la na variável `CINE4YOU_API_TMDB_KEY` do arquivo `.env`.

* Configurar projeto: `docker-compose build`
* Instalar dependencias: `docker-compose run --rm app bundle install`
* Configurar banco de dados: `docker-compose run --rm app bundle exec rails db:create db:migrate db:seed`
  * Caso precise recriar o banco de dados: `docker-compose run --rm app bundle exec rails db:drop db:create db:migrate db:seed`

> Este setup só precisa ser executado uma vez... excerto caso precise atualizar o projeto.

> Se quiser gerar reviews "fake" pode executar este comando: `docker-compose run --rm app bundle exec rails dev:fake_reviews`

E o comando de executar a aplicação é este:

* `docker-compose up`

> Caso este comando apresente o seguinte erro: `A server is already running (pid: 1, file: /cine4you-api/tmp/pids/server.pid).` o arquivo `server.pid` pode ser deletado manualmente com o seguinte comando:
>
> * `sudo rm tmp/pids/server.pid`

### Acessar console do Rails

* `docker-compose run --rm app bundle exec rails c`

### Executar bateria de testes

* `docker-compose run --rm app bundle exec rspec`

### Acessar o terminal do container

* `docker-compose run --rm app bash`

## Documentação adicional

* `./docs`
