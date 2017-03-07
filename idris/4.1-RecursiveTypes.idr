data Shape = Triangle Double Double
           | Rectangle Double Double
           | Circle Double
%name Shape shape1, shape2

data Picture = Primitive Shape
             | Combine Picture Picture
             | Rotate Double Picture
             | Translate Double Double Picture
%name Picture pic1, pic2

--- %name directives are _awesome_
area : Picture -> Double
area (Primitive shape1) = ?area_rhs_1
area (Combine pic1 pic2) = ?area_rhs_2
area (Rotate x pic1) = ?area_rhs_3
area (Translate x y pic1) = ?area_rhs_4

rectangle : Picture
rectangle = Primitive (Rectangle 20 10)

circle : Picture
circle = Primitive (Circle 5)

triangle : Picture
triangle = Primitive (Triangle 10 10)

testPicture : Picture
testPicture = Combine (Translate 5 5 rectangle)
                      (Combine (Translate 35 5 circle)
                               (Rotate 5 (Translate 15 25 triangle)))
