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
      "overview": "Em uma terra fantástica e única, um hobbit recebe de presente de seu tio um anel mágico e maligno que precisa ser destruído antes que caia nas mãos do mal. Para isso, o hobbit Frodo tem um caminho árduo pela frente, onde encontra perigo, medo e seres bizarros. Ao seu lado para o cumprimento desta jornada, ele aos poucos pode contar com outros hobbits, um elfo, um anão, dois humanos e um mago, totalizando nove pessoas que formam a Sociedade do Anel.",
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
        "overview": "O policial de Nova York John McClane está visitando sua família no Natal. Ele participa de uma confraternização de fim de ano na sede da empresa japonesa em que a esposa trabalha. A festa é interrompida por terroristas que invadem o edifício de luxo. McClane não demora a perceber que não há ninguém para salvá-los, a não ser ele próprio.",
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
        "overview": "Em um mundo apocalíptico, Max Rockatansky acredita que a melhor forma de sobreviver é não depender de ninguém. Porém, após ser capturado pelo tirano Immortan Joe e seus rebeldes, Max se vê no meio de uma guerra mortal, iniciada pela imperatriz Furiosa que tenta salvar um grupo de garotas. Também tentando fugir, Max aceita ajudar Furiosa. Dessa vez, o tirano Joe está ainda mais implacável pois teve algo insubstituível roubado.",
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
        "overview": "Em um mundo apocalíptico, Max Rockatansky acredita que a melhor forma de sobreviver é não depender de ninguém. Porém, após ser capturado pelo tirano Immortan Joe e seus rebeldes, Max se vê no meio de uma guerra mortal, iniciada pela imperatriz Furiosa que tenta salvar um grupo de garotas. Também tentando fugir, Max aceita ajudar Furiosa. Dessa vez, o tirano Joe está ainda mais implacável pois teve algo insubstituível roubado.",
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
        "overview": "O policial de Nova York John McClane está visitando sua família no Natal. Ele participa de uma confraternização de fim de ano na sede da empresa japonesa em que a esposa trabalha. A festa é interrompida por terroristas que invadem o edifício de luxo. McClane não demora a perceber que não há ninguém para salvá-los, a não ser ele próprio.",
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
        "overview": "Em um mundo apocalíptico, Max Rockatansky acredita que a melhor forma de sobreviver é não depender de ninguém. Porém, após ser capturado pelo tirano Immortan Joe e seus rebeldes, Max se vê no meio de uma guerra mortal, iniciada pela imperatriz Furiosa que tenta salvar um grupo de garotas. Também tentando fugir, Max aceita ajudar Furiosa. Dessa vez, o tirano Joe está ainda mais implacável pois teve algo insubstituível roubado.",
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
        "overview": "O policial de Nova York John McClane está visitando sua família no Natal. Ele participa de uma confraternização de fim de ano na sede da empresa japonesa em que a esposa trabalha. A festa é interrompida por terroristas que invadem o edifício de luxo. McClane não demora a perceber que não há ninguém para salvá-los, a não ser ele próprio.",
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
        "overview": "Em um mundo apocalíptico, Max Rockatansky acredita que a melhor forma de sobreviver é não depender de ninguém. Porém, após ser capturado pelo tirano Immortan Joe e seus rebeldes, Max se vê no meio de uma guerra mortal, iniciada pela imperatriz Furiosa que tenta salvar um grupo de garotas. Também tentando fugir, Max aceita ajudar Furiosa. Dessa vez, o tirano Joe está ainda mais implacável pois teve algo insubstituível roubado.",
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
    "overview": "O policial de Nova York John McClane está visitando sua família no Natal. Ele participa de uma confraternização de fim de ano na sede da empresa japonesa em que a esposa trabalha. A festa é interrompida por terroristas que invadem o edifício de luxo. McClane não demora a perceber que não há ninguém para salvá-los, a não ser ele próprio.",
    "vote_average": 7.78,
    "vote_count": 10341,
    "image_url": "https://image.tmdb.org/t/p/w500/rauTKnFle1sp4aXjtYgx4tCWNiK.jpg",
    "category": {
      "id": 1,
      "kind": "filme"
    },
    "genre": {
      "id": 1,
      "kind": "ação"
    }
  },
  "cast": [
    {
      "name": "Bruce Willis",
      "character": "John McClane",
      "profile_path": "https://image.tmdb.org/t/p/w500/eKzKdhqk3RnGTeDju1eOBxdOk3c.jpg"
    },
    {
      "name": "Alan Rickman",
      "character": "Hans Gruber",
      "profile_path": "https://image.tmdb.org/t/p/w500/7tADZs4ILE93oJ5pAh6mKQFEq2m.jpg"
    },
    {
      "name": "Alexander Godunov",
      "character": "Karl",
      "profile_path": "https://image.tmdb.org/t/p/w500/ubA1t1Rj3dpDZkgli5D17Py0OPh.jpg"
    },
    {
      "name": "Bonnie Bedelia",
      "character": "Holly Gennaro McClane",
      "profile_path": "https://image.tmdb.org/t/p/w500/10JhoIaKHQGG0DNbQECTI4gHNn9.jpg"
    },
    {
      "name": "Reginald VelJohnson",
      "character": "Al Powell",
      "profile_path": "https://image.tmdb.org/t/p/w500/78x1ceFIKI8DHfEEj9dg4JrGwPa.jpg"
    },
    {
      "name": "Paul Gleason",
      "character": "Dwayne Robinson",
      "profile_path": "https://image.tmdb.org/t/p/w500/a7PJofFcVpDxw2wAak1d56J7L4k.jpg"
    },
    {
      "name": "De'voreaux White",
      "character": "Argyle",
      "profile_path": "https://image.tmdb.org/t/p/w500/hs2muiYO5VLemomsWalZqOiSQpm.jpg"
    },
    {
      "name": "William Atherton",
      "character": "Richard Thornburg",
      "profile_path": "https://image.tmdb.org/t/p/w500/S9W4deKuEa2K12ZiXwlvrC6J4U.jpg"
    },
    {
      "name": "Hart Bochner",
      "character": "Harry Ellis",
      "profile_path": "https://image.tmdb.org/t/p/w500/nfC2ByTNS3xoygwYVbUYsx2Zae6.jpg"
    },
    {
      "name": "James Shigeta",
      "character": "Joseph Yoshinobu Takagi",
      "profile_path": "https://image.tmdb.org/t/p/w500/HtXVBHBPPHaNpQ8FVefB3AB9Rn.jpg"
    },
    {
      "name": "Bruno Doyon",
      "character": "Franco",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Andreas Wisniewski",
      "character": "Tony",
      "profile_path": "https://image.tmdb.org/t/p/w500/sTI9mDwajw4j6HX3Ze4qoK3lhE7.jpg"
    },
    {
      "name": "Clarence Gilyard Jr.",
      "character": "Theo",
      "profile_path": "https://image.tmdb.org/t/p/w500/mTxlCE2RqtRK4NehoX70n2NKmjO.jpg"
    },
    {
      "name": "Joey Plewa",
      "character": "Alexander",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Lorenzo Caccialanza",
      "character": "Marco",
      "profile_path": "https://image.tmdb.org/t/p/w500/4lUFz3Sgp0DOPlt0PbiyuAqENV.jpg"
    },
    {
      "name": "Gerard Bonn",
      "character": "Kristoff",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Dennis Hayden",
      "character": "Eddie",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Al Leong",
      "character": "Uli",
      "profile_path": "https://image.tmdb.org/t/p/w500/zC01uEOvbdTQIg19LKVu5r2QKan.jpg"
    },
    {
      "name": "Gary Roberts",
      "character": "Heinrich",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Hans Buhringer",
      "character": "Fritz",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Wilhelm von Homburg",
      "character": "James",
      "profile_path": "https://image.tmdb.org/t/p/w500/dfX2YeRSHQusMcddYn5Db7aEv09.jpg"
    },
    {
      "name": "Robert Davi",
      "character": "Big Johnson",
      "profile_path": "https://image.tmdb.org/t/p/w500/yizOUAKs59CwKM6pU30gIP9gTup.jpg"
    },
    {
      "name": "Grand L. Bush",
      "character": "Little Johnson",
      "profile_path": "https://image.tmdb.org/t/p/w500/iebc00VeSoRkzkvB5D35hTBbFxa.jpg"
    },
    {
      "name": "Bill Marcus",
      "character": "City Engineer",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Rick Ducommun",
      "character": "Walt",
      "profile_path": "https://image.tmdb.org/t/p/w500/usW5QTa85JuonyRktb3s5HjDD84.jpg"
    },
    {
      "name": "Matt Landers",
      "character": "Captain Mitchell",
      "profile_path": "https://image.tmdb.org/t/p/w500/y9Eym5hhdGg8lGXYIIz5P2qIQO6.jpg"
    },
    {
      "name": "Carmine Zozzora",
      "character": "Rivers",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Dustyn Taylor",
      "character": "Ginny",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "George Christy",
      "character": "Dr. Hasseldorf",
      "profile_path": "https://image.tmdb.org/t/p/w500/u3y2QXhsOlOdHYSQ87skmQ2uBKz.jpg"
    },
    {
      "name": "Anthony Peck",
      "character": "Young Cop",
      "profile_path": "https://image.tmdb.org/t/p/w500/laqLC8e50wvH6LeRvJmMPbqtNbr.jpg"
    },
    {
      "name": "Cheryl Baker",
      "character": "Woman",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Richard Parker",
      "character": "Man",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "David Ursin",
      "character": "Harvey Johnson",
      "profile_path": "https://image.tmdb.org/t/p/w500/trBIE7zB4nlXo8hxNsr27EvrJq9.jpg"
    },
    {
      "name": "Mary Ellen Trainor",
      "character": "Gail Wallens",
      "profile_path": "https://image.tmdb.org/t/p/w500/Y926jxSOXikBiqQIptho1VzU9o.jpg"
    },
    {
      "name": "Harri James",
      "character": "Police Supervisor",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Shelley Pogoda",
      "character": "Dispatcher",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Selma Archerd",
      "character": "Hostage",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Scot Bennett",
      "character": "Hostage",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Rebecca Broussard",
      "character": "Hostage",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Kate Finlayson",
      "character": "Hostage",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Shanna Higgins",
      "character": "Hostage",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Kym Malin",
      "character": "Hostage",
      "profile_path": "https://image.tmdb.org/t/p/w500/8SwDz9qTVscYoA5IvpRrjyJU3eE.jpg"
    },
    {
      "name": "Taylor Fry",
      "character": "Lucy McClane",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Noah Land",
      "character": "John McClane Jr.",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Betty Carvalho",
      "character": "Paulina",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Kip Waldo",
      "character": "Convenience Store Clerk",
      "profile_path": "https://image.tmdb.org/t/p/w500/netvdsQNDgFKqwLmtM75Di6DpX1.jpg"
    },
    {
      "name": "Mark Goldstein",
      "character": "Station Manager",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Tracy Reiner",
      "character": "Thornburg's Assistant",
      "profile_path": "https://image.tmdb.org/t/p/w500/tfIh2dPe4tGITdlsPZXBNeqvZwW.jpg"
    },
    {
      "name": "Rick Cicetti",
      "character": "Guard",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Fred Lerner",
      "character": "Guard",
      "profile_path": "https://image.tmdb.org/t/p/w500/pkuaIXJKC8ETC66Rtybtnk63xlY.jpg"
    },
    {
      "name": "Bill Margolin",
      "character": "Producer",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Bob Jennings",
      "character": "Cameraman",
      "profile_path": "https://image.tmdb.org/t/p/w500/iopvj0A8nTYNnpGH28lvbmF7LGa.jpg"
    },
    {
      "name": "Bruce P. Schultz",
      "character": "Cameraman",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "David Katz",
      "character": "Soundman",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Robert Lesser",
      "character": "Businessman",
      "profile_path": "https://image.tmdb.org/t/p/w500/jPwr4Pf9U86UxKnGZY2UR04Aqzl.jpg"
    },
    {
      "name": "Stella Hall",
      "character": "Stewardess",
      "profile_path": "https://image.tmdb.org/t/p/w500/hxhaDkZbgOGJ56qZUI7sHMTXVtV.jpg"
    },
    {
      "name": "Terri Lynn Doss",
      "character": "Girl at Airport",
      "profile_path": "https://image.tmdb.org/t/p/w500/3E5BSObTf6yAG8cfWt61ymvLsK2.jpg"
    },
    {
      "name": "Jon E. Greene",
      "character": "Boy at Airport",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "P. Randall Bowers",
      "character": "Kissing Man",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Michele Laybourn",
      "character": "Girl in Window",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Charlie Picerni",
      "character": "Dwayne Robinson's Driver (uncredited)",
      "profile_path": "https://image.tmdb.org/t/p/w500/kRO5tGbhZOPnUH46keu01i5UYd.jpg"
    },
    {
      "name": "Conrad Hurtt",
      "character": "SWAT (uncredited)",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Terry Ray",
      "character": "SWAT (uncredited)",
      "profile_path": "https://image.tmdb.org/t/p/w500"
    },
    {
      "name": "Eric Kay",
      "character": "Fireman (uncredited)",
      "profile_path": "https://image.tmdb.org/t/p/w500/lQJ9bPY6EbQMTX8Mk6BMiMFzxpv.jpg"
    }
  ]
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
