# Rotas que o frontend chama

## Menu

### Tela de criar usuário

* POST http://localhost:3000/signup

dados:

```json
{
  "user": {
    "email": "cary@jacobson.example",
    "password": "123456",
    "name": "Maria Valentina Ribeiro"
  }
}
```

### Tela de autenticação

* POST http://localhost:3000/login

dados:

```json
{
  "user": {
    "email": "cary@jacobson.example",
    "password": "123456"
  }
}
```

retorno:

```
Header
{ authorization: Bearer abcd1234.dcba4321.q1w2e3r4 }
```

> Importante: guardar o token informado no header, em "authorization", para:
>
> * visualizar usuário logado
> * realizar movimentações nas análises:
>   * visualizar suas análises,
>   * criar análises,
>   * editar suas análises,
>   * deletar suas análises.

## Tela de listar catálogos

### Antes de interagir na tela

#### Visualizar usuário logado

* GET http://localhost:3000/current_user_info -H { "Authorization": "Bearer abcd1234.dcba4321.q1w2e3r4" }

retorno:

```json
{
  "id": 2,
  "email": "del@hills.example",
  "name": "Maria Valentina Ribeiro"
}
```

> Importante: esta requisição só é necessária para interagir com o usuário, por exemplo: "Olá Maria Valentina Ribeiro, tudo bem?".

#### Listar sugestões de catálogos

* GET http://localhost:3000/catalogs/suggestions

retorno:

```json
[
  {
    "catalog": {
      "id": 6,
      "category_id": 1,
      "genre_id": 2,
      "format_title": "O Senhor Dos Anéis: A Sociedade Do Anel",
      "summed_rating": 9,
      "original_title": "The Lord of the Rings: The Fellowship of the Ring",
      "release_date": "18/12/2001",
      "overview": "Young hobbit Frodo Baggins, after inheriting a mysterious ring from his uncle Bilbo, must leave his home in order to keep it from falling into the hands of its evil creator. Along the way, a fellowship is formed to protect the ringbearer and make sure that the ring arrives at its final destination: Mt. Doom, the only place where it can be destroyed.",
      "vote_average": 8.4,
      "vote_count": 23596,
      "image_url": "https://image.tmdb.org/t/p/w500/6oom5QYQ2yQTMJIbnvbkBL9cHo6.jpg",
      "category": {
        "id": 1,
        "kind": "filme"
      },
      "genre": {
        "id": 2,
        "kind": "aventura"
      }
    }
  }
]
```

#### Listar categorias

* GET http://localhost:3000/categories

retorno:

```json
[
  {
    "category": {
      "id": 1,
      "kind": "filme"
    }
  },
  {
    "category": {
      "id": 2,
      "kind": "série"
    }
  }
]
```

#### Listar gêneros

* GET http://localhost:3000/genres

retorno:

```json
[
  {
    "genre": {
      "id": 1,
      "kind": "ação"
    }
  },
  {
    "genre": {
      "id": 2,
      "kind": "aventura"
    }
  }
]
```

#### Listar catálogos

* http://localhost:3000/catalogs?page=1&per=2

retorno:

```json
{
  "total_count": 8,
  "per_page": 2,
  "page": 1,
  "results": [
    {
      "catalog": {
        "id": 1,
        "category_id": 1,
        "genre_id": 1,
        "format_title": "Duro De Matar",
        "summed_rating": 3,
        "original_title": "Die Hard",
        "release_date": "15/07/1988",
        "overview": "NYPD cop John McClane's plan to reconcile with his estranged wife is thrown for a serious loop when, minutes after he arrives at her office, the entire building is overtaken by a group of terrorists. With little help from the LAPD, wisecracking McClane sets out to single-handedly rescue the hostages and bring the bad guys down.",
        "vote_average": 7.78,
        "vote_count": 10335,
        "image_url": "https://image.tmdb.org/t/p/w500/yFihWxQcmqcaBR31QM6Y8gT6aYV.jpg",
        "category": {
          "id": 1,
          "kind": "filme"
        },
        "genre": {
          "id": 1,
          "kind": "ação"
        }
      }
    },
    {
      "catalog": {
        "id": 2,
        "category_id": 1,
        "genre_id": 1,
        "format_title": "Mad Max: Estrada Da Fúria",
        "summed_rating": 3,
        "original_title": "Mad Max: Fury Road",
        "release_date": "13/05/2015",
        "overview": "An apocalyptic story set in the furthest reaches of our planet, in a stark desert landscape where humanity is broken, and most everyone is crazed fighting for the necessities of life. Within this world exist two rebels on the run who just might be able to restore order.",
        "vote_average": 7.585,
        "vote_count": 21098,
        "image_url": "https://image.tmdb.org/t/p/w500/hA2ple9q4qnwxp3hKVNhroipsir.jpg",
        "category": {
          "id": 1,
          "kind": "filme"
        },
        "genre": {
          "id": 1,
          "kind": "ação"
        }
      }
    }
  ]
}
```

