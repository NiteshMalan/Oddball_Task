function data_scd1 = trybatchnew()
    
    addpath 'home/malann/Oddball Data/Matlab code'
    subj_list={'007','008','011','013','014','015'}; % prepballistic/goballistic
    task='ODD'; % 'BLK' 'GO' 'GOBALLISTIC' 'PREP' 'PREPBALLISTIC'
    stage={'implant' 'explant'}; % implant or explant

    base_dir='/home/malann/Oddball Data/';
    data_dir=[ base_dir 'EDEN' subj_list{1} '/ANALYSIS/'];
    

    data_file=[data_dir 'data_eogclean_All' stage{1} '_' task '_timelock_to_go_DYNOnOffset.mat'];
    
    dat = load(data_file);

    data_scd1 = Griptask_RT_compute_scd(dat.data_eogclean);
    

end



