def parse_instruction(line):
    """
    Parses a TAC instruction into (lhs, rhs)
    lhs: left-hand side variable
    rhs: right-hand side expression
    """
    if '=' in line:
        lhs, rhs = line.split('=')
        return lhs.strip(), rhs.strip()
    return None, None

def copy_propagation(tac_lines):
    copies = {}
    optimized = []

    for line in tac_lines:
        lhs, rhs = parse_instruction(line)

        # If it's a direct copy like: a = b
        if rhs.isidentifier():
            copies[lhs] = rhs
            optimized.append(f"{lhs} = {rhs}  // copy")
        else:
            # Replace variables with known copies
            for key, val in copies.items():
                rhs = rhs.replace(key, val)
            optimized.append(f"{lhs} = {rhs}")
    return optimized

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
            optimized.append(f"{lhs} = {rhs}")
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
print("Enter TAC lines one by one (type 'done' to finish input):")
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

# Apply Copy Propagation
tac_cp = copy_propagation(tac_input)

# Apply CSE
tac_cse = common_subexpression_elimination(tac_cp)

# Apply DCE
tac_final = dead_code_elimination(tac_cse)

print("\n=== Optimized TAC (Copy Propagation + CSE + DCE) ===")
for line in tac_final:
    print(line)
