# Project 5 Report

### Wenhua Tang 

In the Project 5, the formal model was derived from the Project 4's ChatGPT CoT SMT model.

---
## 1. Six Scenarios
### Scenario 1 — Split-custody teen with more nights at dad's apartment

- Expected classification: dependent
- Taxpayer age: 41
- Individual age: 17
- Relationship: son
- Student: yes
- Disabled: no
- Joint return: no
- Citizenship/residency: U.S. citizen
- Days with taxpayer: 214
- Days with other parent: 151
- Gross income: 4,300
- Total support: 21,000
- Support from taxpayer: 13,500
- Support from individual: 2,800
- Competing claimant: yes, the mother

### Scenario 2 — Permanently disabled adult daughter living at home

- Expected classification: dependent
- Taxpayer age: 58
- Individual age: 29
- Relationship: daughter
- Student: no
- Disabled: yes
- Joint return: no
- Citizenship/residency: U.S. citizen
- Days with taxpayer: 365
- Gross income: 3,900
- Total support: 28,000
- Support from taxpayer: 22,400
- Support from individual: 3,900
- Competing claimant: no

### Scenario 3 — Low-income grandmother supported by her grandson

- Expected classification: dependent
- Taxpayer age: 33
- Individual age: 74
- Relationship: grandmother
- Student: no
- Disabled: no
- Joint return: no
- Citizenship/residency: U.S. resident
- Days with taxpayer: 0
- Gross income: 4,100
- Total support: 19,500
- Support from taxpayer: 12,300
- Support from individual: 4,100
- Competing claimant: no

### Scenario 4 — Married college daughter who filed jointly for a real tax benefit

- Expected classification: not dependent
- Taxpayer age: 52
- Individual age: 22
- Relationship: daughter
- Student: yes
- Disabled: no
- Joint return: yes, not refund-only
- Citizenship/residency: U.S. citizen
- Days with taxpayer: 245
- Gross income: 8,700
- Total support: 24,000
- Support from taxpayer: 16,500
- Support from individual: 5,500
- Competing claimant: no

### Scenario 5 — Brother with too much income to be a qualifying relative

- Expected classification: not dependent
- Taxpayer age: 47
- Individual age: 45
- Relationship: brother
- Student: no
- Disabled: no
- Joint return: no
- Citizenship/residency: U.S. citizen
- Days with taxpayer: 365
- Gross income: 18,600
- Total support: 23,000
- Support from taxpayer: 14,200
- Support from individual: 8,000
- Competing claimant: no

### Scenario 6 — Nephew lives mostly with aunt, but his mother could still claim him

- Expected classification: not dependent
- Taxpayer age: 38
- Individual age: 10
- Relationship: nephew
- Student: yes
- Disabled: no
- Joint return: no
- Citizenship/residency: U.S. citizen
- Days with taxpayer: 240
- Days with mother: 125
- Gross income: 0
- Total support: 14,000
- Support from taxpayer: 9,500
- Support from individual: 0
- Competing claimant: yes, the mother

The SMT-LIB versions of the 6 scenarios are saved in `part2` folder

--- 
## 2. Code and AI conversation 

### Code written for Project 5

- `part2/check_cores.py` loads the annotated model, adds a scenario file, runs a normal satisfiability check, then adds the opposite dependency assertion to force an unsat core.

### AI conversation transcripts

- The six warm-up scenarios came from an LLM and were saved in `conversation_warm_up.md`.
- The plain-language explanations in Part 4 came from an LLM based on the legal explanations written in Part 3 and were saved in `conversation_part4.md`.

---

## 3. SMT Solver Results

Important note:

- The actual SMT solver result for each scenario is the `base_check`.
- In this project, all six scenarios are internally consistent with the legal model, so all six `base_check` results are `sat`.
- The `opposite query result` is a second query added only for unsat-core extraction.
- That second query intentionally forces the opposite conclusion, so its result is `unsat` by design when the model supports the expected classification.

### Scenario 1

- Solver classification: dependent
- Base solver result: sat
- Opposite query result: unsat

### Scenario 2

- Solver classification: dependent
- Base solver result: sat
- Opposite query result: unsat

### Scenario 3

