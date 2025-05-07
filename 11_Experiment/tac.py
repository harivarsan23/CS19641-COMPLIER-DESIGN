def parse_instruction(line):
    """
    Parses a TAC instruction into (lhs, rhs) where:
    lhs: left-hand side variable
    rhs: right-hand expression (e.g., 'a + b')
    """
    if '=' in line:
        lhs, rhs = line.split('=')
        return lhs.strip(), rhs.strip()
    return None, None

def common_subexpression_elimination(tac_lines):
    seen_exprs = {}
    optimized = []

    for line in tac_lines:
        lhs, rhs = parse_instruction(line)
        if rhs is None:
            optimized.append(line)
            continue
        if rhs in seen_exprs:
            prev_lhs = seen_exprs[rhs]
            optimized.append(f"{lhs} = {prev_lhs}  // CSE")
        else:
            seen_exprs[rhs] = lhs
            optimized.append(line)
    return optimized

def dead_code_elimination(tac_lines):
    used_vars = set()
    for line in tac_lines:
        _, rhs = parse_instruction(line)
        if rhs:
            tokens = rhs.replace('+', ' ').replace('-', ' ').replace('*', ' ') \
                        .replace('/', ' ').replace('(', ' ').replace(')', ' ').split()
            for token in tokens:
                if token.isidentifier():
                    used_vars.add(token)

    optimized = []
    for line in tac_lines:
        lhs, _ = parse_instruction(line)
        if lhs in used_vars or '//' in line:
            optimized.append(line)
        else:
            optimized.append(f"// DCE: {line}")
    return optimized

# === MAIN PROGRAM ===
print("Enter Three Address Code (TAC) lines (type 'done' to finish input):")
tac_input = []
while True:
    line = input()
    if line.lower() == 'done':
        break
    if line.strip():
        tac_input.append(line.strip())

print("\n=== Original TAC ===")
for line in tac_input:
    print(line)

# Apply CSE
tac_after_cse = common_subexpression_elimination(tac_input)

# Apply DCE
tac_after_dce = dead_code_elimination(tac_after_cse)

print("\n=== Optimized TAC (with CSE and DCE) ===")
for line in tac_after_dce:
    print(line)
