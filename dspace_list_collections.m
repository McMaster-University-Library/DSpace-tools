working_dir = 'D:/Local/DSpace-tools/';
cd(working_dir); 

% Web options - ensure we're getting data in JSON
opts = weboptions("HeaderFields",{'Accept' 'application/json'});

% Save as JSON
websave('dspace_collection_rest.json','https://macsphere.mcmaster.ca/rest/collections?offset=0&limit=5000',opts);

% Read JSON file from DSpace API to variable data
data = webread('https://macsphere.mcmaster.ca/rest/collections?offset=0&limit=5000',opts);
data = rmfield(data,"expand"); % remove 'expand', because it's a nested cell array (and we don't need it)
% Convert the structure variable "data" to a cell array
data_cell = (struct2cell(data))';

% Pull out headers
headers = (fieldnames(data))';

% Convert cell array to a data table
data_table = cell2table(data_cell,"VariableNames",headers);

% Save data table to an excel file
% writetable(data_table,[working_dir 'dspace-collections-' datetime('today','Format','yyyy-MM-dd') '.xlsx'])
writetable(data_table,[working_dir 'dspace-collections-' datestr(now,29) '.xlsx'])