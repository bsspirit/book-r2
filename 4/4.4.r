library(pryr)

User<-setRefClass("User",fields=list(name="character"))
User
u1<-User$new(name="u1")
u1
class(User)
is.object(User)
otype(User)
class(u1)
is.object(u1)
otype(u1)

User<-setRefClass("User",fields=list(name="character"))
Member<-setRefClass("Member",
   contains="User",
   fields=list(manager="User")
)
manager<-User$new(name="manager")
member<-Member$new(name="member",manager=manager)
member
member$name
member$manager
otype(member$name)
otype(member$manager)

User<-setRefClass("User",
   fields=list(name="character",level='numeric'),
   methods=list(
      initialize = function(name,level){
          print("User::initialize")
          name <<- 'conan'
          level <<- 1
       }
   )
)
u1<-User$new()
u1

User<-setRefClass("User",fields=list(name="character",age="numeric",gender="factor"))
genderFactor<-factor(c('F','M'))
u1<-User$new(name="u1",age=44,gender=genderFactor[1])
u1$age
u1$age<-10
u1$age
u2<-u1
u2$age
u1$age<-20
u1$age
u2$age
u3<-u1$copy()
u3$age
u1$age<-30
u1$age
u3$age

User<-setRefClass("User",
   fields=list(name="character",favorite="vector"),
   methods = list(
       addFavorite = function(x) {
           favorite <<- c(favorite,x)
       },
       delFavorite = function(x) {
           favorite <<- favorite[-which(favorite == x)]
       },
       setFavorite = function(x) {
           favorite <<- x
       }
   )
)
u1<-User$new(name="u1",favorite=c('movie','football'))    # 实例化对象u1
u1
u1$delFavorite('football')
u1$favorite
u1$addFavorite('shopping')
u1$favorite
u1$setFavorite('reading')
u1$favorite

User<-setRefClass("User",
    fields=list(name="character",level='numeric'),
    methods=list(
      initialize = function(name,level){
        print("User::initialize")
        name <<- 'conan'
        level <<- 1
      },
      addLevel = function(x) {
        print('User::addLevel')
        level <<- level+x
      },
      addHighLevel = function(){
        print('User::addHighLevel')
        addLevel(2)
      }
    )
)
Member<-setRefClass("Member",contains="User",
    fields=list(age='numeric'),
    methods=list(
      addLevel = function(x) {
          print('Member::addLevel')
          callSuper(x)
          level <<- level+1
      }
    )
)
u1<-User$new(name='u1',level=10)
u1
u1$initFields(name='u1',level=10)
m1<-Member$new()
m1$initFields(name='m1',level=100,age=12)

u2<-u1$copy()
u1$addLevel(1);u1
u2
u1$field('level')
u1$field('level',1)
u1$level

m1$getRefClass()
m1$getClass()
otype(m1$getRefClass())
otype(m1$getClass())

m1$show()
show(m1)
m1

m1$trace("addLevel")
m1$addLevel(1)
m1$addHighLevel()
m1$untrace("addLevel")

m1$export('Member')
m1$export('User')

m2<-Member$new()
m2

m2$import(m1)
m2

m1$.self
identical(m1$.self,m1)
otype(m1$.self)
m1$.refClassDef
identical(m1$.refClassDef,m1$getClass())
otype(m1$.refClassDef)


User<-setRefClass("User",
    fields=list(name="character",level='numeric'),
    methods=list(
      initialize = function(name,level){
        print("User::initialize")
        name <<- 'conan'
        level <<- 1
      },
      addLevel = function(x) {
        print('User::addLevel')
        level <<- level+x
      },
      addHighLevel = function(){
        print('User::addHighLevel')
        addLevel(2)
      }
    )
)
u1<-User$new()
User$fields()
User$methods()
User$help("addLevel")
User$help("show")

User$accessors("level")
User$accessors("name")
User$methods()

User$trace('addLevel')
u3<-User$new(name='u3',level=1)
u3$addLevel(2)
User$lock("level")
User$lock()
u3<-User$new()
u3
#u3$level=1
#u3$addLevel(2)



Animal<-setRefClass("Animal",
  fields=list(name="character"),
  methods=list(
    initialize = function(name) name <<- 'Animal',
    bark = function() print("Animal::bark")
  )
)
Cat<-setRefClass("Cat",contains="Animal",
  methods=list(
    initialize = function(name) name <<- 'cat',
    bark = function() print(paste(name,"is miao miao"))
  )
)
Dog<-setRefClass("Dog",contains="Animal",
  methods=list(
    initialize = function(name) name <<- 'dog',
    bark = function() print(paste(name,"is wang wang"))
  )
)
Duck<-setRefClass("Duck",contains="Animal",
   methods=list(
     initialize = function(name) name <<- 'duck',
     bark = function() print(paste(name,"is ga ga"))
   )
)
cat<-Cat$new()
cat$name
cat$bark()
dog<-Dog$new()
dog$initFields(name='Huang')
dog$name
dog$bark()
duck<-Duck$new()
duck$bark()


Animal<-setRefClass("Animal",
   fields=list(name="character",limbs='numeric'),
   methods=list(
     initialize = function(name) {
        name <<- 'Animal'
        limbs<<-4
     },
     bark = function() print("Animal::bark")
  )
)
Cat<-setRefClass("Cat",contains="Animal",
   methods=list(
     initialize = function(name) {
       callSuper()
       name <<- 'cat'
     },
     bark = function() print(paste(name,"is miao miao"))
   )
)
Dog<-setRefClass("Dog",contains="Animal",
   methods=list(
     initialize = function(name) {
       callSuper()
       name <<- 'dog'
     },
     bark = function() print(paste(name,"is wang wang"))
   )
)
Duck<-setRefClass("Duck",contains="Animal",
  fields=list(wing='numeric'),
  methods=list(
    initialize = function(name) {
        name <<- 'duck'
        limbs<<- 2
        wing<<- 2
    },
    bark = function() print(paste(name,"is ga ga"))
  )
)
cat<-Cat$new();cat
dog<-Dog$new()
dog$initFields(name='Huang');dog
duck<-Duck$new();duck


Animal<-setRefClass("Animal",
  fields=list(name="character",limbs='numeric'),
  methods=list(
    initialize = function(name) {
      name <<- 'Animal'
      limbs<<-4
    },
    bark = function() print("Animal::bark"),
    action = function() print("I can walk on the foot")
  )
)
Cat<-setRefClass("Cat",contains="Animal",
   methods=list(
     initialize = function(name) {
       callSuper()
       name <<- 'cat'
     },
     bark = function() print(paste(name,"is miao miao")),
     action = function() {
       callSuper()
       print("I can Climb a tree")
     }
   )
)
Dog<-setRefClass("Dog",contains="Animal",
   methods=list(
     initialize = function(name) {
       callSuper()
       name <<- 'dog'
     },
     bark = function() print(paste(name,"is wang wang")),
     action = function() {
       callSuper()
       print("I can Swim.")
     }
   )
)
Duck<-setRefClass("Duck",contains="Animal",
   fields=list(wing='numeric'),
   methods=list(
      initialize = function(name) {
        name <<- 'duck'
        limbs<<- 2
        wing<<- 2
      },
      bark = function() print(paste(name,"is ga ga")),
      action = function() {
        callSuper()
        print("I can swim.")
        print("I also can fly a short way.")
     }
    )
)
cat<-Cat$new()
cat$action()
dog<-Dog$new()
dog$action()
duck<-Duck$new()
duck$action()

