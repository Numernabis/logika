-- Ludwik Ciechanski
-- functional proofs based on Curry-Howard isomorphism

{-# LANGUAGE ScopedTypeVariables #-}

type A = Integer
type B = String
type C = Float
type D = Double

-- 1. Theorem impl_rozdz : (A -> B) -> (A -> C) -> A -> B -> C.
t1 :: (A -> B) -> (A -> C) -> A -> B -> C
t1 = \x -> \y -> \z -> \w -> y z

-- 2. Theorem impl_komp : (A -> B) -> (B -> C) -> A -> C.
t2 :: (A -> B) -> (B -> C) -> A -> C
t2 = \x -> \y -> \z -> y (x z)

-- 3. Theorem impl_perm : (A -> B -> C) -> B -> A -> C. 
t3 :: (A -> B -> C) -> B -> A -> C
t3 = \x -> \y -> \z -> x z y

-- 4. Theorem impl_conj : A -> B -> A /\ B. 
-- a pair = 2-element tuple
-- to create a tuple, put two arguments into parentheses
t4 :: A -> B -> (A, B) 
t4 = \x -> \y -> (x, y)

-- 5. Theorem conj_elim_l : A /\ B -> A. 
-- in order to extract first element of a pair use: fst (x,y) = x
-- similarly: snd (x,y) = y
t5 :: (A, B) -> A
t5 = \x -> fst x

-- 6. Theorem disj_intro_l : A -> A \/ B.
t6 :: A -> (Either A B)
t6 = \x -> Left x

-- 7. Theorem rozl_elim : A \/ B -> (A -> C) -> (B -> C) -> C. 
t7 :: (Either A B) -> (A -> C) -> (B -> C) -> C
t7 = \x -> \y -> \z -> either y z x

-- 8. Theorem diamencik : (A -> B) -> (A -> C) -> (B -> C -> D) -> A -> D.
t8 :: (A -> B) -> (A -> C) -> (B -> C -> D) -> A -> D
t8 = \x -> \y -> \z -> \w -> z (x w) (y w)

-- 9. Theorem slaby_peirce : ((((A -> B) -> A) -> A) -> B) -> B.
t9 :: ((((A -> B) -> A) -> A) -> B) -> B
t9 = \x -> x(\y -> y(\z -> x(\w -> z)))

-- 10. Theorem rozl_impl_rozdz : (A \/ B -> C) -> (A -> C) /\ (B -> C).
t10 :: (Either A B -> C) -> ((A -> C), (B -> C))
t10 = \x -> (\y -> x (Left y), \y -> x (Right y))
 
-- 11. Theorem rozl_impl_rozdz_odw : (A -> C) /\ (B -> C) -> A \/ B -> C.
t11 :: ((A -> C), (B -> C)) -> (Either A B) -> C
t11 = \x -> \y -> either (fst x) (snd x) y

-- 12. Theorem curry : (A /\ B -> C) -> A -> B -> C.
t12 :: ((A, B) -> C) -> A -> B -> C
t12 = \x -> \y -> \z -> x (y, z)

-- 13. Theorem uncurry : (A -> B -> C) -> A /\ B -> C.
t13 :: (A -> B -> C) -> (A, B) -> C
t13 = \x -> \y -> x (fst y) (snd y)

main = print("Magnificently, all proofs compiled correctly.")