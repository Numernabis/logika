#------------------
# zadanie 2
# Ludwik Ciechanski
#------------------

# Church numerals
ZERO        = lambda p: lambda x: x
ONE         = lambda p: lambda x: p(x)
TWO         = lambda p: lambda x: p(p(x))
THREE       = lambda p: lambda x: p(p(p(x)))
FOUR        = lambda p: lambda x: p(p(p(p(x))))
FIVE        = lambda p: lambda x: p(p(p(p(p(x)))))
SIX         = lambda p: lambda x: p(p(p(p(p(p(x))))))
SEVEN       = lambda p: lambda x: p(p(p(p(p(p(p(x)))))))
EIGHT       = lambda p: lambda x: p(p(p(p(p(p(p(p(x))))))))
NINE        = lambda p: lambda x: p(p(p(p(p(p(p(p(p(x)))))))))
TEN         = lambda p: lambda x: p(p(p(p(p(p(p(p(p(p(x))))))))))
ELEVEN      = lambda p: lambda x: p(p(p(p(p(p(p(p(p(p(p(x)))))))))))
TWELVE      = lambda p: lambda x: p(p(p(p(p(p(p(p(p(p(p(p(x))))))))))))

# Booleans
TRUE        = lambda x: lambda y: x
FALSE       = lambda x: lambda y: y
NOT         = lambda x: lambda y: lambda z: x(z)(y)
AND         = lambda x: lambda y: x(y)(x)
OR          = lambda x: lambda y: x(x)(y)
XOR         = lambda x: lambda y: x(NOT(y))(y)

# IF          = lambda b: lambda x: lambda y: b(x)(y)
# IF          = lambda b: lambda x: b(x)
IF          = lambda b: b

# Predicates
IS_ZERO     = lambda n: n(lambda x: FALSE)(TRUE)

# Numeric operations
INCREMENT   = lambda n: lambda p: lambda x: p(n(p)(x))
DECREMENT   = lambda n: lambda f: lambda x: n(lambda a: lambda b: b(a(f))) (lambda y: x) (lambda y: y)

ADD         = lambda m: lambda n: n(INCREMENT)(m)               # n times, increment m
SUB         = lambda m: lambda n: n(DECREMENT)(m)               # n times, decrement m
MUL         = lambda m: lambda n: n(ADD(m))(ZERO)               # n times, add m to zero
POW         = lambda m: lambda n: n(MUL(m))(ONE)                # n times, multiplty m and one

LEQ         = lambda m: lambda n: IS_ZERO(SUB(m)(n))            # m <= n
GT          = lambda m: lambda n: NOT(LEQ(m)(n))                # m > n
EQ          = lambda m: lambda n: AND(LEQ(m)(n))(LEQ(n)(m))     # m == n

GEQ         = lambda m: lambda n: OR(GT(m)(n))(EQ(m)(n))        # m >= n
LT          = lambda m: lambda n: NOT(GEQ(m)(n))                # m < n

# MOD         = lambda m: lambda n: IF(LEQ(n)(m)) (MOD(SUB(m)(n))(n)) (m)

# Combinators
Y           = lambda f: (lambda x: f(x(x))) (lambda x: f(x(x)))
Z           = lambda f: (lambda x: f(lambda y: x(x)(y))) (lambda x: f(lambda y: x(x)(y)))

MOD         = Z( lambda f: lambda m: lambda n: IF(LEQ(n)(m)) (lambda y: f(SUB(m)(n))(n)(y)) (m) )

# Lists
PAIR        = lambda x: lambda y: lambda f: f(x)(y)
LEFT        = lambda p: p(lambda x: lambda y: x)
RIGHT       = lambda p: p(lambda x: lambda y: y)

EMPTY       = PAIR(TRUE)(TRUE)
UNSHIFT     = lambda s: lambda x: PAIR(FALSE)(PAIR(x)(s))
IS_EMPTY    = LEFT
FIRST       = lambda s: LEFT(RIGHT(s))
REST        = lambda s: RIGHT(RIGHT(s))

# lambda y:  as a wrapper, to avoid strict evaluation
RANGE       = Z( lambda f: lambda m: lambda n: IF(LEQ(m)(n)) (lambda y: UNSHIFT(f(INCREMENT(m))(n))(m)(y)) (EMPTY) )
FOLD        = Z( lambda f: lambda l: lambda x: lambda g: IF(IS_EMPTY(l)) (x) (lambda y: g(f(REST(l))(x)(g))(FIRST(l))(y)) )
MAP         = lambda k: lambda f: FOLD(k)(EMPTY)(lambda l: lambda x: UNSHIFT(l)(f(x)))

# Methods to test programs
def to_integer(p):
    return p(lambda n: n + 1)(0)

def to_boolean(p):
    return p(True)(False)

def to_array(p):
    array = []
    while not to_boolean(IS_EMPTY(p)):
        array.append(FIRST(p))
        p = REST(p)
    return array