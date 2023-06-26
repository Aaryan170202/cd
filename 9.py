class Node:
    def __init__(self, data=None):
        self.data = data
        self.r = 0
        self.left = None
        self.right = None

class RStack:
    def __init__(self):
        self.reg = [""] * 10
        self.top = -1
    
    def init(self, k, name):
        for i in range(k-1, -1, -1):
            self.top += 1
            self.reg[self.top] = name + str(i)

    def swap(self):
        name = self.reg[self.top]
        self.reg[self.top] = self.reg[self.top-1]
        self.reg[self.top-1] = name

    def pop(self):
        self.top -= 1
        return self.reg[self.top+1]

    def topv(self):
        return self.top

    def push(self, tr):
        self.top += 1
        self.reg[self.top] = tr

    def topd(self):
        return self.reg[self.top]

class Tree:
    def __init__(self):
        x = input("Enter root node: ")
        self.root = self.create(x)
        self.m = RStack()
        self.tstack = RStack()
        self.rg = 0

        
    def create(self, x):
        if x == '':
            return None
        else:
            p = Node(x)
            l = input(f"Enter left child of {x} : ")
            p.left = self.create(l)
            r = input(f"Enter right child of {x} :")
            p.right = self.create(r)
        return p

    def disp(self, c):
        if c == '+':
            print("ADD", end=" ")
        elif c == '*':
            print("MUL", end=" ")
        elif c == '-':
            print("SUB", end=" ")
        elif c == '/':
            print("DIV", end=" ")

    def gencode(self, t):
        if t.r == 1 and t.left is None and t.right is None:
            print("MOV", t.data, ",", self.m.topd())
        elif t.left is not None and t.right.r == 0:
            self.gencode(t.left)
            self.disp(t.data)
            print(t.right.data, self.m.topd())
        elif t.left.r < t.right.r and t.left.r < self.rg:
            self.m.swap()
            self.gencode(t.right)
            name = self.m.pop()
            self.gencode(t.left)
            self.disp(t.data)
            print(name, ",", self.m.topd())
            self.m.push(name)
            self.m.swap()
        elif t.right.r <= t.left.r and t.right.r < self.rg:
            self.gencode(t.left)
            name = self.m.pop()
            self.gencode(t.right)
            self.disp(t.data)
            print(self.m.topd(), ",", name)
            self.m.push(name)
        else:
            self.gencode(t.right)
            name = self.tstack.pop()
            print("MOV", self.m.topd(), ",", name)
            self.gencode(t.left)
            self.disp(t.data)
            print(name, ",", self.m.topd())
            self.tstack.push(name)

    def label(self, t):
        if t.left.left is None and t.left.right is None:
            t.left.r = 1
        if t.left.left is not None or t.left.right is not None:
            self.label(t.left)
        if t.right.left is None and t.right.right is None:
            t.right.r = 0
        if t.right.left is not None or t.right.right is not None:
            self.label(t.right)
        if t.left is not None and t.right is not None:
            if t.left.r > t.right.r:
                t.r = t.left.r
            elif t.right.r > t.left.r:
                t.r = t.right.r
            else:
                t.r = t.left.r + 1

    def preorder(self, t):
        if t:
            print(t.data, "\t(label=", t.r, ")\t")
            self.preorder(t.left)
            self.preorder(t.right)

t = Tree()
print("\nTree: ")
t.preorder(t.root)
print("\nLabeled tree: ")
t.label(t.root)
t.preorder(t.root)
t.rg = int(input("\nEnter number of registers: "))
t.m.init(t.rg, "R")
t.tstack.init(6, "T")
print("\nGenerated code: ")
t.gencode(t.root)
