


# # ZSSN (Zombie Survival Social Network)

##   Data Modeling

Please find below the data modeling for the database:
![image info](https://i.ibb.co/qNSr28m/Screenshot-from-2023-05-10-03-28-06.png)

## Running server

* To start the server, simply execute the command below:

  ```
    docker-compose build
    docker-compose up
  ```

## Running tests

* To run the project tests:

  ```
    docker-compose run web bundle exec rspec .
  ```

## Request
##### endpoint
 `GET /api/v1/reports/average_items_per_user`
##### return
```
{
   "result":[
      {
         "water":"On average, each user has 2.86 water"
      },
      {
         "food":"On average, each user has 0.14 food"
      },
      {
         "medicine":"On average, each user has 6.57 medicine"
      },
      {
         "ammunition":"On average, each user has 148.71 ammunition"
      }
   ]
}
```

##### endpoint
`GET /api/v1/reports/lost_points`
##### return
```
{
   "result":{
      "lost_points":"80.0 user points are lost by infected users"
   }
}
```

##### endpoint
`GET /api/v1/reports/not_infected_percentage`
##### return
```
{
   "result":{
      "not_infected_users":"85.71% of users are not infected"
   }
}
```

##### endpoint
`GET /api/v1/reports/infected_percentage`
##### return
```
{
   "result":{
      "infected_users":"14.29% of users are infected"
   }
}
```

##### endpoint
 `POST /api/v1/users/create`

 ##### Params
![image info](https://i.imgur.com/G84GDcc.png)

The request body must follow the following pattern:
```
{
   "name":"ovo da silva sauro",
   "age":19,
   "gender":"male",
   "position":{
      "lat":"212324",
      "long":"1231"
   }
}
```


##### return
Success:
```
{
    "result": "success"
}
```
Fail:
```
{
   "result":"failed",
   "error":{
      "field":[
         "is missing"
      ]
   }
}
```

##### endpoint
 `POST /api/v1/users/trade_user_items`

 ##### Params
![image info](https://i.imgur.com/G84GDcc.png)

The request body must follow the following pattern:
```
{
   "proposer_user":{
      "id":1,
      "items":[
         {
            "item_id":1,
            "name":"water",
            "quantity":"15"
         }
      ]
   },
   "accepting_user":{
      "id":3,
      "items":[
         {
            "item_id":3,
            "name":"medicine",
            "quantity":"20"
         },
         {
            "item_id":4,
            "name":"ammunition",
            "quantity":"20"
         }
      ]
   }
}
```


##### return
Success:
```
{
    "result": "success"
}
```
Fail:
```
{
   "result":"failed",
   "error":{
      "field":[
         "is missing"
      ]
   }
}
```

##### endpoint
 `PUT /api/v1/users/update_user_items`

 ##### Params
![image info](https://i.imgur.com/G84GDcc.png)

The request body must follow the following pattern:
```
{
   "user_id":6,
   "items":[
      {
         "name":"food",
         "quantity":"1"
      },
      {
         "name":"ammunition",
         "quantity":"1"
      }
   ]
}
```


##### return
Success:
```
{
    "result": "success"
}
```
Fail:
```
{
   "result":"failed",
   "error":{
      "field":[
         "is missing"
      ]
   }
}
```

##### endpoint
 `PUT /api/v1/users/mark_as_infected`

 ##### Params
![image info](https://i.imgur.com/G84GDcc.png)

The request body must follow the following pattern:
```
{
   "user_id":1,
   "informant_id":4
}
```


##### return
Success:
```
{
    "result": "success"
}
```
Fail:
```
{
   "result":"failed",
   "error":{
      "user_id":[
         "user_id should be present to report an infected user"
      ]
   }
}
```

##### endpoint
 `DELETE /api/v1/users/mark_as_infected`

 ##### Params
![image info](https://i.imgur.com/G84GDcc.png)

The request body must follow the following pattern:
```
{
   "user_id":1,
   "items":["water", "food"]
}
```


##### return
Success:
```
{
    "result": "success"
}
```
Fail:
```
{
   "result":"failed",
   "error":{
      "items":[
         "is missing"
      ]
   }
}
```