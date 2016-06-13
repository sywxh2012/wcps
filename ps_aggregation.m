function [resultz] = ps_aggregation (call_count, rssi, emergency_instance)

resultz = zeros(call_count, 14);
countz = 1;

for i_pa = 1 : call_count
%     [result status]=python('tossim-event-client-ps.py', num2str(rssi), num2str(emergency_instance(1,1)), num2str(emergency_instance(1,2)), num2str(emergency_instance(1,3)), num2str(emergency_instance(1,4)));
    ei = [emergency_instance(1, 1:4), emergency_instance(1, 6:9)];
    [result status]=python('tossim-event-client-ss.py', num2str(rssi), num2str(ei(1, 1)), num2str(ei(1, 2)), num2str(ei(1, 3)), num2str(ei(1, 4)), num2str(ei(1, 5)), num2str(ei(1, 6)), num2str(ei(1, 7)), num2str(ei(1, 8)));
    resultz(i_pa, :) = str2num(result);
end