#include<iostream>
#include<fstream>

using namespace std;

int N=0;
float p1,p2,pc1,pc2;
int yp,yn,yNp,yNn,yN1,yN2,ms,md,myNp,myNn;
float impurity,impurityC1,impurityC2,temp,thi,mthi1,bx,mj,mthi,mpc;
float *thita,*xs,*x;
int cnt=0;

class node
{
public:
    int d,s;
    float Thita; 
    node *Father,*Lchild,*Rchild;
};

void Qsort(float *arr,int low, int high)
{
    float s;
    int i,j;
    if(low<high)
    {
        s=arr[low];
        i=low+1;
        j=high;
        while(i<=j)
        {
            while(arr[i]<=s && i<high)
                i++;
            while(arr[j]>=s && j>low)
                j--;
            if(i>=j)
                break;
            else
            {
                temp=arr[i];
                arr[i]=arr[j];
                arr[j]=temp;
            }
        }
        arr[low]=arr[j];
        arr[j]=s;

        Qsort(arr,low,j-1);
        Qsort(arr,j+1,high);
    }
}

node* DT(node *parent,float *x1,float *x2,int *y,int n)
{
    cnt++;  
    cout<<"NODE NO."<<cnt<<endl;
    
    yp=0;  
    for(int i=0;i<n;i++)
    {
        if(y[i]==1)
           yp++;
    }
    p1=((float)yp/n);
    impurity=1-((p1)*(p1)+(1-p1)*(1-p1));
    //cout<<"impurity "<<impurity<<endl;
    
    if(impurity==0)
    {
        cout<<"p1 "<<p1<<" p2 "<<1-p1<<endl;           
        cout<<"LEAF "<<n<<endl<<endl;
        return NULL;    
    }       
    else
    {
        cout<<n<<endl;
        mj=-1;
        mpc=0;
        for(int d=1;d<=2;d++)
        {
           if(d==1)
           {     
               memcpy(x,x1,sizeof(float)*n);   
               memcpy(xs,x1,sizeof(float)*n);
               Qsort(xs,0,n-1); 
               for(int i=1;i<n;i++)
                  thita[i]=(xs[i-1]+xs[i])/2;
               thita[0]=xs[0]-0.001;
               thita[n]=xs[n-1]+0.001;
           }
           else //d==2
           {
               memcpy(x,x2,sizeof(float)*n);
               memcpy(xs,x2,sizeof(float)*n);
               Qsort(xs,0,n-1);
               for(int i=1;i<n;i++)
                  thita[i]=(xs[i-1]+xs[i])/2;
               thita[0]=xs[0]-0.001;
               thita[n]=xs[n-1]+0.001; 
           }
           for(int s=-1;s<=1;s++)
           {
               for(int i=0;i<n+1;i++)
               {   
                  //cout<<thita[i]<<endl;
                  yNp=0;
                  yN1=0;
                  yN2=0;
                  for(int j=0;j<n;j++)
                  {
                     if(s*(x[j]-thita[i])>=0)
                     {
                        yNp++;
                        if(y[j]==1)
                           yN1++;
                     }
                     else
                     {
                        if(y[j]==-1)
                           yN2++;
                     }
                  }
                  yNn=n-yNp;
                  if(yNp==0)
                     pc1=0;
                  else
                     pc1=((float)yN1/yNp);
                  impurityC1=1-((pc1)*(pc1)+(1-pc1)*(1-pc1)); 
                  if(yNn==0)
                     pc2=0;
                  else
                     pc2=((float)yN2/yNn);
                  impurityC2=1-((1-pc2)*(1-pc2)+(pc2)*(pc2));  
                  bx=impurity-(((float)yNp/n)*impurityC1+((float)yNn/n)*impurityC2);
                  //cout<<"yNp "<<yNp<<endl;
                  //cout<<"yNn "<<yNn<<endl;
                  //cout<<"iC1 "<<impurityC1<<endl;
                  //cout<<"iC2 "<<impurityC2<<endl; 
                  //cout<<bx<<endl;
                  //system("PAUSE");

                  if(bx>mj && pc1+pc2>mpc)
                  {
                      mj=bx;
                      mthi=thita[i];
                      ms=s;
                      md=d;
                      myNp=yNp;
                      myNn=yNn;
                      mpc=pc1+pc2;
                  }

               } //end thita[i]         
           } //end s
        } //end d  

        cout<<"mj "<<mj<<" mthi "<<mthi<<" ms "<<ms<<" md "<<md<<" myNp "<<myNp<<" myNn "<<myNn<<endl<<endl;
        //system("PAUSE");

        node *DTnode=new node();
        DTnode->Father=parent;
        DTnode->d=md;
        DTnode->s=ms;
        DTnode->Thita=mthi;
        //
        if(md==1)
           memcpy(x,x1,sizeof(float)*n);  
        else //md==2
           memcpy(x,x2,sizeof(float)*n);    
        float* x1c1=(float*)malloc(sizeof(float)*(myNp));
        float* x2c1=(float*)malloc(sizeof(float)*(myNp));
        int* y1=(int*)malloc(sizeof(float)*(myNp));
        float* x1c2=(float*)malloc(sizeof(float)*(myNn));
        float* x2c2=(float*)malloc(sizeof(float)*(myNn));
        int* y2=(int*)malloc(sizeof(float)*(myNn));

        int Np=0;
        int Nn=0;
        for(int j=0;j<n;j++)
        {
            if(ms*(x[j]-mthi)>=0)
            {
                x1c1[Np]=x1[j];
                x2c1[Np]=x2[j];
                y1[Np]=y[j];
                Np++;
            }
            else
            {
                x1c2[Nn]=x1[j];
                x2c2[Nn]=x2[j];
                y2[Nn]=y[j];
                Nn++;
            }
        }
        
        free(x1);
        free(x2);
        free(y);
        
        DTnode->Lchild=DT(DTnode,x1c1,x2c1,y1,Np);
        DTnode->Rchild=DT(DTnode,x1c2,x2c2,y2,Nn);;
        
        return DTnode;
    } //impurtiy!=0
} 
/*
void DFS(node* p)
{
     if(p!=NULL)
     {
         DFS(p->Lchild);       
         cout<<p->Thita<<endl;
         DFS(p->Rchild);
     }
}
*/
int DTPredict(node* ptr,float* x)
{
    if(ptr)
    {
        float p=(ptr->s)*((x[(ptr->d)-1])-(ptr->Thita));
        if(p>=0)
        {
            if(ptr->Lchild)
               return DTPredict(ptr->Lchild,x);
            else
               return 1;
        }
        else
        {   
            if(ptr->Rchild)
               return DTPredict(ptr->Rchild,x);
            else
               return -1;
        }
    }
    else
       cout<<"NULL!!! ERROR!!!"<<endl;
}

