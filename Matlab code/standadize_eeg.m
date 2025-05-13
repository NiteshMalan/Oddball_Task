function data = standadize_eeg(data)

for jk =1: length(data.label)
    
    if strcmp(data.label{jk},'A1')
        data.label{jk}='FT9';
    elseif strcmp(data.label{jk},'A2')
        data.label{jk}='FT10';
    elseif strcmp(data.label{jk},'T3')
        data.label{jk}='T7';
    elseif strcmp(data.label{jk},'T4')
        data.label{jk}='T8';
    elseif strcmp(data.label{jk},'T5')
        data.label{jk}='TP9';
    elseif strcmp(data.label{jk},'T6')
        data.label{jk}='TP10';
    elseif strcmp(data.label{jk},'T1')
        data.label{jk}='P7';
    elseif strcmp(data.label{jk},'T2')
        data.label{jk}='P8';
    elseif strcmp(data.label{jk},'Afz')
        data.label{jk}='AFz';
    elseif strcmp(data.label{jk},'EMGL')
        data.label{jk}='EmgL';
    elseif strcmp(data.label{jk},'LFEMG')
        data.label{jk}='EmgL';
    elseif strcmp(data.label{jk},'LEMG')
        data.label{jk}='EmgL';
    elseif strcmp(data.label{jk},'EMGR')
        data.label{jk}='EmgR';
    elseif strcmp(data.label{jk},'REMG')
        data.label{jk}='EmgR';
    elseif strcmp(data.label{jk},'LFCR')
        data.label{jk}='DynL';
    elseif strcmp(data.label{jk},'RFCR')
        data.label{jk}='DynR';
    elseif strcmp(data.label{jk},'LFrc')
        data.label{jk}='DynL';
    elseif strcmp(data.label{jk},'RFrc')
        data.label{jk}='DynR';
    elseif strcmp(data.label{jk},'LForce')
        data.label{jk}='DynL';
    elseif strcmp(data.label{jk},'RForce')
        data.label{jk}='DynR';
    elseif strcmp(data.label{jk},'DYNL')
        data.label{jk}='DynL';
    elseif strcmp(data.label{jk},'DYNR')
        data.label{jk}='DynR';   
    elseif strcmp(data.label{jk},'R EDC EMG')
        data.label{jk}='EmgR EDC';
    elseif strcmp(data.label{jk},'L EDC EMG')
        data.label{jk}='EmgL EDC';
    elseif strcmp(data.label{jk},'R FCR EMG')
        data.label{jk}='EmgR FCR';
    elseif strcmp(data.label{jk},'L FCR EMG')
        data.label{jk}='EmgL FCR';
    elseif strcmp(data.label{jk},'R FCR')
        data.label{jk}='EmgR';
    elseif strcmp(data.label{jk},'L FCR')
        data.label{jk}='EmgL';
        
    % DBS Standardize 10/09/2020

    elseif strcmp(data.label{jk},'DBS1-DBS2') || strcmp(data.label{jk},'DBS 1-DBS 2')
        data.label{jk}='DBS1-2';    
    elseif strcmp(data.label{jk},'DBS2-DBS3') || strcmp(data.label{jk},'DBS 2-DBS 3')
        data.label{jk}='DBS2-3';     
    elseif strcmp(data.label{jk},'DBS3-DBS4') || strcmp(data.label{jk},'DBS 3-DBS 4')
        data.label{jk}='DBS3-4';
    elseif strcmp(data.label{jk},'DBS4-DBS5') || strcmp(data.label{jk},'DBS 4-DBS 5')
        data.label{jk}='DBS4-5'; 
    elseif strcmp(data.label{jk},'DBS5-DBS6') || strcmp(data.label{jk},'DBS 5-DBS 6')
        data.label{jk}='DBS5-6'; 
    elseif strcmp(data.label{jk},'DBS6-DBS7') || strcmp(data.label{jk},'DBS 6-DBS 7')
        data.label{jk}='DBS6-7';
    elseif strcmp(data.label{jk},'DBS7-DBS8') || strcmp(data.label{jk},'DBS 7-DBS 8')
        data.label{jk}='DBS7-8';    
    end
    
end



return