> Importante: Se não informar `page=1` e `per=2` irá retornar a página 1 com 6 itens.

### Interagindo na tela

#### Inserir uma palavra chave para visualizar os catálogs

* GET http://localhost:3000/catalogs?like=max

retorno:

```json
{
  "total_count": 1,
  "per_page": 6,
  "page": 1,
  "results": [
    {
      "catalog": {
        "id": 2,
        "category_id": 1,
        "genre_id": 1,
        "format_title": "Mad Max: Estrada Da Fúria",
        "summed_rating": 3,
        "original_title": "Mad Max: Fury Road",
        "release_date": "13/05/2015",
        "overview": "An apocalyptic story set in the furthest reaches of our planet, in a stark desert landscape where humanity is broken, and most everyone is crazed fighting for the necessities of life. Within this world exist two rebels on the run who just might be able to restore order.",
        "vote_average": 7.585,
        "vote_count": 21098,
        "image_url": "https://image.tmdb.org/t/p/w500/hA2ple9q4qnwxp3hKVNhroipsir.jpg",
        "category": {
          "id": 1,
          "kind": "filme"
        },
        "genre": {
          "id": 1,
          "kind": "ação"
        }
      }
    }
  ]
}
```

#### Clicar em uma categoria específica para visualizar os catálogos

* GET http://localhost:3000/categories/1/catalogs?page=1&per=2

retorno:

```json
{
  "total_count": 4,
  "per_page": 2,
  "page": 1,
  "results": [
    {
      "catalog": {
        "id": 1,
        "category_id": 1,
        "genre_id": 1,
        "format_title": "Duro De Matar",
        "summed_rating": 3,
        "original_title": "Die Hard",
        "release_date": "15/07/1988",
        "overview": "NYPD cop John McClane's plan to reconcile with his estranged wife is thrown for a serious loop when, minutes after he arrives at her office, the entire building is overtaken by a group of terrorists. With little help from the LAPD, wisecracking McClane sets out to single-handedly rescue the hostages and bring the bad guys down.",
        "vote_average": 7.78,
        "vote_count": 10335,
        "image_url": "https://image.tmdb.org/t/p/w500/yFihWxQcmqcaBR31QM6Y8gT6aYV.jpg",
        "category": {
          "id": 1,
          "kind": "filme"
        },
        "genre": {
          "id": 1,
          "kind": "ação"
        }
      }
    },
    {
      "catalog": {
        "id": 2,
        "category_id": 1,
        "genre_id": 1,
        "format_title": "Mad Max: Estrada Da Fúria",
        "summed_rating": 3,
        "original_title": "Mad Max: Fury Road",
        "release_date": "13/05/2015",
        "overview": "An apocalyptic story set in the furthest reaches of our planet, in a stark desert landscape where humanity is broken, and most everyone is crazed fighting for the necessities of life. Within this world exist two rebels on the run who just might be able to restore order.",
        "vote_average": 7.585,
        "vote_count": 21098,
        "image_url": "https://image.tmdb.org/t/p/w500/hA2ple9q4qnwxp3hKVNhroipsir.jpg",
        "category": {
          "id": 1,
          "kind": "filme"
        },
        "genre": {
          "id": 1,
          "kind": "ação"
        }
      }
    }
  ]
}
```

> Importante: Se não informar `page=1` e `per=2` irá retornar a página 1 com 6 itens.

#### Clicar em um genero específico para visualizar os catálogos

* GET http://localhost:3000/genres/1/catalogs?page=1&per=2

retorno:

```json
{
  "total_count": 4,
  "per_page": 2,
  "page": 1,
  "results": [
    {
      "catalog": {
        "id": 1,
        "category_id": 1,
        "genre_id": 1,
        "format_title": "Duro De Matar",
        "summed_rating": 3,
        "original_title": "Die Hard",
        "release_date": "15/07/1988",
        "overview": "NYPD cop John McClane's plan to reconcile with his estranged wife is thrown for a serious loop when, minutes after he arrives at her office, the entire building is overtaken by a group of terrorists. With little help from the LAPD, wisecracking McClane sets out to single-handedly rescue the hostages and bring the bad guys down.",
        "vote_average": 7.78,
        "vote_count": 10335,
        "image_url": "https://image.tmdb.org/t/p/w500/yFihWxQcmqcaBR31QM6Y8gT6aYV.jpg",
        "category": {
          "id": 1,
          "kind": "filme"
        },
        "genre": {
          "id": 1,
          "kind": "ação"
        }
      }
    },
    {
      "catalog": {
        "id": 2,
        "category_id": 1,
        "genre_id": 1,
        "format_title": "Mad Max: Estrada Da Fúria",
        "summed_rating": 3,
        "original_title": "Mad Max: Fury Road",
        "release_date": "13/05/2015",
        "overview": "An apocalyptic story set in the furthest reaches of our planet, in a stark desert landscape where humanity is broken, and most everyone is crazed fighting for the necessities of life. Within this world exist two rebels on the run who just might be able to restore order.",
        "vote_average": 7.585,
        "vote_count": 21098,
        "image_url": "https://image.tmdb.org/t/p/w500/hA2ple9q4qnwxp3hKVNhroipsir.jpg",
        "category": {
          "id": 1,
          "kind": "filme"
        },
        "genre": {
          "id": 1,
          "kind": "ação"
        }
      }
    }
  ]
}
```