- Solver classification: dependent
- Base solver result: sat
- Opposite query result: unsat

### Scenario 4

- Solver classification: not dependent
- Base solver result: sat
- Opposite query result: unsat

### Scenario 5

- Solver classification: not dependent
- Base solver result: sat
- Opposite query result: unsat

### Scenario 6

- Solver classification: not dependent
- Base solver result: sat
- Opposite query result: unsat

From the results, all six scenarios matched their expected classification under the SMT model. All detailed results were saved in `part2/solver_results.txt`.

---
## 4. The extracted cores and named rules involved.

This section lists the named rules returned by the unsat-core queries and briefly explains what role they play.

### Scenario 1

- Core type: supporting rules
- Named rules involved:
  - `rule_152_a_dependent_definition`: final dependent definition under §152(a)
  - `rule_152_b2_joint_return`: global joint-return condition under §152(b)(2)
  - `rule_152_b3_citizenship_or_residency`: final citizenship/residency gate under §152(b)(3)
  - `rule_152_b3_general_residency`: general U.S. citizen / resident / contiguous-country rule
  - `rule_152_c1A_qc_relationship`: son satisfies the qualifying-child relationship rule
  - `rule_152_c1B_qc_same_abode`: child lived with taxpayer more than half the year
  - `rule_152_c1C_qc_age`: child satisfies the age rule
  - `rule_152_c1D_qc_self_support`: child did not provide more than half of own support
  - `rule_152_c1E_qc_joint_return`: child did not file a disqualifying joint return
  - `rule_152_c1_qc_candidate_definition`: combines the qualifying-child subconditions
  - `rule_152_c4_qc_tiebreaker`: resolves the competing-parent claim in favor of the taxpayer
  - `rule_152_c_qc_definition`: final qualifying-child definition

### Scenario 2

- Core type: supporting rules
- Named rules involved:
  - `rule_152_a_dependent_definition`: final dependent definition under §152(a)
  - `rule_152_b2_joint_return`: global joint-return condition under §152(b)(2)
  - `rule_152_b3_citizenship_or_residency`: final citizenship/residency gate under §152(b)(3)
  - `rule_152_b3_general_residency`: general U.S. citizen / resident / contiguous-country rule
  - `rule_152_c1A_qc_relationship`: daughter satisfies the qualifying-child relationship rule
  - `rule_152_c1B_qc_same_abode`: daughter lived with taxpayer all year
  - `rule_152_c1C_qc_age`: disability satisfies the age-related branch of the model
  - `rule_152_c1D_qc_self_support`: daughter did not provide more than half of own support
  - `rule_152_c1E_qc_joint_return`: daughter did not file a disqualifying joint return
  - `rule_152_c1_qc_candidate_definition`: combines the qualifying-child subconditions
  - `rule_152_c4_qc_tiebreaker`: no competing claimant defeats the taxpayer here
  - `rule_152_c_qc_definition`: final qualifying-child definition

### Scenario 3

- Core type: supporting rules
- Named rules involved:
  - `rule_152_a_dependent_definition`: final dependent definition under §152(a)
  - `rule_152_b2_joint_return`: global joint-return condition under §152(b)(2)
  - `rule_152_b3_citizenship_or_residency`: final citizenship/residency gate under §152(b)(3)
  - `rule_152_b3_general_residency`: general residency rule
  - `rule_152_d2_qr_relationship`: grandmother satisfies the qualifying-relative relationship rule
  - `rule_152_d4_effective_gross_income`: computes effective gross income
  - `rule_152_d1B_qr_gross_income`: gross income is below the exemption threshold
  - `rule_152_d5A_effective_support`: computes effective taxpayer support
  - `rule_152_d1C_qr_support_direct`: taxpayer provided over half of support directly
  - `rule_152_d1C_qr_support`: final support rule for qualifying-relative status
  - `rule_152_d1D_qr_not_qc_of_anyone`: individual is not a qualifying child of any taxpayer
  - `rule_152_d_qr_definition`: final qualifying-relative definition

### Scenario 4

- Core type: blocking rules
- Named rules involved:
  - `rule_152_a_dependent_definition`: final dependent definition under §152(a)
  - `rule_152_b2_joint_return`: global joint-return rule blocks dependency because the filing was not refund-only


