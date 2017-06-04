Require Import ProofWeb.

Section ZadanieOne.
Variables A B C D : Prop. 

Theorem impl_rozdz : (A -> B) -> (A -> C) -> A -> B -> C.
Proof.
intro P.
intro Q.
intro R.
intro S.
apply Q.
exact R.
Qed.

Theorem impl_komp : (A -> B) -> (B -> C) -> A -> C.
Proof.
intro P.
intro Q.
intro R.
apply Q.
apply P.
exact R.
Qed.

Theorem impl_perm : (A -> B -> C) -> B -> A -> C. 
Proof.
intro P.
intro Q.
intro R.
apply P.
exact R.
exact Q.
Qed.

Theorem impl_conj : A -> B -> A /\ B. 
Proof.
intro P.
intro Q.
split.
exact P.
exact Q.
Qed.

Theorem conj_elim_l : A /\ B -> A. 
Proof.
intro P.
elim P.
intro Q.
intro R.
exact Q.
Qed.

Theorem disj_intro_l : A -> A \/ B.
Proof.
intro P.
left.
exact P.
Qed.

Theorem rozl_elim : A \/ B -> (A -> C) -> (B -> C) -> C. 
Proof.
intro P.
intro Q.
intro R.
elim P.
exact Q.
exact R.
Qed.

Theorem diamencik : (A -> B) -> (A -> C) -> (B -> C -> D) -> A -> D.
Proof.
intro P.
intro Q.
intro R.
intro S.
apply R.
apply P.
exact S.
apply Q.
exact S.
Qed.

Theorem slaby_peirce : ((((A -> B) -> A) -> A) -> B) -> B.
Proof.
intro P.
apply P.
intro Q.
apply Q.
intro R.
apply P.
intros.
exact R.
Qed.

Theorem rozl_impl_rozdz : (A \/ B -> C) -> (A -> C) /\ (B -> C).
Proof.
intro P.
split.
intro Q.
apply P.
left.
exact Q.
intro R.
apply P.
right.
exact R.
Qed.
 
Theorem rozl_impl_rozdz_odw : (A -> C) /\ (B -> C) -> A \/ B -> C.
Proof.
intro P.
elim P.
intro Q.
intro R.
intro S.
elim S.
exact Q.
exact R.
Qed.

Theorem curry : (A /\ B -> C) -> A -> B -> C.
Proof.
intro P.
intro Q.
intro R.
apply P.
split.
exact Q.
exact R.
Qed.

Theorem uncurry : (A -> B -> C) -> A /\ B -> C.
Proof.
intro P.
intro Q.
elim Q.
exact P.
Qed.

End ZadanieOne.