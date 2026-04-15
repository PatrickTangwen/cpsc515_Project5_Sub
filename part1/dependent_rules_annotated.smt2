(set-logic AUFNIRA)
(set-option :produce-models true)
(set-option :unsat_core true)

; ============================================================
; 26 U.S.C. §152(a)-(d) dependency model with named assertions
; for Project 5 unsat-core extraction.
;
; Design choice:
; - Primitive case facts stay as declared inputs.
; - High-level legal predicates are declared separately and linked
;   to the inputs with :named assertions so they can appear in cores.
; - Helper arithmetic terms that do not need to appear in the core
;   are still modeled as declared intermediate values.
; ============================================================

; -----------------------------
; Primitive input declarations
; -----------------------------

; Relationship / household facts
(declare-const rel_child_or_descendant Bool)
(declare-const rel_sibling_or_descendant Bool)
(declare-const rel_parent_or_ancestor Bool)
(declare-const rel_step_parent Bool)
(declare-const rel_niece_nephew Bool)
(declare-const rel_aunt_uncle Bool)
(declare-const rel_in_law Bool)
(declare-const spouse_of_taxpayer_during_year Bool)
(declare-const household_member_entire_year Bool)
(declare-const relationship_violates_local_law Bool)
(declare-const same_abode_entire_year Bool)

; Personal status
(declare-const is_student Bool)
(declare-const is_disabled Bool)

; Return filing
(declare-const filed_joint_return Bool)
(declare-const refund_only_joint_return Bool)

; Citizenship / residency
(declare-const is_us_citizen_or_national_individual Bool)
(declare-const is_us_resident Bool)
(declare-const is_resident_of_contiguous_country Bool)
(declare-const is_adopted_child Bool)
(declare-const is_us_citizen_or_national_taxpayer Bool)

; Qualifying-child tie-breaker inputs
(declare-const other_can_claim_qc Bool)
(declare-const taxpayer_is_parent Bool)
(declare-const other_claimant_is_parent Bool)
(declare-const parents_file_joint_return_together Bool)
(declare-const no_parent_claims_child Bool)
(declare-const is_qc_of_other_taxpayer Bool)

; Qualifying-relative special rules
(declare-const sheltered_workshop_income_excludable Bool)
(declare-const multiple_support_no_one_over_half Bool)
(declare-const multiple_support_group_over_half Bool)
(declare-const multiple_support_taxpayer_over_10pct Bool)
(declare-const multiple_support_others_over_10pct_signed Bool)

; Integer inputs
(declare-const age_individual Int)
(declare-const age_taxpayer Int)
(declare-const days_in_year Int)
(declare-const days_same_abode Int)
(declare-const days_with_other_claimant Int)

; Real inputs
(declare-const gross_income Real)
(declare-const exemption_amount Real)
(declare-const total_support Real)
(declare-const support_from_taxpayer Real)
(declare-const support_from_taxpayer_as_alimony Real)
(declare-const support_from_taxpayer_new_spouse_to_child Real)
(declare-const support_from_individual Real)
(declare-const sheltered_workshop_income Real)
(declare-const agi_taxpayer Real)
(declare-const agi_other_claimant Real)
(declare-const highest_parent_agi Real)

; -----------------------------
; Derived predicate declarations
; -----------------------------

(declare-const passes_b2_textual_strict Bool)
(declare-const passes_b2 Bool)
(declare-const passes_b3_general Bool)
(declare-const adopted_child_exception Bool)
(declare-const passes_b3 Bool)

(declare-const qc_relationship Bool)
(declare-const qc_same_abode Bool)
(declare-const qc_age Bool)
(declare-const qc_self_support Bool)
(declare-const qc_joint_return Bool)
(declare-const is_qualifying_child_candidate Bool)
(declare-const wins_qc_tiebreaker Bool)
(declare-const is_qualifying_child Bool)

(declare-const qr_relationship Bool)
(declare-const effective_gross_income Real)
(declare-const qr_gross_income Bool)
(declare-const effective_support_from_taxpayer Real)
(declare-const qr_support_direct Bool)
(declare-const qr_support_multiple Bool)
(declare-const qr_support Bool)
(declare-const qr_not_qc_of_anyone Bool)
(declare-const is_qualifying_relative Bool)

(declare-const is_dependent Bool)
(declare-const dependent_has_no_dependents_of_own Bool)

; -----------------------------
; Domain constraints
; -----------------------------
(assert (>= age_individual 0))
(assert (>= age_taxpayer 0))
(assert (> days_in_year 0))
(assert (>= days_same_abode 0))
(assert (<= days_same_abode days_in_year))
(assert (>= days_with_other_claimant 0))
(assert (<= days_with_other_claimant days_in_year))

(assert (>= gross_income 0.0))
(assert (>= exemption_amount 0.0))
(assert (>= total_support 0.0))
(assert (>= support_from_taxpayer 0.0))
(assert (>= support_from_taxpayer_as_alimony 0.0))
(assert (>= support_from_taxpayer_new_spouse_to_child 0.0))
(assert (>= support_from_individual 0.0))
(assert (>= sheltered_workshop_income 0.0))
(assert (>= agi_taxpayer 0.0))
(assert (>= agi_other_claimant 0.0))
(assert (>= highest_parent_agi 0.0))

; -----------------------------
; §152(b): global exclusions
; -----------------------------

(assert (! (= passes_b2_textual_strict
              (not filed_joint_return))
          :named rule_152_b2_textual_strict))

