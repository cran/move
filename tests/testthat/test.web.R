context("webtests")
test_that("login",{
  expect_s4_class(movebankLogin("asdf","asdf"),"MovebankLogin")
  expect_silent(a<-movebankLogin("asdf","asdf"))
  
  expect_error(movebankLogin("asdf",234))
  expect_error(movebankLogin("asdf",factor("a")))
  expect_error(movebankLogin("asdf",login=234))
  expect_s4_class(movebankLogin(),"MovebankLogin")
  
  })
test_that('false login',{
		  skip_on_os('solaris')
  l<-movebankLogin("asdf","asdf")  
  expect_error(getMovebankStudies(l),"There are no valid credentials"       )
  expect_error(getMovebankData("BCI Ocelot",login=l),"There are no valid credentials"       )
  expect_error(getMovebankStudy("BCI Ocelot",login=l),"There are no valid credentials"        )
  expect_error(getMovebankAnimals("BCI Ocelot",login=l),"There are no valid credentials"        )
  expect_error(getMovebankSensors("BCI Ocelot",login=l),"There are no valid credentials"         )

  expect_error(getMovebankSensors(login=l),"There are no valid credentials"         )
  expect_error(getMovebankSensors(123413,login=l),"There are no valid credentials"       )
  expect_error(getMovebankData(123413,login=l),"There are no valid credentials"       )
  expect_error(getMovebankData(123413, animalName=c("Mancha","Yara"), login=l),"There are no valid credentials"       )
  expect_error(getMovebankSensorsAttributes(123413, login=l),"There are no valid credentials"       )
  expect_error(getMovebankSensorsAttributes("BCI Ocelot", login=l),"There are no valid credentials"       )
  expect_error(getMovebankLocationData("BCI Ocelot", login=l),"There are no valid credentials"       )
  expect_error(getMovebankNonLocationData("BCI Ocelot", login=l),"There are no valid credentials"       )
  expect_error(getMovebankReferenceTable("BCI Ocelot", login=l),"There are no valid credentials"       )
  
})
test_that('without login',{
    skip_on_os('solaris')
    expect_error(getMovebank('tag_type'),"There are no credentials")
    expect_error(getMovebankSensors(),"There are no credentials"       )
    expect_error(getMovebankStudies(),"There are no credentials" )
    expect_error(getMovebankData("BCI Ocelot"),"There are no credentials" )
    expect_error(getMovebankStudy("BCI Ocelot"),"There are no credentials" )
    expect_error(getMovebankAnimals("BCI Ocelot"),"There are no credentials"        )
    expect_error(getMovebankSensorsAttributes("BCI Ocelot"),"There are no credentials"        )
    expect_error(getMovebankLocationData("BCI Ocelot"),"There are no credentials" )
    expect_error(getMovebankNonLocationData("BCI Ocelot"),"There are no credentials"    )
    expect_error(getMovebankReferenceTable("BCI Ocelot"),"There are no credentials"       )
    
  })
