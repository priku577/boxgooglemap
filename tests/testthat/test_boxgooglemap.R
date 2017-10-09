library(boxgooglemap)
library(testthat)

context("Coord")

test_that("Overall test",{
          expect_that(coord(address = 2),
                      throws_error("input should be acharacter"))
          expect_that(is.data.frame(coord(address = "ryds alle 1")),
                      is_true())
          expect_that(coord(address = "Changsha, Hunan, China")[,"lat"],
                      equals(28.2282090))
          expect_that(coord(address = "ryds alle 1,linkoping"),
                      equals(coord(address = "ryds alle 1")))
          expect_that(coord(address = "linkoping university"),
                      equals(coord(address="581 83 Linköping, Sweden")[1,]))
})

context("Address")

test_that("Overall test", {
          expect_that(address(latlong = 2),
                     throws_error("input should be character"))
          expect_that(address(latlong = "39.986913,  116.3058739"),
                      equals(address(latlong = "39.986913  116.3058739")))
          expect_that(address(latlong = "59.3481484 18.0236579")[1,"Full_address"],
                      equals("Nobels väg 15B, 171 65 Solna, Sweden"))
          expect_that(is.data.frame(address(latlong = "40.71818  -73.99005")),
                      is_true())
          expect_that(address(latlong = "2,3"),
                      throws_error("No match found"))
})