(assert (! (= passes_b2
              (or (not filed_joint_return)
                  refund_only_joint_return))
          :named rule_152_b2_joint_return))

(assert (! (= passes_b3_general
              (or is_us_citizen_or_national_individual
                  is_us_resident
                  is_resident_of_contiguous_country))
          :named rule_152_b3_general_residency))

(assert (! (= adopted_child_exception
              (and is_adopted_child
                   same_abode_entire_year
                   household_member_entire_year
                   is_us_citizen_or_national_taxpayer))
          :named rule_152_b3_adopted_child_exception))

(assert (! (= passes_b3
              (or passes_b3_general
                  adopted_child_exception))
          :named rule_152_b3_citizenship_or_residency))

; -----------------------------
; §152(c): qualifying child
; -----------------------------

(assert (! (= qc_relationship
              (or rel_child_or_descendant
                  rel_sibling_or_descendant))
          :named rule_152_c1A_qc_relationship))

(assert (! (= qc_same_abode
              (> (* 2 days_same_abode) days_in_year))
          :named rule_152_c1B_qc_same_abode))

(assert (! (= qc_age
              (or is_disabled
                  (and (< age_individual age_taxpayer)
                       (or (< age_individual 19)
                           (and is_student
                                (< age_individual 24))))))
          :named rule_152_c1C_qc_age))

(assert (! (= qc_self_support
              (<= (* 2.0 support_from_individual) total_support))
          :named rule_152_c1D_qc_self_support))

(assert (! (= qc_joint_return
              (or (not filed_joint_return)
                  refund_only_joint_return))
          :named rule_152_c1E_qc_joint_return))

(assert (! (= is_qualifying_child_candidate
              (and qc_relationship
                   qc_same_abode
                   qc_age
                   qc_self_support
                   qc_joint_return))
          :named rule_152_c1_qc_candidate_definition))

(assert (! (= wins_qc_tiebreaker
              (ite (not other_can_claim_qc)
                   true
                   (or
                     (and taxpayer_is_parent
                          (not other_claimant_is_parent))
                     (and taxpayer_is_parent
                          other_claimant_is_parent
                          parents_file_joint_return_together)
                     (and taxpayer_is_parent
                          other_claimant_is_parent
                          (not parents_file_joint_return_together)
                          (or (> days_same_abode days_with_other_claimant)
                              (and (= days_same_abode days_with_other_claimant)
                                   (> agi_taxpayer agi_other_claimant))))
                     (and (not taxpayer_is_parent)
                          (not other_claimant_is_parent)
                          (> agi_taxpayer agi_other_claimant))
                     (and (not taxpayer_is_parent)
                          other_claimant_is_parent
                          no_parent_claims_child
                          (> agi_taxpayer highest_parent_agi)))))
          :named rule_152_c4_qc_tiebreaker))

(assert (! (= is_qualifying_child
              (and is_qualifying_child_candidate
                   wins_qc_tiebreaker))
          :named rule_152_c_qc_definition))

; -----------------------------
; §152(d): qualifying relative
; -----------------------------

(assert (! (= qr_relationship
              (or rel_child_or_descendant
                  rel_sibling_or_descendant
                  rel_parent_or_ancestor
                  rel_step_parent
                  rel_niece_nephew
                  rel_aunt_uncle
                  rel_in_law
                  (and (not spouse_of_taxpayer_during_year)
                       same_abode_entire_year
                       household_member_entire_year
                       (not relationship_violates_local_law))))
          :named rule_152_d2_qr_relationship))

(assert (! (= effective_gross_income
              (- gross_income
                 (ite sheltered_workshop_income_excludable
                      sheltered_workshop_income
                      0.0)))
          :named rule_152_d4_effective_gross_income))

(assert (! (= qr_gross_income
              (< effective_gross_income exemption_amount))
          :named rule_152_d1B_qr_gross_income))

(assert (! (= effective_support_from_taxpayer
              (+ (- support_from_taxpayer
                    support_from_taxpayer_as_alimony)
                 support_from_taxpayer_new_spouse_to_child))
          :named rule_152_d5A_effective_support))

(assert (! (= qr_support_direct
              (> (* 2.0 effective_support_from_taxpayer) total_support))
          :named rule_152_d1C_qr_support_direct))

(assert (! (= qr_support_multiple
              (and multiple_support_no_one_over_half
                   multiple_support_group_over_half
                   multiple_support_taxpayer_over_10pct
                   multiple_support_others_over_10pct_signed))
          :named rule_152_d3_qr_multiple_support))

(assert (! (= qr_support
              (or qr_support_direct
                  qr_support_multiple))
          :named rule_152_d1C_qr_support))

(assert (! (= qr_not_qc_of_anyone
              (and (not is_qualifying_child)
                   (not is_qc_of_other_taxpayer)))
          :named rule_152_d1D_qr_not_qc_of_anyone))

(assert (! (= is_qualifying_relative
              (and qr_relationship
                   qr_gross_income
                   qr_support
                   qr_not_qc_of_anyone))
          :named rule_152_d_qr_definition))

; -----------------------------
; §152(a): final dependent predicate
; -----------------------------

(assert (! (= is_dependent
              (and (or is_qualifying_child
                       is_qualifying_relative)
                   passes_b2
                   passes_b3))
          :named rule_152_a_dependent_definition))

; §152(b)(1): consequence rule only
(assert (! (= dependent_has_no_dependents_of_own true)
          :named rule_152_b1_no_dependents_of_own))

(assert (=> is_dependent dependent_has_no_dependents_of_own))
