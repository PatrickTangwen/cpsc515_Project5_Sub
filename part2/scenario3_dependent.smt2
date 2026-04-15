; Scenario 3: Low-income grandmother supported by her grandson
; Expected classification: dependent

; Relationship / household facts
(assert (= rel_child_or_descendant false))
(assert (= rel_sibling_or_descendant false))
(assert (= rel_parent_or_ancestor true))
(assert (= rel_step_parent false))
(assert (= rel_niece_nephew false))
(assert (= rel_aunt_uncle false))
(assert (= rel_in_law false))
(assert (= spouse_of_taxpayer_during_year false))
(assert (= household_member_entire_year false))
(assert (= relationship_violates_local_law false))
(assert (= same_abode_entire_year false))

; Personal status
(assert (= is_student false))
(assert (= is_disabled false))

; Return filing
(assert (= filed_joint_return false))
(assert (= refund_only_joint_return false))

; Citizenship / residency
(assert (= is_us_citizen_or_national_individual false))
(assert (= is_us_resident true))
(assert (= is_resident_of_contiguous_country false))
(assert (= is_adopted_child false))
(assert (= is_us_citizen_or_national_taxpayer true))

; Qualifying-child tie-breaker inputs
(assert (= other_can_claim_qc false))
(assert (= taxpayer_is_parent false))
(assert (= other_claimant_is_parent false))
(assert (= parents_file_joint_return_together false))
(assert (= no_parent_claims_child false))
(assert (= is_qc_of_other_taxpayer false))

; Qualifying-relative special rules
(assert (= sheltered_workshop_income_excludable false))
(assert (= multiple_support_no_one_over_half false))
(assert (= multiple_support_group_over_half false))
(assert (= multiple_support_taxpayer_over_10pct false))
(assert (= multiple_support_others_over_10pct_signed false))

; Integer inputs
(assert (= age_individual 74))
(assert (= age_taxpayer 33))
(assert (= days_in_year 365))
(assert (= days_same_abode 0))
(assert (= days_with_other_claimant 0))

; Real inputs
(assert (= gross_income 4100.0))
(assert (= exemption_amount 5200.0))
(assert (= total_support 19500.0))
(assert (= support_from_taxpayer 12300.0))
(assert (= support_from_taxpayer_as_alimony 0.0))
(assert (= support_from_taxpayer_new_spouse_to_child 0.0))
(assert (= support_from_individual 4100.0))
(assert (= sheltered_workshop_income 0.0))
(assert (= agi_taxpayer 67000.0))
(assert (= agi_other_claimant 0.0))
(assert (= highest_parent_agi 0.0))
