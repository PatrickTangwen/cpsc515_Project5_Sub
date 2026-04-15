## 👤 User
Rewrite the following legal explanations into plain, accessible language for a non-expert reader.
Requirements:
- Keep the result accurate
- Do not change the conclusion
- Avoid legal jargon where possible
- Clearly explain why the person is or is not a dependent
- Keep each explanation concise but complete
- Preserve scenario labels

For each scenario, output:
- Scenario label
- Plain-language explanation

Here are the legal explanations:

Part 3 Legal Explanations
This document turns the Part 2 solver output into statute-based legal explanations. For each scenario:

base_check = sat confirms the scenario facts are consistent with the SMT model.
The opposite query is added only to force an unsat result so that Z3 returns the relevant named rules.
The explanation below focuses on the legally salient rules from the extracted core.

Scenario 1 — Split-custody teen with more nights at dad's apartment
Solver classification: dependent
Opposite query: (assert (not is_dependent))
Opposite result: unsat
Named rules in core:
rule_152_a_dependent_definition
rule_152_b2_joint_return
rule_152_b3_citizenship_or_residency
rule_152_b3_general_residency
rule_152_c1A_qc_relationship
rule_152_c1B_qc_same_abode
rule_152_c1C_qc_age
rule_152_c1D_qc_self_support
rule_152_c1E_qc_joint_return
rule_152_c1_qc_candidate_definition
rule_152_c4_qc_tiebreaker
rule_152_c_qc_definition
Legal explanation:

Under 26 U.S.C. §152(a), the individual is a dependent if he is either a qualifying child or a qualifying relative and also satisfies the applicable global limits in §152(b). Here, the supporting core shows that he qualifies as a qualifying child under §152(c). He satisfies the relationship requirement in §152(c)(1)(A) because he is the taxpayer's son, the same-abode requirement in §152(c)(1)(B) because he lived with the taxpayer for more than half of the year, the age requirement in §152(c)(1)(C) and §152(c)(3) because he is younger than the taxpayer and under age 19, the self-support rule in §152(c)(1)(D) because he did not provide more than half of his own support, and the joint-return rule in §152(c)(1)(E) because he did not file a disqualifying joint return. The core also includes §152(c)(4), which matters because another parent could potentially claim him; the taxpayer prevails under the tie-breaker because the child lived with the taxpayer longer during the year. Finally, the individual passes the global joint-return and citizenship or residency requirements in §152(b)(2) and §152(b)(3). For those reasons, the model concludes that the individual is a dependent.

Scenario 2 — Permanently disabled adult daughter living at home
Solver classification: dependent
Opposite query: (assert (not is_dependent))
Opposite result: unsat
Named rules in core:
rule_152_a_dependent_definition
rule_152_b2_joint_return
rule_152_b3_citizenship_or_residency
rule_152_b3_general_residency
rule_152_c1A_qc_relationship
rule_152_c1B_qc_same_abode
rule_152_c1C_qc_age
rule_152_c1D_qc_self_support
rule_152_c1E_qc_joint_return
rule_152_c1_qc_candidate_definition
rule_152_c4_qc_tiebreaker
rule_152_c_qc_definition
Legal explanation:

Under 26 U.S.C. §152(a), the individual is a dependent because she satisfies the qualifying-child route in §152(c) and also clears the global restrictions in §152(b). The core shows that the relationship rule in §152(c)(1)(A) is satisfied because she is the taxpayer's daughter, and the same-abode rule in §152(c)(1)(B) is satisfied because she lived with the taxpayer for the full year. The key rule here is §152(c)(1)(C), read with §152(c)(3): although she is 29 years old, the age condition is still satisfied because the model treats permanent and total disability as satisfying that branch of the qualifying-child test. She also satisfies §152(c)(1)(D) because she did not provide more than half of her own support, and §152(c)(1)(E) because she did not file a disqualifying joint return. There is no competing claimant, so the §152(c)(4) tie-breaker does not disqualify her. She also passes the global joint-return and citizenship or residency conditions in §152(b)(2) and §152(b)(3). On that basis, the SMT model justifies dependent status.

Scenario 3 — Low-income grandmother supported by her grandson
Solver classification: dependent
Opposite query: (assert (not is_dependent))
Opposite result: unsat
Named rules in core:
rule_152_a_dependent_definition
rule_152_b2_joint_return
rule_152_b3_citizenship_or_residency
rule_152_b3_general_residency
rule_152_d1B_qr_gross_income
rule_152_d1C_qr_support
rule_152_d1C_qr_support_direct
rule_152_d1D_qr_not_qc_of_anyone
rule_152_d2_qr_relationship
rule_152_d4_effective_gross_income
rule_152_d5A_effective_support
rule_152_d_qr_definition
Legal explanation:

Under 26 U.S.C. §152(a), the individual qualifies as a dependent through the qualifying-relative path in §152(d). The extracted core shows that the relationship requirement in §152(d)(2) is satisfied because she is the taxpayer's grandmother and therefore falls within the ancestor category used in the model. She satisfies the gross-income requirement in §152(d)(1)(B), as computed through the effective-gross-income rule in §152(d)(4), because her gross income is below the exemption amount used for tax year 2025. She satisfies the support requirement in §152(d)(1)(C) because the taxpayer provided more than one-half of her total support, and the model's support calculation also passes through the support-adjustment rule corresponding to §152(d)(5)(A). She also satisfies §152(d)(1)(D) because she is not treated as a qualifying child of the taxpayer or of another taxpayer. Finally, she passes the global requirements in §152(b)(2) and §152(b)(3), since she did not file a joint return and the model treats her as a U.S. resident. Accordingly, the solver treats her as a dependent.

