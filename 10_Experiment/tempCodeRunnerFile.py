import re

temp_count = 0

def new_temp():
    global temp_count
    temp = f"t{temp_count}"
    temp_count += 1
    return temp

def generate_tac(expr):
    tokens = re.findall(r'[a-zA-Z_][a-zA-Z0-9_]*|\d+|[\+\-\*/\(\)=><]', expr)
    output = []
    stack = []
    postfix = []
    prec = {'=': 0, '(': 1, '+': 2, '-': 2, '*': 3, '/': 3, '>': 2, '<': 2}

    # Infix to Postfix using Shunting Yard
    for token in tokens:
        if token.isalnum():
            postfix.append(token)
        elif token == '(':
            stack.append(token)
        elif token == ')':
            while stack and stack[-1] != '(':
                postfix.append(stack.pop())
            stack.pop()
        else:
            while stack and prec.get(token, 0) <= prec.get(stack[-1], 0):
                postfix.append(stack.pop())
            stack.append(token)

    while stack:
        postfix.append(stack.pop())

    # TAC from Postfix
    eval_stack = []
    for token in postfix:
        if token.isalnum():
            eval_stack.append(token)
        else:
            op2 = eval_stack.pop()
            op1 = eval_stack.pop()
            temp = new_temp()
            output.append(f"{temp} = {op1} {token} {op2}")
            eval_stack.append(temp)

    return output, eval_stack[0]

def process_line(line):
    if line.startswith("if"):
        condition = line.strip().replace('if', '').strip()
        code, result = generate_tac(condition)
        return code + [f"IF {result} GOTO label_true", "GOTO label_false"]
    elif '=' in line:
        lhs, rhs = [x.strip() for x in line.split('=')]
        code, result = generate_tac(rhs)
        code.append(f"{lhs} = {result}")
        return code
    else:
        return [f"// Unsupported or invalid line: {line.strip()}"]

# === MAIN PROGRAM ===
print("Enter C-style expressions or control structures (type 'done' to finish):\n")

lines = []
while True:
    line = input()
    if line.lower() == 'done':
        break
    if line.strip() != "":
        lines.append(line.strip())

print("\nGenerated Three Address Code:\n")
for line in lines:
    tac_code = process_line(line)
    for instr in tac_code:
        print(instr)
