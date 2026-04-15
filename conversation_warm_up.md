## 👤 User
I am working with 26 U.S.C. §152(a)-(d) on tax dependents. (https://www.law.cornell.edu/uscode/text/26/152)

Generate exactly 6 realistic, fact-rich scenarios:
- 3 scenarios where the individual should count as a dependent
- 3 scenarios where the individual should not count as a dependent

Requirements:
- Each scenario must be interesting and nontrivial, not overly obvious
- Use concrete facts, not vague descriptions
- For each scenario, clearly state:
  - taxpayer age
  - individual age
  - relationship between them
  - whether the individual is a student
  - whether the individual is disabled
  - whether the individual filed a joint return
  - citizenship/residency facts
  - how many days they lived together during the tax year
  - the individual's gross income
  - total support for the individual
  - how much support was provided by the taxpayer
  - how much support was provided by the individual
  - whether another taxpayer could potentially claim the individual

Output format:
- Label them Scenario 1 to Scenario 6
- For each scenario, include:
  - short title
  - plain-English fact pattern
  - expected classification: dependent or not dependent

Do not analyze the law in detail. Focus on generating clean, concrete facts that can later be translated into SMT.

## 🤖 ChatGPT 5.3
Below are **6 concrete scenarios**, framed for **tax year 2025** so the qualifying-relative income numbers stay clean. They are calibrated to the §152 qualifying-child / qualifying-relative structure, including age, student, disability, joint-return, residency/citizenship, support, and possible competing-claimant issues. For 2025, IRS Publication 501 states that if a person’s **gross income was $5,200 or more, they usually can’t be claimed as a dependent unless they are a qualifying child**. 

## Scenario 1 — Split-custody teen with more nights at dad’s apartment

**Plain-English fact pattern**

* **Taxpayer age:** 41
* **Individual age:** 17
* **Relationship:** Son
* **Student:** Yes, full-time high school student
* **Disabled:** No
* **Filed a joint return:** No
* **Citizenship/residency facts:** U.S. citizen, lived all year in Connecticut
* **Days lived together during the tax year:** 214 days with the taxpayer, 151 days with the mother
* **Individual’s gross income:** $4,300 from a grocery store job
* **Total support for the individual:** $21,000
* **Support provided by the taxpayer:** $13,500
* **Support provided by the individual:** $2,800
* **Whether another taxpayer could potentially claim the individual:** **Yes** — the mother could potentially try to claim him because she is also a parent, but the child lived more days with the taxpayer

**Expected classification:** **Dependent**. 

---

## Scenario 2 — Permanently disabled adult daughter living at home

**Plain-English fact pattern**

* **Taxpayer age:** 58
* **Individual age:** 29
* **Relationship:** Daughter
* **Student:** No
* **Disabled:** Yes, permanently and totally disabled after a spinal cord injury several years ago
* **Filed a joint return:** No
* **Citizenship/residency facts:** U.S. citizen
* **Days lived together during the tax year:** 365 days
* **Individual’s gross income:** $3,900 from part-time remote clerical work
* **Total support for the individual:** $28,000
* **Support provided by the taxpayer:** $22,400
* **Support provided by the individual:** $3,900
* **Whether another taxpayer could potentially claim the individual:** No

**Expected classification:** **Dependent**. 

---

## Scenario 3 — Low-income grandmother supported by her grandson

**Plain-English fact pattern**

* **Taxpayer age:** 33
* **Individual age:** 74
* **Relationship:** Grandmother
* **Student:** No
* **Disabled:** No
* **Filed a joint return:** No; widowed
* **Citizenship/residency facts:** Lawful permanent resident of the United States for 18 years
* **Days lived together during the tax year:** 0 days; she lived in her own nearby apartment
* **Individual’s gross income:** $4,100 from a small taxable pension
* **Total support for the individual:** $19,500
* **Support provided by the taxpayer:** $12,300, covering rent, groceries, and prescriptions
* **Support provided by the individual:** $4,100
* **Whether another taxpayer could potentially claim the individual:** No; no one else provided over half of her support

**Expected classification:** **Dependent**. 
---

## Scenario 4 — Married college daughter who filed jointly for a real tax benefit

**Plain-English fact pattern**

* **Taxpayer age:** 52
* **Individual age:** 22
* **Relationship:** Daughter
* **Student:** Yes, full-time college student for the entire academic year
* **Disabled:** No
* **Filed a joint return:** **Yes** — she and her spouse filed a joint return to claim an education credit and recover withholding, and they had an actual tax liability computation beyond a pure refund-only filing
* **Citizenship/residency facts:** U.S. citizen
* **Days lived together during the tax year:** 245 days with the taxpayer when not on campus; the rest in a dorm
* **Individual’s gross income:** $8,700 from campus employment
* **Total support for the individual:** $24,000
* **Support provided by the taxpayer:** $16,500
* **Support provided by the individual:** $5,500
* **Whether another taxpayer could potentially claim the individual:** No

**Expected classification:** **Not dependent**. 

---

## Scenario 5 — Brother with too much income to be a qualifying relative

**Plain-English fact pattern**

* **Taxpayer age:** 47
* **Individual age:** 45
* **Relationship:** Brother
* **Student:** No
* **Disabled:** No
* **Filed a joint return:** No
* **Citizenship/residency facts:** U.S. citizen
* **Days lived together during the tax year:** 365 days; he moved into the taxpayer’s home after losing his lease
* **Individual’s gross income:** **$18,600** from freelance computer repair work
* **Total support for the individual:** $23,000
* **Support provided by the taxpayer:** $14,200
* **Support provided by the individual:** $8,000
* **Whether another taxpayer could potentially claim the individual:** No

**Expected classification:** **Not dependent**. 

---

## Scenario 6 — Nephew lives mostly with aunt, but his mother could still claim him

**Plain-English fact pattern**

* **Taxpayer age:** 38
* **Individual age:** 10
* **Relationship:** Nephew
* **Student:** Yes, elementary school student
* **Disabled:** No
* **Filed a joint return:** No
* **Citizenship/residency facts:** U.S. citizen
* **Days lived together during the tax year:** 240 days with the taxpayer (his aunt) because his mother worked out of state; 125 days with his mother
* **Individual’s gross income:** $0
* **Total support for the individual:** $14,000
* **Support provided by the taxpayer:** $9,500
* **Support provided by the individual:** $0
* **Whether another taxpayer could potentially claim the individual:** **Yes** — his mother could potentially claim him, and she is a parent

**Expected classification:** **Not dependent** for the aunt, because a parent is the competing claimant. 

If you want, I can turn these 6 directly into a JSON schema or SMT-friendly field-value format next.


