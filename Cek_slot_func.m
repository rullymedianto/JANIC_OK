function [cksl, cks2, cks3, cks4, cks5] = Cek_slot_func(contr)

AB = contr(6,:);
AC = contr(7,:);
AD = contr(8,:);
AE = contr(9,:);
AF = contr(10,:);

cksl = any(AB>0);
cks2 = any(AC>0);
cks3 = any(AD>0);
cks4 = any(AE>0);
cks5 = any(AF>0);