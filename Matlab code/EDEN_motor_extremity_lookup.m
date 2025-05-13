function [cond, hand]=EDEN_motor_extremity_lookup(subid,extre,task)

if strcmp(extre,'Affected')
    if strcmp(subid,'001')
        hand='Left';
    elseif strcmp(subid,'002')
        hand='Left';
    elseif strcmp(subid,'003')
        hand='Right';
    elseif strcmp(subid,'004')
        hand='Left';
    elseif strcmp(subid,'005')    
        hand='Left';
    elseif strcmp(subid,'007')
        hand='Right';
    elseif strcmp(subid,'008')
        hand='Right';
    elseif strcmp(subid,'010')
        hand='Left';
    elseif strcmp(subid,'011')
        hand='Right';
    elseif strcmp(subid,'013')
        hand='Left';
    elseif strcmp(subid,'014')
        hand='Left';
    elseif strcmp(subid,'015')
        hand='Left';        
    end
    
else
    if strcmp(subid,'001')
        hand='Right';
    elseif strcmp(subid,'002')
        hand='Right';
    elseif strcmp(subid,'003')
        hand='Left';
    elseif strcmp(subid,'004')
        hand='Right';
    elseif strcmp(subid,'005')    
        hand='Right';
    elseif strcmp(subid,'007')
        hand='Left';
    elseif strcmp(subid,'008')
        hand='Left';
    elseif strcmp(subid,'010')
        hand='Right';
    elseif strcmp(subid,'011')
        hand='Left';
    elseif strcmp(subid,'013')
        hand='Right';
    elseif strcmp(subid,'014')
        hand='Right';
    elseif strcmp(subid,'015')
        hand='Right';     
    end
    
    
end

if strcmp(task,'BLK') || contains(task,'SIN')
    if strcmp(hand,'Left')
        cond=1;
    else
        cond=2;
    end
elseif strcmp(task,'ODD')
    if strcmp(hand,'Left')
        cond=[1 101];
    else
        cond=[10 110];
    end
else % other other RT tasks
    if strcmp(hand,'Left')
        cond=1;
    else
        cond=11;
    end
end