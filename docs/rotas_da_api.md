# Rotas da API

## Root

Esta rota retorna a lista de catálogos.

## Rota de vivacidade

* curl --location 'http://localhost:3000/up'

## Rotas para "buscar algo"

### Buscar um catalogo

* curl --location 'http://localhost:3000/catalogs/1'

### Buscar um catalogo usando parte do titulo

* curl --location 'http://localhost:3000/catalogs?like=Sociedade'

### Buscar catalogos

* curl --location 'http://localhost:3000/catalogs'

### Buscar sugestões de catalogos

* curl --location 'http://localhost:3000/catalogs/suggestions'

### Buscar uma revisão de um catálogo

* curl --location 'http://localhost:3000/catalogs/1/reviews/35'

### Buscar revisões de um catálogo

* curl --location 'http://localhost:3000/catalogs/1/reviews'

### Buscar boas revisões de um catálogo

* curl --location 'http://localhost:3000/catalogs/1/reviews/good'

### Buscar neutras revisões de um catálogo

* curl --location 'http://localhost:3000/catalogs/1/reviews/neutral'

### Buscar ruins revisões de um catálogo

* curl --location 'http://localhost:3000/catalogs/1/reviews/bad'

### Buscar uma categoria

* curl --location 'http://localhost:3000/categories/1'

### Buscar categorias

* curl --location 'http://localhost:3000/categories'

### Buscar catalogos de uma categoria

* curl --location 'http://localhost:3000/categories/1/catalogs'

### Buscar sugestões de catalogos de uma categoria

* curl --location 'http://localhost:3000/categories/1/catalogs/suggestions'

### Buscar um genero

* curl --location 'http://localhost:3000/genres/1'

### Buscar generos

* curl --location 'http://localhost:3000/genres'

### Buscar catalogos de um genero

* curl --location 'http://localhost:3000/genres/1/catalogs'

### Buscar sugestões de catalogos de um genero

* curl --location 'http://localhost:3000/genres/1/catalogs/suggestions'

### Buscar uma revisão

* curl --location 'http://localhost:3000/reviews/35'

## Rotas para "criar algo"

### Criar uma revisão para um catálogo

```shell
curl --location 'http://localhost:3000/catalogs/1/reviews' \
--header 'Content-Type: application/json' \
--data '{
    "review" : {
        "rating": "5",
        "comment": "Maiores qui animi. Sunt ipsam molestiae. Sed numquam laudantium."
    }
}'
```
