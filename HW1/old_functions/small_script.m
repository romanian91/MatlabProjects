clc
clear
for i=1:10
w = gausswin(i*2);
w = w';
i;
old_size = size(w,2)
if(size(w,2) > 1) 
     neww = w(1:size(w,2)/2);
end
new_size = size(neww,2)

end