> Importante: Se não informar `page=1` e `per=2` irá retornar a página 1 com 6 itens.

## Tela de visualizar um catálogo

### Antes de interagir na tela

#### Visualizar usuário logado

* GET http://localhost:3000/current_user_info -H { "Authorization": "Bearer abcd1234.dcba4321.q1w2e3r4" }

retorno:

```json
{
  "id": 2,
  "email": "del@hills.example",
  "name": "Maria Valentina Ribeiro"
}
```

> Importante: esta requisição só é necessária para interagir com o usuário, por exemplo: "Olá Maria Valentina Ribeiro, tudo bem?".

#### Listar um catálogo

* GET http://localhost:3000/catalogs/1

retorno:

```json
{
  "catalog": {
    "id": 1,
    "category_id": 1,
    "genre_id": 1,
    "format_title": "Duro De Matar",
    "summed_rating": 3,
    "original_title": "Die Hard",
    "release_date": "15/07/1988",
    "overview": "NYPD cop John McClane's plan to reconcile with his estranged wife is thrown for a serious loop when, minutes after he arrives at her office, the entire building is overtaken by a group of terrorists. With little help from the LAPD, wisecracking McClane sets out to single-handedly rescue the hostages and bring the bad guys down.",
    "vote_average": 7.78,
    "vote_count": 10335,
    "image_url": "https://image.tmdb.org/t/p/w500/yFihWxQcmqcaBR31QM6Y8gT6aYV.jpg",
    "category": {
      "id": 1,
      "kind": "filme"
    },
    "genre": {
      "id": 1,
      "kind": "ação"
    }
  }
}
```

#### Listar as avaliações do catálogo

* GET http://localhost:3000/catalogs/2/reviews -H { "Authorization": "Bearer abcd1234.dcba4321.q1w2e3r4" }

retorno:

```json
{
  "current_user_reviews": [
    {
      "review": {
        "id": 2,
        "rating": 1,
        "comment": "Odio iusto minima. Assumenda qui quibusdam. Consequatur voluptas explicabo.",
        "catalog_id": 2,
        "user_id": 2,
        "good?": false,
        "neutral?": false,
        "bad?": true,
        "format_updated_at": "03/12/2023 16:22:06",
        "user": {
          "id": 2,
          "name": "Maria Valentina Ribeiro"
        }
      }
    }
  ],
  "other_reviews": [
    {
      "review": {
        "id": 3,
        "rating": 2,
        "comment": "Accusamus qui rerum. Molestiae aut quas. Et voluptatem est.",
        "catalog_id": 2,
        "user_id": 1,
        "good?": false,
        "neutral?": false,
        "bad?": true,
        "format_updated_at": "03/12/2023 16:22:06",
        "user": {
          "id": 1,
          "name": "Alessandro Casqueira Neto"
        }
      }
    }
  ]
}
```

> Importante: não é obrigatório informar um token, mas se não informar (ou o token informado estiver inválido/vencido) a chave `current_user_reviews` retornará um array vazio.

### Interagindo na tela

#### Clicar em adicionar avaliação

* POST http://localhost:3000/catalogs/2/reviews -H { "Authorization": "Bearer abcd1234.dcba4321.q1w2e3r4" }

dados:

```json
{
  "review": {
    "rating": "5",
    "comment": "Quia debitis eaque. Voluptatum aliquam aspernatur. Et et itaque."
  }
}
```

#### Clicar em editar avaliação

* PUT http://localhost:3000/catalogs/2/reviews/2 -H { "Authorization": "Bearer abcd1234.dcba4321.q1w2e3r4" }

dados:

```json
{
  "review": {
    "rating": "3",
    "comment": "Ipsa quo itaque. Quam esse odio. Possimus illum sapiente."
  }
}
```

#### Clicar em deletar avaliação

* DELETE http://localhost:3000/catalogs/2/reviews/2 -H { "Authorization": "Bearer abcd1234.dcba4321.q1w2e3r4" }
