from __future__ import annotations
from pathlib import Path
from z3 import Bool, ModelRef, Solver, sat, unsat


ROOT = Path(__file__).resolve().parent
PROJECT5_ROOT = ROOT.parent
MODEL_PATH = PROJECT5_ROOT / "part1" / "dependent_rules_annotated.smt2"
RESULTS_PATH = ROOT / "solver_results.txt"


class ScenarioCase:
    def __init__(self, filename: str, title: str, expected_dependent: bool) -> None:
        self.filename = filename
        self.title = title
        self.expected_dependent = expected_dependent

    @property
    def path(self) -> Path:
        return ROOT / self.filename


CASES = [
    ScenarioCase(
        filename="scenario1_dependent.smt2",
        title="Scenario 1 - Split-custody teen with more nights at dad's apartment",
        expected_dependent=True,
    ),
    ScenarioCase(
        filename="scenario2_dependent.smt2",
        title="Scenario 2 - Permanently disabled adult daughter living at home",
        expected_dependent=True,
    ),
    ScenarioCase(
        filename="scenario3_dependent.smt2",
        title="Scenario 3 - Low-income grandmother supported by her grandson",
        expected_dependent=True,
    ),
    ScenarioCase(
        filename="scenario4_not_dependent.smt2",
        title="Scenario 4 - Married college daughter who filed jointly for a real tax benefit",
        expected_dependent=False,
    ),
    ScenarioCase(
        filename="scenario5_not_dependent.smt2",
        title="Scenario 5 - Brother with too much income to be a qualifying relative",
        expected_dependent=False,
    ),
    ScenarioCase(
        filename="scenario6_not_dependent.smt2",
        title="Scenario 6 - Nephew lives mostly with aunt, but his mother could still claim him",
        expected_dependent=False,
    ),
]


def load_solver(extra_smt: str = "") -> Solver:
    solver = Solver()
    solver.from_string(MODEL_PATH.read_text())
    if extra_smt:
        solver.from_string(extra_smt)
    return solver


def eval_bool(model: ModelRef, expr_name: str) -> bool:
    value = model.eval(Bool(expr_name), model_completion=True)
    return bool(value)


def classify_case(case: ScenarioCase) -> tuple[str, bool]:
    solver = load_solver(case.path.read_text())
    result = solver.check()
    if result != sat:
        raise RuntimeError(f"{case.filename} did not produce a satisfiable base model: {result}")
    model = solver.model()
    return str(result), eval_bool(model, "is_dependent")


def opposite_assertion(expected_dependent: bool) -> str:
    if expected_dependent:
        return "(assert (not is_dependent))\n"
    return "(assert is_dependent)\n"


def explain_core_role(expected_dependent: bool) -> str:
    if expected_dependent:
        return "supporting rules"
    return "blocking rules"


def run_core_query(case: ScenarioCase) -> tuple[str, list[str]]:
    solver = load_solver(case.path.read_text() + "\n" + opposite_assertion(case.expected_dependent))
    result = solver.check()
    if result != unsat:
        return str(result), []
    core = sorted(str(item) for item in solver.unsat_core())
    return str(result), core


def format_case_output(case: ScenarioCase) -> str:
    base_result, dependent_value = classify_case(case)
    opposite_result, core = run_core_query(case)
    opposite_query = "(assert (not is_dependent))" if case.expected_dependent else "(assert is_dependent)"
    classification_matches = dependent_value == case.expected_dependent

    lines = [
        f"{case.title}",
        f"file = {case.filename}",
        f"expected_dependent = {str(case.expected_dependent).lower()}",
        f"base_check = {base_result}",
        f"is_dependent = {str(dependent_value).lower()}",
        f"classification_matches_expectation = {str(classification_matches).lower()}",
        f"opposite_query = {opposite_query}",
        f"opposite_check = {opposite_result}",
    ]

    if core:
        lines.append(f"core_role = {explain_core_role(case.expected_dependent)}")
        lines.append("unsat_core =")
        lines.extend(f"- {label}" for label in core)
    else:
        lines.append("unsat_core = <none>")

    return "\n".join(lines)


def main() -> None:
    sections = ["Part 2 unsat-core checks", ""]
    for case in CASES:
        sections.append(format_case_output(case))
        sections.append("")

    output = "\n".join(sections).rstrip() + "\n"
    RESULTS_PATH.write_text(output)
    print(output, end="")


if __name__ == "__main__":
    main()
