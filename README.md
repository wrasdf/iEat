iEat
iEat Project

APIs:

1. Get all restaurant 

url : /restaurants
return json :
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

-----------------------------------------------------
2. Get all the actived groups of today

url : groups/active
return json:
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

----------------------------------------------------------------------------
3. Get all dishes in current restaurant, which releated to current group

url : groups/:id/dishes
return json:
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






