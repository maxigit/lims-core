%s!actions/create_\(\w\+\)!XXX/\1/create_\1!
%s!actions/update_\(\w\+\)!XXX/\1/update_\1!
%s!actions/\(\w\+\)!XXX/\1!

%s!persistence/sequel/\(\w\+\)!XXX/\1/\1_sequel_persistor/
%s!persistence/\(\w\+\)!XXX/\1/\1_persistor/

g/plate\|tube\|sample\|aliquot\|gel\|tag\|flowcell\|spin\|lane/s/XXX/laboratory
g/order\|batch\|study\|user/s/XXX/organization

