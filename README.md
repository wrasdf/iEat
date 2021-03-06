#iEat Apis:


## Get all restaurant API 
+ ajax type -> get
+ url : api/v1/restaurants
+ return json :

<pre>
[{
        "id": 1,
        "name": "九头鹰",
        "telephone": "84073084",
        "address": "东直门内大街10号楼7号"
    }, {
        "id": 2,
        "name": "李记桂林米粉",
        "telephone": "84033884/13161311387",
        "address": "东直门簋街5-3号哈哈镜对面"
    }
]
</pre>


## Get all the actived groups of today API
+ ajax type -> get
+ url : api/v1/groups/active
+ return json:

<pre>
[{
    "id": 15,
    "name": "23",
    "created_at": "2013-03-20T07:54:28Z",
    "due_date": "2013-03-20T16:54:00Z",
    "owner": {
        "id": 2,
        "name": "kerry",
        "email": "rwang@thoughtworks.com"
    },
    "restaurant": {
        "id": 1,
        "name": "九头鹰",
        "telephone": "84073084",
        "address": "东直门内大街10号楼7号"
    },
    "joined": false
}]
</pre>
"joined" --> means current user joined this group or not


## Get all dishes in current restaurant, which related to current group
+ ajax type -> get
+ url : api/v1/groups/:id/dishes
+ return json:

<pre>
[{
    "name": "炒菜",
    "dishes": [{
            "id": 1,
            "name": "清炒四季豆（Marina)",
            "price": 25.0
        }, {
            "id": 2,
            "name": "豌豆辣牛肉（Marina)",
            "price": 33.0
        }, {
            "id": 3,
            "name": "西红柿牛腩",
            "price": 15.0
        }
    ]        
},{
    "name": "主食",  // ---> for different cuisine 
    "dishes": [{
            "id": 4,
            "name": "三鲜炒面(原价18，会员价15)",
            "price": 15.0
        }, {
            "id": 5,
            "name": "热干面",
            "price": 6.0
        }, {
            "id": 6,
            "name": "牛肉粉",
            "price": 13.0
        }
    ]
}]
</pre>


## Get current group details API
+ ajax type -> get
+ url : api/v1/groups/:id
+ return json:

<pre>
{
    "id": 15,
    "restaurant": {
        "address": "东直门内大街10号楼7号",
        "created_at": "2013-03-20T03:05:02Z",
        "id": 1,
        "image_url": null,
        "name": "九头鹰",
        "note": "湖北菜",
        "telephone": "84073084",
        "updated_at": "2013-03-20T03:05:02Z"
    },
    "description": null,
    "due_date": "2013-03-20T16:54:00Z",
    "name": "23",
    "created_at": "2013-03-20T07:54:28Z",
    "owner": {
        "id": 2,
        "name": "kerry",
        "email": "rwang@thoughtworks.com"
    },
    "orders": [{
            "id" : 23,
            "user": {
                "id": 2,
                "name": "kerry",
                "email": "rwang@thoughtworks.com"
            },
            "order_dishes": [{
                    "id": 1,
                    "dish_id": 1,
                    "quantity": 1,
                    "name": "清炒四季豆（Marina)",
                    "price": 25.0
                }, {
                    "id": 2,
                    "dish_id": 2,
                    "quantity": 1,
                    "name": "豌豆辣牛肉（Marina)",
                    "price": 33.0
                }
            ]
        },
        {
            "id" : 24,
            "user": {
                "id": 1,
                "name": "Beany",
                "email": "mxzou@thoughtworks.com"
            },
            "order_dishes": [{
                    "id": 3,
                    "dish_id": 1,
                    "quantity": 3,
                    "name": "清炒四季豆",
                    "price": 25.0
                }, {
                    "id": 4,
                    "dish_id": 2,
                    "quantity": 2,
                    "name": "豌豆辣牛肉",
                    "price": 33.0
                }
            ]
        }
    ]
}
</pre>

## Get current group due_date API
+ ajax type -> get
+ url : api/v1/groups/:id/due_date
+ return json:
+ note : Time Zone is UTC 

<pre>
  {"id":11,"due_date":"2013-03-29T18:56:00Z","name":"XXXX"}
</pre>


## Create group API
+ ajax type -> Post
+ url : api/v1/groups/create
parametes: 

<pre>
{
	"due_date" : "17:22",
	"name"	 : "test",
	"restaurant_id"  :  "1"
}
</pre>


## Create user orders
+ ajax type -> Post
+ url : api/v1/groups/:group_id/orders/create

parametes: 
<pre>
{
    "dishes" : "[{"id":1,"quantity":"1"},{"id":2,"quantity":"1"}]"
}
</pre>

+ if out of due date will return 

<pre>
{
    "status" : "out_of_dueDate"
}
</pre>



## Get user unpaid & payback orders
+ ajax type -> Get
+ url : api/v1/mybills
+ return json:

<pre>
{
    "unpaid_orders": [{
            "id": 8,
            "created_at": "2013-03-22T02:50:00Z",
            "group": {
                "name": "Telstra",
                "user": {
                    "id": 2,
                    "name": "kerry",
                    "email": "rwang@thoughtworks.com"
                }
            },
            "user": {
                "name": "Zhifang",
                "email": "zfhu@thoughtwors.com",
                "telephone": null
            },
            "order_dishes": [{
                    "dish_id": 133,
                    "quantity": 1,
                    "name": "双菇三鲜(香菇、鲜蘑、猪肉)(1两)",
                    "price": 6.0
                }
            ]
        }
    ],
    "payback_orders": [{
            "id": 23,
            "created_at": "2013-03-28T07:26:59Z",
            "group": {
                "name": "xing",
                "user": {
                    "id": 3,
                    "name": "qingshan",
                    "email": "qszhuan@thoughtworks.com"
                }
            },
            "user": {
                "name": "kerry",
                "email": "rwang@thoughtworks.com",
                "telephone": null
            },
            "order_dishes": [{
                    "dish_id": 41,
                    "quantity": 1,
                    "name": "猪肚饭",
                    "price": 15.0
                }, {
                    "dish_id": 42,
                    "quantity": 1,
                    "name": "牛肚饭",
                    "price": 15.0
                }
            ]
        }
    ]]
}
</pre>

## Set user paid status

+ ajax type -> Get
+ url : api/v1/mybills/paid/:id


## User sign in

+ ajax type -> Post
+ url : api/v1/users/sign_in

parametes: 
<pre>
{
    "data" : "kerry" --> username or email
    "password" : "your password"
}
</pre>

## User sign up

+ ajax type -> Post
+ url : api/v1/users/sign_up

parametes: 
<pre>
{
    "email" : "xxx@xxx.com",
    "name" : "your name",
    "password" : "XXXXX",
    "password_confirmation" : "xxxxxxx",
    "telephone" : "xxxxxxx"
}
</pre>

## User sign out

+ ajax type -> get
+ url : api/v1/users/sign_get







