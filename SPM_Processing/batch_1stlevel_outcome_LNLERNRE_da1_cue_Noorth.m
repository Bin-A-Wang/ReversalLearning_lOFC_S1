% List of open inputs
function batch_1stlevel_outcome_LNLERNRE_da1_cue_Noorth(RootDir,Subjects)  

Nr_run=3;
cond_name={'outcome_LN','outcome_LE','outcome_RN','outcome_RE','outcome_unsigned',...
           'outcome_late response','cue_all','cue_late response'};
modulators={'LN_da1','LN_outcomes','LE_da1','LE_outcomes','RN_da1','RN_outcomes','RE_da1','RE_outcomes'};

output_name=['Results_outcome_LNLERNRE_da1_cue_new2_Noorth'];
job_name=['Model_1stlevel_outcome_LNLERNRE_da1_cue_new2_Noorth.mat'];
prfx='Sub';

%% define the name and contrast
contrast_name={'Outcome_LEvsRN', 'Outcome_LEvsRE',...
               'Outcome_LN_da1','Outcome_LE_da1','Outcome_RN_da1','Outcome_RE_da1','Outcome_all_da1',...
               'Outcome_LEvsRN_da1','Outcome_LEvsRE_da1','Outcome_RNvsRE_da1'};


contrast= {[0 0 0 1 0 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
           [0 0 0 1 0 0 0 0 0 -1 0 0 0 0 0 0 0 0 0 0 0 0];
           [0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
           [0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
           [0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
           [0 0 0 0 0 0 0 0 0 0 1 0 0 0 0 0 0 0 0 0 0 0];
           [0 1 0 0 1 0 0 1 0 0 1 0 0 0 0 0 0 0 0 0 0 0];
           [0 0 0 0 1 0 0 -1 0 0 0 0 0 0 0 0 0 0 0 0 0 0];
           [0 0 0 0 1 0 0 0 0 0 -1 0 0 0 0 0 0 0 0 0 0 0];
           [0 0 0 0 0 0 0 1 0 0 0 -1 0 0 0 0 0 0 0 0 0 0]}; 
       
inputdir=[RootDir,'Preprocessing_RL\'];
outputdir=[RootDir,'Results_OFC_S1\Participants\'];
       
%% loop for each subject
for i=1:length(Subjects)
    
    sub=Subjects(i);
    inputpath= [inputdir,prfx,num2str(sub,'%.2d')];
    outputpath= [outputdir,prfx,num2str(sub,'%.2d'),'\',output_name];
    
    %% get the path of processed swra* file in 3 RUNs
    clear file_all filePath
    for j=1:Nr_run
        datapath=[inputpath,'\RUN',num2str(j),'\'];
        datadir=dir([datapath,'\swr*']);
        for i = 1:length(datadir)
            filePath{i,j} = [datapath,datadir(i).name];
        end
    end
    
    file_all=[filePath(:,1);filePath(:,2);filePath(:,3)];
    id=cellfun('length',file_all);
    file_all(id==0)=[];
    
    
    
    %% get the onset for conditions in 3 RUNs
    
    load([outputdir,prfx,num2str(sub,'%.2d'),'\Onset_cue_all.mat'],'onset_cue_all','onset_cue_missing_all');
    load([outputdir,prfx,num2str(sub,'%.2d'),'\Onset_outcome_all.mat']); 
    
  
    %% get the parameter value for modulators in 3 RUNs
    load([outputdir,prfx,num2str(sub,'%.2d'),'\Results_HGF_2level.mat']);%Creat a mat fime to save all parameter value for each subject %%Extract_traj_val.m
    LogDir=['D:\Bochum\DATA\fMRI_RL_GoNoGo\Logfile\'];
    Result=importdata([LogDir,'sub' num2str(sub,'%.2d') '_RL_Go_NoGo_results_all.txt']);
    
    Index_B1=[ones(10,1);0;0;2*ones(10,1);3*ones(10,1);0;0;0;4*ones(10,1)];
    Index_B2=[ones(10,1);0;0;0;0;2*ones(10,1);3*ones(10,1);0;4*ones(10,1)];
    Index_B3=[ones(10,1);0;2*ones(10,1);3*ones(10,1);0;0;0;0;4*ones(10,1)];
    Index_B4=[ones(10,1);0;0;0;2*ones(10,1);3*ones(10,1);0;0;4*ones(10,1)];
    Index_B5=[ones(10,1);0;0;0;0;0;2*ones(10,1);3*ones(10,1);4*ones(10,1)];
    Index_B6=[ones(10,1);0;0;2*ones(10,1);3*ones(10,1);0;0;0;4*ones(10,1)];
    Index_B7=[ones(10,1);0;0;0;0;2*ones(10,1);3*ones(10,1);0;4*ones(10,1)];
    Index_B8=[ones(10,1);2*ones(10,1);3*ones(10,1);0;0;0;0;0;4*ones(10,1)];
    Index_B9=[ones(10,1);2*ones(10,1);3*ones(10,1);0;0;0;0;0;4*ones(10,1)];
    Index_B10=[ones(10,1);0;0;0;0;2*ones(10,1);3*ones(10,1);0;4*ones(10,1)];
    Index_B11=[ones(10,1);0;0;0;2*ones(10,1);3*ones(10,1);0;0;4*ones(10,1)];
    Index_B12=[ones(10,1);0;2*ones(10,1);3*ones(10,1);0;0;0;0;4*ones(10,1)];
    
    Index_all=[Index_B1;Index_B2;Index_B3;Index_B4;Index_B5;Index_B6;Index_B7;...
               Index_B8;Index_B9;Index_B10;Index_B11;Index_B12]; %1-LN;2-LE;3-RN;4-RE
       
    da1_all=[];
    for n=1:12
        m=abs(est_obs_all{1,n}.traj.da(:,1));
        da1_all=[da1_all;m];
    end
    
    Index_outcome=[Result.data(:,[7]),Index_all,da1_all];  
    
    da1_LN=Index_outcome(Index_outcome(:,1)~=5&Index_outcome(:,2)==1,3);
    da1_LE=Index_outcome(Index_outcome(:,1)~=5&Index_outcome(:,2)==2,3);
    da1_RN=Index_outcome(Index_outcome(:,1)~=5&Index_outcome(:,2)==3,3);
    da1_RE=Index_outcome(Index_outcome(:,1)~=5&Index_outcome(:,2)==4,3);
    
    outcomes=double([Index_outcome(:,1)==1|Index_outcome(:,1)==4]);

    outcomes_LN=outcomes(Index_outcome(:,1)~=5&Index_outcome(:,2)==1);
    outcomes_LE=outcomes(Index_outcome(:,1)~=5&Index_outcome(:,2)==2);
    outcomes_RN=outcomes(Index_outcome(:,1)~=5&Index_outcome(:,2)==3);
    outcomes_RE=outcomes(Index_outcome(:,1)~=5&Index_outcome(:,2)==4);
    
    %% get the file path of head movement parameters
    Headfiles = fullfile(inputpath,'rp_all.txt');
    
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  first level speficication
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear matlabbatch
    
    matlabbatch{1}.spm.stats.fmri_spec.dir = {outputpath};
    matlabbatch{1}.spm.stats.fmri_spec.timing.units = 'secs';
    matlabbatch{1}.spm.stats.fmri_spec.timing.RT = 2.2;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t = 16;
    matlabbatch{1}.spm.stats.fmri_spec.timing.fmri_t0 = 8;
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).scans = file_all;%%
    
       
    % cond01
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).name =  cond_name{1};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).onset = onset_outcome_LN_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).tmod = 0;
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).pmod(1).name = modulators{1};
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).pmod(1).param = da1_LN;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).pmod(1).poly = 1;
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).pmod(2).name = modulators{2};
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).pmod(2).param = outcomes_LN;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).pmod(2).poly = 1;
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(1).orth = 0; 
    
    % cond02
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).name =  cond_name{2};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).onset = onset_outcome_LE_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).tmod = 0;
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).pmod(1).name = modulators{3};
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).pmod(1).param = da1_LE;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).pmod(1).poly = 1;

    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).pmod(2).name = modulators{4};
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).pmod(2).param = outcomes_LE;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).pmod(2).poly = 1;    
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(2).orth = 0;
    
    % cond03
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).name = cond_name{3}; %%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).onset = onset_outcome_RN_all; %%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).tmod = 0;
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).pmod(1).name = modulators{5};
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).pmod(1).param = da1_RN;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).pmod(1).poly = 1;

    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).pmod(2).name = modulators{6};
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).pmod(2).param = outcomes_RN;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).pmod(2).poly = 1;    
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(3).orth = 0;
    
    % cond04
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).name =  cond_name{4};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).onset = onset_outcome_RE_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).tmod = 0;
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).pmod(1).name = modulators{7};
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).pmod(1).param = da1_RE;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).pmod(1).poly = 1;
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).pmod(2).name = modulators{8};
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).pmod(2).param = outcomes_RE;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).pmod(2).poly = 1;    
    
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(4).orth = 0;
    
    % cond05
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).name =  cond_name{5};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).onset = onset_outcome_unsigned_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(5).orth = 0;
    
    % cond06
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(6).name =  cond_name{6};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(6).onset = onset_outcome_missing_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(6).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(6).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(6).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(6).orth = 0;
    
    
    % cond07
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(7).name = cond_name{7}; %%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(7).onset = onset_cue_all; %%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(7).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(7).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(7).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(7).orth = 0;
    
    % cond08
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(8).name =  cond_name{8};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(8).onset = onset_cue_missing_all;%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(8).duration = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(8).tmod = 0;
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(8).pmod = struct('name', {}, 'param', {}, 'poly', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).cond(8).orth = 0;
    
    %
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi = {''};
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).regress = struct('name', {}, 'val', {});
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).multi_reg = {Headfiles};%%
    matlabbatch{1}.spm.stats.fmri_spec.sess(1).hpf = 128;

    %
    matlabbatch{1}.spm.stats.fmri_spec.fact = struct('name', {}, 'levels', {});
    matlabbatch{1}.spm.stats.fmri_spec.bases.hrf.derivs = [0 0];
    matlabbatch{1}.spm.stats.fmri_spec.volt = 1;
    matlabbatch{1}.spm.stats.fmri_spec.global = 'None';
    matlabbatch{1}.spm.stats.fmri_spec.mthresh = 0.8;
    matlabbatch{1}.spm.stats.fmri_spec.mask = {''};
    matlabbatch{1}.spm.stats.fmri_spec.cvi = 'AR(1)';
    

    save([outputdir,prfx,num2str(sub,'%.2d'),'\',job_name], 'matlabbatch');
    
    % run job
    spm_jobman('run',matlabbatch);
    
    %% concatenate three sessions
    scans = [453 453 453];
    spm_fmri_concatenate([outputpath,'\SPM.mat'], scans);
    
    
    %% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %  model estimation and result check
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    clear matlabbatch
    
    matlabbatch{1}.spm.stats.fmri_est.spmmat = {[outputpath,'\SPM.mat']};
    matlabbatch{1}.spm.stats.fmri_est.write_residuals = 0;
    matlabbatch{1}.spm.stats.fmri_est.method.Classical = 1;
    
    matlabbatch{2}.spm.stats.con.spmmat(1) = cfg_dep('Model estimation: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
    matlabbatch{2}.spm.stats.con.consess{1}.tcon.name = contrast_name{1};
    matlabbatch{2}.spm.stats.con.consess{1}.tcon.weights = contrast{1};
    matlabbatch{2}.spm.stats.con.consess{1}.tcon.sessrep = 'none';
    matlabbatch{2}.spm.stats.con.consess{2}.tcon.name = contrast_name{2};
    matlabbatch{2}.spm.stats.con.consess{2}.tcon.weights = contrast{2};
    matlabbatch{2}.spm.stats.con.consess{2}.tcon.sessrep = 'none';
    matlabbatch{2}.spm.stats.con.consess{3}.tcon.name = contrast_name{3};
    matlabbatch{2}.spm.stats.con.consess{3}.tcon.weights = contrast{3};
    matlabbatch{2}.spm.stats.con.consess{3}.tcon.sessrep = 'none';
    matlabbatch{2}.spm.stats.con.consess{4}.tcon.name = contrast_name{4};
    matlabbatch{2}.spm.stats.con.consess{4}.tcon.weights = contrast{4};
    matlabbatch{2}.spm.stats.con.consess{4}.tcon.sessrep = 'none';
    matlabbatch{2}.spm.stats.con.consess{5}.tcon.name = contrast_name{5};
    matlabbatch{2}.spm.stats.con.consess{5}.tcon.weights = contrast{5};
    matlabbatch{2}.spm.stats.con.consess{5}.tcon.sessrep = 'none';
    matlabbatch{2}.spm.stats.con.consess{6}.tcon.name = contrast_name{6};
    matlabbatch{2}.spm.stats.con.consess{6}.tcon.weights = contrast{6};
    matlabbatch{2}.spm.stats.con.consess{6}.tcon.sessrep = 'none';
    matlabbatch{2}.spm.stats.con.consess{7}.tcon.name = contrast_name{7};
    matlabbatch{2}.spm.stats.con.consess{7}.tcon.weights = contrast{7};
    matlabbatch{2}.spm.stats.con.consess{7}.tcon.sessrep = 'none';
    matlabbatch{2}.spm.stats.con.consess{8}.tcon.name = contrast_name{8};
    matlabbatch{2}.spm.stats.con.consess{8}.tcon.weights = contrast{8};
    matlabbatch{2}.spm.stats.con.consess{8}.tcon.sessrep = 'none';
    matlabbatch{2}.spm.stats.con.consess{9}.tcon.name = contrast_name{9};
    matlabbatch{2}.spm.stats.con.consess{9}.tcon.weights = contrast{9};
    matlabbatch{2}.spm.stats.con.consess{9}.tcon.sessrep = 'none';
    matlabbatch{2}.spm.stats.con.consess{10}.tcon.name = contrast_name{10};
    matlabbatch{2}.spm.stats.con.consess{10}.tcon.weights = contrast{10};
    matlabbatch{2}.spm.stats.con.consess{10}.tcon.sessrep = 'none';
    matlabbatch{2}.spm.stats.con.delete = 0;

    %%result check
    matlabbatch{3}.spm.stats.results.spmmat(1) = cfg_dep('Contrast Manager: SPM.mat File', substruct('.','val', '{}',{2}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
    matlabbatch{3}.spm.stats.results.conspec(1).titlestr = '';
    matlabbatch{3}.spm.stats.results.conspec(1).contrasts = 1;
    matlabbatch{3}.spm.stats.results.conspec(1).threshdesc = 'none';
    matlabbatch{3}.spm.stats.results.conspec(1).thresh = 0.001;
    matlabbatch{3}.spm.stats.results.conspec(1).extent = 0;
    matlabbatch{3}.spm.stats.results.conspec(1).conjunction = 1;
    matlabbatch{3}.spm.stats.results.conspec(1).mask.none = 1;
    
    matlabbatch{3}.spm.stats.results.conspec(2).titlestr = '';
    matlabbatch{3}.spm.stats.results.conspec(2).contrasts = 2;
    matlabbatch{3}.spm.stats.results.conspec(2).threshdesc = 'none';
    matlabbatch{3}.spm.stats.results.conspec(2).thresh = 0.001;
    matlabbatch{3}.spm.stats.results.conspec(2).extent = 0;
    matlabbatch{3}.spm.stats.results.conspec(2).conjunction = 1;
    matlabbatch{3}.spm.stats.results.conspec(2).mask.none = 1;
    
    matlabbatch{3}.spm.stats.results.conspec(3).titlestr = '';
    matlabbatch{3}.spm.stats.results.conspec(3).contrasts = 3;
    matlabbatch{3}.spm.stats.results.conspec(3).threshdesc = 'none';
    matlabbatch{3}.spm.stats.results.conspec(3).thresh = 0.001;
    matlabbatch{3}.spm.stats.results.conspec(3).extent = 0;
    matlabbatch{3}.spm.stats.results.conspec(3).conjunction = 1;
    matlabbatch{3}.spm.stats.results.conspec(3).mask.none = 1;
    
    matlabbatch{3}.spm.stats.results.conspec(4).titlestr = '';
    matlabbatch{3}.spm.stats.results.conspec(4).contrasts = 4;
    matlabbatch{3}.spm.stats.results.conspec(4).threshdesc = 'none';
    matlabbatch{3}.spm.stats.results.conspec(4).thresh = 0.001;
    matlabbatch{3}.spm.stats.results.conspec(4).extent = 0;
    matlabbatch{3}.spm.stats.results.conspec(4).conjunction = 1;
    matlabbatch{3}.spm.stats.results.conspec(4).mask.none = 1;
        
    matlabbatch{3}.spm.stats.results.conspec(5).titlestr = '';
    matlabbatch{3}.spm.stats.results.conspec(5).contrasts = 5;
    matlabbatch{3}.spm.stats.results.conspec(5).threshdesc = 'none';
    matlabbatch{3}.spm.stats.results.conspec(5).thresh = 0.001;
    matlabbatch{3}.spm.stats.results.conspec(5).extent = 0;
    matlabbatch{3}.spm.stats.results.conspec(5).conjunction = 1;
    matlabbatch{3}.spm.stats.results.conspec(5).mask.none = 1;
    
    matlabbatch{3}.spm.stats.results.conspec(6).titlestr = '';
    matlabbatch{3}.spm.stats.results.conspec(6).contrasts = 6;
    matlabbatch{3}.spm.stats.results.conspec(6).threshdesc = 'none';
    matlabbatch{3}.spm.stats.results.conspec(6).thresh = 0.001;
    matlabbatch{3}.spm.stats.results.conspec(6).extent = 0;
    matlabbatch{3}.spm.stats.results.conspec(6).conjunction = 1;
    matlabbatch{3}.spm.stats.results.conspec(6).mask.none = 1;
    
    matlabbatch{3}.spm.stats.results.conspec(7).titlestr = '';
    matlabbatch{3}.spm.stats.results.conspec(7).contrasts = 7;
    matlabbatch{3}.spm.stats.results.conspec(7).threshdesc = 'none';
    matlabbatch{3}.spm.stats.results.conspec(7).thresh = 0.001;
    matlabbatch{3}.spm.stats.results.conspec(7).extent = 0;
    matlabbatch{3}.spm.stats.results.conspec(7).conjunction = 1;
    matlabbatch{3}.spm.stats.results.conspec(7).mask.none = 1;
    
    matlabbatch{3}.spm.stats.results.conspec(8).titlestr = '';
    matlabbatch{3}.spm.stats.results.conspec(8).contrasts = 8;
    matlabbatch{3}.spm.stats.results.conspec(8).threshdesc = 'none';
    matlabbatch{3}.spm.stats.results.conspec(8).thresh = 0.001;
    matlabbatch{3}.spm.stats.results.conspec(8).extent = 0;
    matlabbatch{3}.spm.stats.results.conspec(8).conjunction = 1;
    matlabbatch{3}.spm.stats.results.conspec(8).mask.none = 1;
    
    matlabbatch{3}.spm.stats.results.conspec(9).titlestr = '';
    matlabbatch{3}.spm.stats.results.conspec(9).contrasts = 9;
    matlabbatch{3}.spm.stats.results.conspec(9).threshdesc = 'none';
    matlabbatch{3}.spm.stats.results.conspec(9).thresh = 0.001;
    matlabbatch{3}.spm.stats.results.conspec(9).extent = 0;
    matlabbatch{3}.spm.stats.results.conspec(9).conjunction = 1;
    matlabbatch{3}.spm.stats.results.conspec(9).mask.none = 1;
    
    matlabbatch{3}.spm.stats.results.conspec(10).titlestr = '';
    matlabbatch{3}.spm.stats.results.conspec(10).contrasts = 10;
    matlabbatch{3}.spm.stats.results.conspec(10).threshdesc = 'none';
    matlabbatch{3}.spm.stats.results.conspec(10).thresh = 0.001;
    matlabbatch{3}.spm.stats.results.conspec(10).extent = 0;
    matlabbatch{3}.spm.stats.results.conspec(10).conjunction = 1;
    matlabbatch{3}.spm.stats.results.conspec(10).mask.none = 1;
    
    matlabbatch{3}.spm.stats.results.units = 1;
    matlabbatch{3}.spm.stats.results.export{1}.ps = true;
    
    
   spm_jobman('run',matlabbatch);
    
    
end

