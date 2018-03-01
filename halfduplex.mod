/*********************************************
 * OPL 12.6.3.0 Model
 * Author: sky
 * Creation Date: Jan 18, 2018 at 9:26:51 AM
 *********************************************/
using CP;
int M=...;
float P2=...;
float H1[1..M][1..M]=...;
float B0=...;
float n0=...;
dvar int Yji1[1..M][1..M] in 0..1 ;

maximize	
B0*sum(i in 1..M)(
     log(1+P2*sum(j in 1..M:j!=i)(
             H1[j][i]*Yji1[j][i]/ //fenzi
               (n0+P2*sum(n in 1..M:n!=j)(
                        sum(q in 1..M)H1[n][i]*Yji1[n][q]
                      )
               )
           )
         )/log(2)
   );
 subject to
 {
forall(j,i in 1..M:j!=i&&i!=j)
 {
 SINRMINLimiationji:
 Yji1[j][i]==1 => 
    P2*H1[j][i]*Yji1[j][i]/
       (n0+P2*sum(n in 1..M:n!=j)(
                        sum(q in 1..M)H1[n][i]*Yji1[n][q]
              )
       )>=1;
 }
forall(i in 1..M)
{
Hangyueshu:
 sum(j in 1..M)
     Yji1[i][j]<=1;   
}                                                                                                           
forall(i in 1..M)
{
Liyueshu:  
    sum(j in 1..M)
     Yji1[j][i]<=1;   
}
forall(i in 1..M)
{
HalfDuplexLimiation:
  sum(j in 1..M)
    (Yji1[i][j]+Yji1[j][i])-Yji1[i][i]<=1;
}
forall(i,j in 1..M:i!=j&&j!=i)
{
ZengQiangyueshu:
Yji1[i][j]+Yji1[j][i]<=1;
}
forall(i in 1..M)
Zishenyueshu:
  Yji1[i][i]==0;
}