### Scenario 5

- Core type: blocking rules
- Named rules involved:
  - `rule_152_a_dependent_definition`: final dependent definition under §152(a)
  - `rule_152_c1C_qc_age`: age rule blocks the qualifying-child route
  - `rule_152_c1_qc_candidate_definition`: the qualifying-child candidate conditions are not all satisfied
  - `rule_152_c_qc_definition`: final qualifying-child route fails
  - `rule_152_d4_effective_gross_income`: computes effective gross income
  - `rule_152_d1B_qr_gross_income`: income is too high for qualifying-relative status
  - `rule_152_d_qr_definition`: final qualifying-relative route fails

This core contains blocking rules from both possible dependency paths, because the query forced `is_dependent` as a whole and Z3 had to show why neither route could succeed.

### Scenario 6

- Core type: blocking rules
- Named rules involved:
  - `rule_152_a_dependent_definition`: final dependent definition under §152(a)
  - `rule_152_c4_qc_tiebreaker`: parent has priority over the aunt in the qualifying-child analysis
  - `rule_152_c_qc_definition`: final qualifying-child route fails for the aunt
  - `rule_152_d1D_qr_not_qc_of_anyone`: qualifying-relative route fails because the child is treated as another taxpayer's qualifying child
  - `rule_152_d_qr_definition`: final qualifying-relative route fails

In this scenario, the core shows that both the qualifying-child route and the qualifying-relative route are blocked.


---
## 5. Legal Explanations

### Scenario 1

Under 26 U.S.C. §152(a), the individual is a dependent if he is either a qualifying child or a qualifying relative and also satisfies the applicable global limits in §152(b). Here, the supporting core shows that he qualifies as a qualifying child under §152(c). He satisfies the relationship requirement in §152(c)(1)(A) because he is the taxpayer's son, the same-abode requirement in §152(c)(1)(B) because he lived with the taxpayer for more than half of the year, the age requirement in §152(c)(1)(C) and §152(c)(3) because he is younger than the taxpayer and under age 19, the self-support rule in §152(c)(1)(D) because he did not provide more than half of his own support, and the joint-return rule in §152(c)(1)(E) because he did not file a disqualifying joint return. The core also includes §152(c)(4), which matters because another parent could potentially claim him; the taxpayer prevails under the tie-breaker because the child lived with the taxpayer longer during the year. Finally, the individual passes the global joint-return and citizenship or residency requirements in §152(b)(2) and §152(b)(3). For those reasons, the model concludes that the individual is a dependent.

### Scenario 2

Under 26 U.S.C. §152(a), the individual is a dependent because she satisfies the qualifying-child route in §152(c) and also clears the global restrictions in §152(b). The core shows that the relationship rule in §152(c)(1)(A) is satisfied because she is the taxpayer's daughter, and the same-abode rule in §152(c)(1)(B) is satisfied because she lived with the taxpayer for the full year. The key rule here is §152(c)(1)(C), read with §152(c)(3): although she is 29 years old, the age condition is still satisfied because the model treats permanent and total disability as satisfying that branch of the qualifying-child test. She also satisfies §152(c)(1)(D) because she did not provide more than half of her own support, and §152(c)(1)(E) because she did not file a disqualifying joint return. There is no competing claimant, so the §152(c)(4) tie-breaker does not disqualify her. She also passes the global joint-return and citizenship or residency conditions in §152(b)(2) and §152(b)(3). On that basis, the SMT model justifies dependent status.

### Scenario 3

Under 26 U.S.C. §152(a), the individual qualifies as a dependent through the qualifying-relative path in §152(d). The extracted core shows that the relationship requirement in §152(d)(2) is satisfied because she is the taxpayer's grandmother and therefore falls within the ancestor category used in the model. She satisfies the gross-income requirement in §152(d)(1)(B), as computed through the effective-gross-income rule in §152(d)(4), because her gross income is below the exemption amount used for tax year 2025. She satisfies the support requirement in §152(d)(1)(C) because the taxpayer provided more than one-half of her total support, and the model's support calculation also passes through the support-adjustment rule corresponding to §152(d)(5)(A). She also satisfies §152(d)(1)(D) because she is not treated as a qualifying child of the taxpayer or of another taxpayer. Finally, she passes the global requirements in §152(b)(2) and §152(b)(3), since she did not file a joint return and the model treats her as a U.S. resident. Accordingly, the solver treats her as a dependent.

