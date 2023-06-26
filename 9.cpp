

Cpp code:
# include<iostream>
# include<string.h>
# include<stdlib.h>
using namespace std;
class node
{
public: char data;
int r;
node *left,*right;
node()
{
left=right=NULL;
}
node(int x)
{
data=x;
left=right=NULL;
}
};
class rstack
{
char reg[10][4];
int top;
public:
rstack()
{
top=-1;
}
void init(int k,char *name);
void swap()
{
char name[10];
strcpy(name,reg[top]);
strcpy(reg[top],reg[top-1]);
strcpy(reg[top-1],name);
}
char *pop()
{
return(reg[top--]);
}
int topv()
{
return top;
}
void push(char *tr)
{
strcpy(reg[++top],tr);
}
char *topd()
{
return (reg[top]);
}
};
void rstack::init(int k,char *name)
{ char temp[3];
for(int i=k-1;i>=0;i--)
{
strcpy(reg[++top],name);
//itoa(i,temp,10);
snprintf(temp, 10, "%d", i);
strcat(reg[top],temp);
}
}
class tree
{
node *root;
rstack m,tstack;
int rg;
public:
tree(){root=NULL;}
node *create1();
void disp(char c);
void preorder(node *t);
void create() {root=create1();}
void preorder() {preorder(root);}
void label(node * t);
void label(){label(root);}
void gencode(node *t);
void gencode()
{
cout<<"enter regs\n";
cin>>rg;
m.init(rg,"R");
tstack.init(6,"T");
gencode(root);
}
};
void tree::disp(char c)
{
switch(c)
{
case '+' : cout<<"ADD ";
break;
case '*' :cout<<"MUL ";
break;
case '-':cout<<"SUB ";
break;
case '/':cout<<"DIV ";
break;
}
}
void tree::gencode(node *t)
{ char *name,*name1;
/*case 0*/
if(t->r==1&&t->left==NULL&&t->right==NULL)
{
cout<<"MOV "<<t->data<<","<<m.topd()<<"\n";;
}
/*case 1*/
else
if(t->left!=NULL&&t->right->r==0)
{
gencode(t->left);
disp(t->data);
cout<<t->right->data<<" "<<m.topd()<<"\n";
}
/*case 2*/
else
if((t->left->r<t->right->r)&&(t->left->r<rg))
{
// cout<<"case 2\n";
m.swap();
gencode(t->right);
name=m.pop();
// cout<<"popped reg "<<name<<"\n"<<"top= "<<m.topv()<<"\n";
gencode(t->left);
disp(t->data);
cout<<name<<" " <<","<<m.topd()<<"\n";
m.push(name);
m.swap();
}
/*case 3*/
else if((t->right->r<=t->left->r)&& (t->right->r<rg))
{
// cout<<"case 3\n";
gencode(t->left);
name=m.pop();
// cout<<"popped reg "<<name<<"\n"<<"top= "<<m.topv();
gencode(t->right);
disp(t->data);
cout<<m.topd()<<","<<name<<"\n";
m.push(name);
}
else
{
gencode(t->right);
name=tstack.pop();
cout<<"MOV "<<m.topd()<<","<<name<<"\n";
gencode(t->left);
disp(t->data);
cout<<name<<","<<m.topd()<<"\n";
tstack.push(name);
}
}
void tree::label(node *t)
{
if(t->left->left==NULL&&t->left->right==NULL)
{
t->left->r=1;
}
if(t->left->left!=NULL||t->left->right!=NULL)
label(t->left);
if(t->right->left==NULL&&t->right->right==NULL)
{
t->right->r=0;
}
if(t->right->left!=NULL||t->right->right!=NULL)
label(t->right);
if(t->left!=NULL&&t->right!=NULL)
{
if(t->left->r>t->right->r)
t->r=t->left->r;
else if(t->right->r>t->left->r)
t->r=t->right->r;
else
t->r=t->left->r+1;
}
}
node *tree::create1()
{
node *p;
char x;
cout<<"Enter node data\n";
cin>>x;
if(x=='Z')
return NULL;
else
{
p=new node(x);
cout<<"Enter left child of "<<x<<endl;
p->left=create1();
cout<<"Enter right child of "<<x<<endl;
p->right=create1();
}
return p;
}
void tree::preorder(node *t)
{
if(t)
{
cout<<t->data<<"\t"<<"(label="<<t->r<<")\t";
preorder(t->left);
preorder(t->right);
}
}
int main()
{
tree t;
int choice,n;
char ch;
do
{
cout<<"******MENU******\n";
cout<<"case 1:create tree\n";
cout<<"case 2:preorder\n";
cout<<"case 3:label\n";
cout<<"case 4:gencode\n";
cout<<"Enter your choice\n";
cin>>choice;
switch(choice)
{
case 1: t.create();
break;
case 2:t.preorder();
break;
case 3:t.label();
break;
case 4:t.gencode();
break;
default:exit(0);
}
cout<<"\nDo you want to continue\n";
cin>>ch;
}while(ch=='y');
return 0;
}