Scenario 4 — Married college daughter who filed jointly for a real tax benefit
Solver classification: not dependent
Opposite query: (assert is_dependent)
Opposite result: unsat
Named rules in core:
rule_152_a_dependent_definition
rule_152_b2_joint_return
Legal explanation:

The individual is not a dependent because the global joint-return rule blocks dependent status. Under 26 U.S.C. §152(b)(2), an individual who filed a joint return with a spouse for the relevant year is not treated as a dependent, except in the limited refund-only situation incorporated elsewhere in the model. Here, the scenario states that the daughter and her spouse filed jointly for a real tax benefit rather than only to obtain a refund, so the joint-return bar applies. Because §152(a) defines dependency only when the statutory conditions are met and §152(b)(2) is not satisfied, the solver cannot consistently treat her as a dependent.

Scenario 5 — Brother with too much income to be a qualifying relative
Solver classification: not dependent
Opposite query: (assert is_dependent)
Opposite result: unsat
Named rules in core:
rule_152_a_dependent_definition
rule_152_c1C_qc_age
rule_152_c1_qc_candidate_definition
rule_152_c_qc_definition
rule_152_d1B_qr_gross_income
rule_152_d4_effective_gross_income
rule_152_d_qr_definition
Legal explanation:

The individual is not a dependent because neither statutory route in §152(a) succeeds. First, he does not qualify as a qualifying child under §152(c), and the core highlights the age branch in §152(c)(1)(C): he is a 45-year-old brother, so he does not satisfy the qualifying-child age rule used by the model. Second, he does not qualify as a qualifying relative under §152(d) because the gross-income requirement in §152(d)(1)(B) is not satisfied. The core includes the effective-gross-income rule in §152(d)(4) and the gross-income threshold rule in §152(d)(1)(B), and under those rules his income of $18,600 is far above the exemption amount used in the model for tax year 2025. Since the qualifying-child path fails and the qualifying-relative path also fails, §152(a) cannot be satisfied, so he is not a dependent.

Scenario 6 — Nephew lives mostly with aunt, but his mother could still claim him
Solver classification: not dependent
Opposite query: (assert is_dependent)
Opposite result: unsat
Named rules in core:
rule_152_a_dependent_definition
rule_152_c4_qc_tiebreaker
rule_152_c_qc_definition
rule_152_d1D_qr_not_qc_of_anyone
rule_152_d_qr_definition
Legal explanation:

The individual is not a dependent of the aunt because the qualifying-child tie-breaker favors the child's mother, and the qualifying-relative route is also blocked. Under the model's implementation of 26 U.S.C. §152(c)(4), when a parent and a non-parent could both claim the same child, the parent has priority unless the statute's limited exceptions apply. The extracted core shows that this tie-breaker rule is decisive here, so the aunt cannot treat the nephew as her qualifying child even though he lived with her for most of the year. The core also includes §152(d)(1)(D), which requires that a qualifying relative not be a qualifying child of the taxpayer or of any other taxpayer. Because the nephew is treated in the scenario as a qualifying child of another taxpayer, the qualifying-relative path in §152(d) is unavailable as well. As a result, the final dependent definition in §152(a) cannot be satisfied for the aunt.


## 🤖 ChatGPT 5.3
I’m rewriting each one into plain English while keeping the outcome and the key reasons the same.

**Scenario 1**

He is a dependent because he fits the rules for a child dependent. He is the taxpayer’s son, he lived with the taxpayer for more than half the year, he is under 19, he did not pay more than half of his own support, and he did not file a disqualifying joint return. Another parent could also try to claim him, but the taxpayer wins because the child lived with the taxpayer longer during the year. He also meets the citizenship or residency requirement. 

**Scenario 2**

She is a dependent because she still qualifies as the taxpayer’s child dependent even though she is 29. She is the taxpayer’s daughter, she lived with the taxpayer all year, she did not provide more than half of her own support, and she did not file a disqualifying joint return. Her disability is what allows her to satisfy the age-related part of the test. There is no competing taxpayer with a better claim, and she also meets the citizenship or residency requirement. 

**Scenario 3**

She is a dependent because she qualifies under the relative-dependent rules. She is the taxpayer’s grandmother, her income is below the allowed limit, and the taxpayer paid more than half of her total support. She is also not being treated as someone else’s qualifying child, she did not file a disqualifying joint return, and she meets the residency requirement used in the model. For those reasons, she counts as a dependent. 

**Scenario 4**

She is not a dependent because she filed a joint tax return with her spouse, and that blocks dependent status here. This was not just a return filed only to get a refund back; it was filed for a real tax benefit. Because of that joint return, she cannot be treated as a dependent in this scenario. 

**Scenario 5**

He is not a dependent because he fails both possible paths. He is too old to qualify as a child dependent, and he also does not qualify as a relative dependent because his income is too high. Since neither route works, he cannot be claimed as a dependent. 

**Scenario 6**

He is not a dependent of the aunt because his mother has the stronger claim under the priority rules for claiming a child. Even though he lived with the aunt for most of the year, the parent comes first here. He also cannot be treated as the aunt’s relative dependent, because he is considered the qualifying child of another taxpayer. So the aunt cannot claim him as a dependent. 
