(*
 * Zadanie domowe 1, czesc 1
 *  structure file
 *)
structure id291397 :> PART_ONE =
struct
  exception NotImplemented

  datatype 'a tree= Leaf of 'a | Node of 'a tree * 'a * 'a tree

  fun sum n = if n = 1 then 1 else n + sum(n - 1) 
  
  fun fac n = if n = 1 then 1 else n * fac(n - 1)
  
  fun fib n = 
		if n = 0 then 0 else
		if n = 1 then 1 else
		fib(n - 1) + fib(n - 2)
		
  fun gcd(a,0) = a
		| gcd(a,b) = gcd(b,a-b*(a div b))
  fun gcdi(a,0) = a
		| gcdi(a,b) = gcdi(b,a mod b) 		(*wersja opcjonalna*)
		
  fun max [] = raise Empty
		| max [x] = x
		| max(x::y::xs) =
			if (x > y) then max(x::xs) else max(y::xs)

			
  (* DRZEWKA *)
  fun sumTree (t:int tree) =
    case t of
      Leaf v => v
    | Node (left,v,right) => 
		v + sumTree (left) + sumTree (right)
	
  fun depth (t:'a tree) =
    case t of
      Leaf v => 0
    | Node (left, _, right) =>
        1 + (fn (x,y) => if x>y then x else y)(depth left,depth right);
	
  fun binSearch (t:int tree) (s:int) = 
    case t of
	  Leaf l => l=s
	| Node (left, v, right) =>
		if s=v then true
		else if s<v then binSearch left s
		else binSearch right s
		
  fun preorder (t:'a tree) = 
    case t of
	  Leaf l => [l]
	| Node (left, v, right) =>
		[v] @ preorder left @ preorder right
  
  
  (* LISTY *)
  fun listAdd (x:int list) [] = x
	| listAdd [] (y:int list) = y
	| listAdd (x:int list as gx::ox) (y:int list as gy::oy) =
		(gx + gy) :: listAdd ox oy
		
  fun insert (v:int) [] = [v]
	| insert (v:int) (l:int list as h::t) = 
		if v<h then v::l
		else h::insert v t
		
  fun insort (lista:int list) =
    let
      fun sort [] res = res
        | sort (h::t) res = sort t (insert h res)
    in
      sort lista nil
    end

	
  fun compose f g = ( fn x => g(f x) )
  
  fun curry f a b = f( a, b )
  fun uncurry f( a, b ) = f a b
  
  fun multifun f n = 
	if n=1 then ( fn x => f x )
	else ( fn x => f ( (multifun f (n-1)) x ) )

	
  (* 'a list *)
  fun ltake _ 0 = []
	| ltake [] _  = []
	| ltake (x::xs) n = x::( ltake xs (n-1) )
	
  fun lall _ [] = true
	| lall f (x::xs) = if (f x) then (lall f xs) else false
	
  fun lmap _ [] = []
	| lmap f (x::xs) = (f x)::(lmap f xs)
	
  fun lrev [] = []
	| lrev (x::xs) = (lrev xs) @ [x]
	
  fun lzip (_, []) = []
	| lzip ([], _) = []
	| lzip ( (x::xs), (y::ys) ) = (x, y)::( lzip (xs, ys) )
	
  fun split [] = ([], [])
	| split [x] = ([x], [])
	| split (n::p::xs) = 
		let 
			val (ns, ps) = split xs
		in
			( (n::ns), (p::ps) )
		end
		
  fun cartprod [] _ = []
	| cartprod _ [] = []
	| cartprod (x::xs) ys = 
		( lmap (fn y => (x,y)) ys ) @ ( cartprod xs ys )

end
