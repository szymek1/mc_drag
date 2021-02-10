function C_D_RB = C_D_RB(M,Geometry)

if M <= 0.95
    C_D_RB = M^12.5*(Geometry.rb_d-1);
else
    C_D_RB = (0.21+0.28/M^2)*(Geometry.rb_d-1);
end

end