### Scenario 4

The individual is not a dependent because the global joint-return rule blocks dependent status. Under 26 U.S.C. §152(b)(2), an individual who filed a joint return with a spouse for the relevant year is not treated as a dependent, except in the limited refund-only situation incorporated elsewhere in the model. Here, the scenario states that the daughter and her spouse filed jointly for a real tax benefit rather than only to obtain a refund, so the joint-return bar applies. Because §152(a) defines dependency only when the statutory conditions are met and §152(b)(2) is not satisfied, the solver cannot consistently treat her as a dependent.

### Scenario 5

The individual is not a dependent because neither statutory route in §152(a) succeeds. First, he does not qualify as a qualifying child under §152(c), and the core highlights the age branch in §152(c)(1)(C): he is a 45-year-old brother, so he does not satisfy the qualifying-child age rule used by the model. Second, he does not qualify as a qualifying relative under §152(d) because the gross-income requirement in §152(d)(1)(B) is not satisfied. The core includes the effective-gross-income rule in §152(d)(4) and the gross-income threshold rule in §152(d)(1)(B), and under those rules his income of $18,600 is far above the exemption amount used in the model for tax year 2025. Since the qualifying-child path fails and the qualifying-relative path also fails, §152(a) cannot be satisfied, so he is not a dependent.

### Scenario 6

The individual is not a dependent of the aunt because the qualifying-child tie-breaker favors the child's mother, and the qualifying-relative route is also blocked. Under the model's implementation of 26 U.S.C. §152(c)(4), when a parent and a non-parent could both claim the same child, the parent has priority unless the statute's limited exceptions apply. The extracted core shows that this tie-breaker rule is decisive here, so the aunt cannot treat the nephew as her qualifying child even though he lived with her for most of the year. The core also includes §152(d)(1)(D), which requires that a qualifying relative not be a qualifying child of the taxpayer or of any other taxpayer. Because the nephew is treated in the scenario as a qualifying child of another taxpayer, the qualifying-relative path in §152(d) is unavailable as well. As a result, the final dependent definition in §152(a) cannot be satisfied for the aunt.

---

## 6. Layperson Explanations

### Scenario 1

He is a dependent because he fits the rules for a child dependent. He is the taxpayer's son, he lived with the taxpayer for more than half the year, he is under 19, he did not pay more than half of his own support, and he did not file a disqualifying joint return. Another parent could also try to claim him, but the taxpayer wins because the child lived with the taxpayer longer during the year. He also meets the citizenship or residency requirement.

### Scenario 2

She is a dependent because she still qualifies as the taxpayer's child dependent even though she is 29. She is the taxpayer's daughter, she lived with the taxpayer all year, she did not provide more than half of her own support, and she did not file a disqualifying joint return. Her disability is what allows her to satisfy the age-related part of the test. There is no competing taxpayer with a better claim, and she also meets the citizenship or residency requirement.

### Scenario 3

She is a dependent because she qualifies under the relative-dependent rules. She is the taxpayer's grandmother, her income is below the allowed limit, and the taxpayer paid more than half of her total support. She is also not being treated as someone else's qualifying child, she did not file a disqualifying joint return, and she meets the residency requirement used in the model. For those reasons, she counts as a dependent.

### Scenario 4

She is not a dependent because she filed a joint tax return with her spouse, and that blocks dependent status here. This was not just a return filed only to get a refund back; it was filed for a real tax benefit. Because of that joint return, she cannot be treated as a dependent in this scenario.

### Scenario 5

He is not a dependent because he fails both possible paths. He is too old to qualify as a child dependent, and he also does not qualify as a relative dependent because his income is too high. Since neither route works, he cannot be claimed as a dependent.

### Scenario 6

He is not a dependent of the aunt because his mother has the stronger claim under the priority rules for claiming a child. Even though he lived with the aunt for most of the year, the parent comes first here. He also cannot be treated as the aunt's relative dependent, because he is considered the qualifying child of another taxpayer. So the aunt cannot claim him as a dependent.