int main()
{
    ifstream fin0("hw7_train.dat");
    float a,b,c;
    while(!fin0.eof())
    {
        fin0>>a>>b>>c;
        N++;
    }
    fin0.close();
    cout<<N<<endl;
    float* x1=(float*)malloc(sizeof(float)*(N));
    float* x2=(float*)malloc(sizeof(float)*(N));
    int* y=(int*)malloc(sizeof(int)*(N));
    x=(float*)malloc(sizeof(float)*(N));
    xs=(float*)malloc(sizeof(float)*(N));
    thita=(float*)malloc(sizeof(float)*(N+1));
    ifstream fin("hw7_train.dat");
    for(int i=0;i<N;i++)
        fin>>x1[i]>>x2[i]>>y[i];
    fin.close();

    // Decision Tree
    node *root=DT(NULL,x1,x2,y,N);
    
    //DFS(root);

    free(x);
    free(xs);
    free(thita);
   
    //test
    int NT=0;
    ifstream fint0("hw7_test.dat");
    while(!fint0.eof())
    {
        fint0>>a>>b>>c;
        NT++;
    }
    fint0.close();
    
    cout<<"NT "<<NT<<endl;
    
    int* yT=(int*)malloc(sizeof(int)*(NT)); 
    int* yP=(int*)malloc(sizeof(int)*(NT)); 
    float x[2];
    ifstream fint("hw7_test.dat");
   
    int miss=0;
    for(int i=0;i<NT;i++)
    {
        fint>>x[0]>>x[1]>>yT[i];
        //cout<<x[0]<<" "<<x[1]<<" "<<yT[i]<<endl;
        yP[i]=DTPredict(root,x);
        //cout<<"OK"<<endl;
        //cout<<i<<" "<<yP[i]<<"  right "<<yT[i]<<endl;
        //system("PAUSE");
        if(yT[i]!=yP[i])
            miss++;
        //system("PAUSE");
    }    
    fint.close();
    float Eout=(float)miss/NT;
    cout<<"Eout= "<<Eout<<endl;
    
    cout<<endl;
    
    free(yT);
    free(yP);
    
    system("PAUSE");
    return 0;
}
