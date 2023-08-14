function [ nw ] = cut_weight_in_half( w )
% cut the w vector into two
      if(size(w,2) > 1) 
        nw = w(1:size(w,2)/2);
      end
end

