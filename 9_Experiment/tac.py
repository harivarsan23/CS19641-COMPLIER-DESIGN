def generate_8086(tac_lines):
    asm = []
    for line in tac_lines:
        line = line.strip()
        if not line:
            continue

        if '=' in line:
            left, expr = [x.strip() for x in line.split('=')]
            tokens = expr.split()

            # Binary operations: a = b + c
            if len(tokens) == 3:
                op1, operator, op2 = tokens
                if operator == '+':
                    asm.append(f"; {left} = {op1} + {op2}")
                    asm.append(f"MOV AX, [{op1}]")
                    asm.append(f"ADD AX, [{op2}]")
                elif operator == '-':
                    asm.append(f"; {left} = {op1} - {op2}")
                    asm.append(f"MOV AX, [{op1}]")
                    asm.append(f"SUB AX, [{op2}]")
                elif operator == '*':
                    asm.append(f"; {left} = {op1} * {op2}")
                    asm.append(f"MOV AX, [{op1}]")
                    asm.append(f"MOV BX, [{op2}]")
                    asm.append("MUL BX")
                elif operator == '/':
                    asm.append(f"; {left} = {op1} / {op2}")
                    asm.append(f"MOV AX, [{op1}]")
                    asm.append("MOV DX, 0")
                    asm.append(f"MOV BX, [{op2}]")
                    asm.append("DIV BX")

                asm.append(f"MOV [{left}], AX")

            # Simple assignment: a = b
            elif len(tokens) == 1:
                asm.append(f"; {left} = {tokens[0]}")
                asm.append(f"MOV AX, [{tokens[0]}]")
                asm.append(f"MOV [{left}], AX")

            else:
                asm.append(f"; Unsupported TAC format: {line}")

    return '\n'.join(asm)

# === MAIN PROGRAM ===
print("Enter Three-Address Code (TAC) line by line.")
print("Type 'END' to finish input and generate 8086 assembly.\n")

tac_lines = []
while True:
    line = input("> ")
    if line.strip().upper() == "END":
        break
    tac_lines.append(line)

print("\nGenerated 8086 Assembly Code:\n")
assembly_code = generate_8086(tac_lines)
print(assembly_code)
