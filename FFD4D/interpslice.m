%this function was created as a method of performing 3 Dimension
%interpolations on large matrices while conserving memory. Assuming the
%images are only being interpolated in 2 dimensions they can thus be
%deconstructed into their individual slices in the Z direction and
%interpolated slice by slice and then reconstructed. 
function image2 = interpslice(image1,sz2)

sz = size(image1);
save('tempslice.m','');
for p = 1:sz(3)
eval(sprintf(['slice' num2str(p) ' = image1(:,:,p);']));
eval(sprintf(['save(''' 'tempslice.m''' ',''' 'slice' num2str(p) ''',''' '-append''' ');' ]));
eval(sprintf(['clear slice' num2str(p) ';']));
end
clear image1
image2 = zeros(sz2(1),sz2(2),sz2(3));
for p = 1:sz(3)
eval(sprintf(['load(''' 'tempslice.m''' ',''' 'slice' num2str(p) ''',''' '-mat''' ');']));
eval(sprintf(['curslice = slice' num2str(p) ';']));
curslice = interp2(repmat(1:sz(2),[sz(1),1]),repmat((1:sz(1))',[1,sz(2)]),curslice,repmat(1:(sz(2)-1)/(sz2(2)-1):sz(2),[sz2(1),1]),repmat((1:(sz(1)-1)/(sz2(1)-1):sz(1))',[1,sz2(2)]),'spline');
image2(:,:,p) = curslice;
end