function Tab = PropSeed(Ig)
  Tab = regionprops(logical(Ig), 'Area','Eccentricity');
  Tab = cell2mat(struct2cell(Tab))';
end
