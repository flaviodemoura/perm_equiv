
(* begin hide *)
Require Import Arith List.
Require Import Permutation.
(* end hide *)

(**

%\noindent% onde o predicado [Permutation] é definido pelas regras a seguir:

%\begin{mathpar}
 \inferrule*[Right={$(perm\_nil)$}]{~}{Permutation\ nil\ nil} \and \inferrule*[Right={$(perm\_skip)$}]{Permutation\ l\ l'}{Permutation\ (x :: l)\ (x :: l')} \\ \inferrule*[Right={$(perm\_swap)$}]{~}{Permutation\ (y :: x :: l)\ (x :: y :: l)} \\ \inferrule*[Right={$(perm\_trans)$}]{Permutation\ l\ l' \and Permutation\ l'\ l''}{Permutation\ l\ l''}
\end{mathpar}%
%\noindent% onde $x$, $y$, $l$, $l'$ e $l''$ são variáveis universais.

O código Coq correspondente a essas regras é listado a seguir:

<<
 Inductive Permutation (A : Type) : list A -> list A -> Prop :=
  | perm_nil : Permutation nil nil
  | perm_skip : forall (x : A) (l l' : list A),
                Permutation l l' ->
                Permutation (x :: l) (x :: l')
  | perm_swap : forall (x y : A) (l : list A),
                Permutation (y :: x :: l)
                  (x :: y :: l)
  | perm_trans : forall l l' l'' : list A,
                 Permutation l l' ->
                 Permutation l' l'' ->
                 Permutation l l''.
>>

Alternativamente, a lista [l] é uma permutação da lista [l'] se ambas possuem os mesmos elementos. A implementação dessa ideia é feita baseada no número de ocorrência de cada elemento na lista. Assim, na definição a seguir, [num_oc x l] retorna o número de ocorrências do elemento [x] na lista [l]:

*)

Fixpoint num_oc x l := 
  match l with
    | nil => 0
    | h :: tl =>
      if x =? h then S(num_oc x tl) else  num_oc x tl 
  end.

(**

A definição [equiv] a seguir, expressa que a lista [l] é uma permutação da lista [l'] se ambas possuem o mesmo número de ocorrências de qualquer elemento:

*)

Definition equiv l l' := forall n:nat, num_oc n l = num_oc n l'.


Lemma perm_to_equiv: forall l l', Permutation l l' -> equiv l l'.
Proof. Admitted.


Lemma equiv_to_perm: forall l l', equiv l l' -> Permutation l l'.
Proof. Admitted.

(**

O teorema a seguir formaliza que as definições [Permutation] e [equiv] são equivalentes, e portanto qualquer uma delas pode ser utilizada no projeto.

*)

Theorem perm_equiv: forall l l', Permutation l l' <-> equiv l l'.
Proof. Admitted.

