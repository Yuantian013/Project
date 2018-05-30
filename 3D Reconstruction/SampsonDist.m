function d=SampsonDist(F,points1,points2)
    points1_aug=[points1;ones(1,size(points1,2))];
    points2_aug=[points2;ones(1,size(points2,2))];
    Fp=F*points1_aug;
    FT_p=F'*points1_aug;
    d_numerator=diag(points2_aug'*F*points1_aug).^2;
    d_denominator=Fp(1,:).^2+Fp(2,:).^2+FT_p(1,:).^2+FT_p(2,:).^2;
    d=d_numerator'./d_denominator;   
end