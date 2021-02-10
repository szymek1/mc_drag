function McDrag = McDrag(mach_first,mach_last,mach_step, ...
    reference_diamter,total_length,nose_length,headshape, ...
    boattail_length,base_diamter,meplat_diameter, ...
    rotating_band_diamter,layer_type,nosecone_lenght,mm)
% function compute the values of rocket/projectile drag coefficients 
% according mach values and geometry 

Geometry.r_d = reference_diamter;
Geometry.t_l = total_length; 
Geometry.n_l = nose_length; 
Geometry.h = headshape;
Geometry.bt_l = boattail_length; 
Geometry.b_d = base_diamter; 
Geometry.m_d = meplat_diameter;
Geometry.rb_d = rotating_band_diamter;
Geometry.l_t = layer_type;
Geometry.nosecone_l = nosecone_lenght;

if mm > 0
    Geometry.t_l = total_length/reference_diamter; 
    Geometry.n_l = nose_length/reference_diamter; 
    Geometry.bt_l = boattail_length/reference_diamter; 
    Geometry.b_d = base_diamter/reference_diamter; 
    Geometry.m_d = meplat_diameter/reference_diamter;
    Geometry.rb_d = rotating_band_diamter/reference_diamter;
    Geometry.nosecone_l = nosecone_lenght/reference_diamter;
end

mach_values = mach_first:mach_step:mach_last;
McDrag = zeros(size(mach_values,2),6);

% compute drag coefficients according mach values
for i = 1:size(mach_values,2)
    % compute pressure drag coefficient due to projectile head (nose) 
    McDrag(i,1) = C_D_H(mach_values(i),Geometry);
    % compute pressure drag coefficient due to boattail (or flare)
    McDrag(i,2) = C_D_BT(mach_values(i),Geometry);
    % compute pressure drag coefficient due to the blunt base
    McDrag(i,3) = C_D_B(mach_values(i),Geometry);
    % compute pressure drag coefficient due to a rotating band 
    McDrag(i,4) = C_D_RB(mach_values(i),Geometry);
    % compute skin friction drag coefficient due to the entire SF
    % projectile wetted surface
    McDrag(i,5) = C_D_SF(mach_values(i),Geometry);
end

% compute total drag coefficient
McDrag(:,6) = sum(McDrag,2);

end