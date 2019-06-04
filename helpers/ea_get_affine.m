function affine = ea_get_affine(nii, type)
% Get the affine matrix of the NIfTI file
%
% Default type is 'SPM', the affine matrix is for one-based voxel to world
% space transformation. Otherwise, the affine matrix is used for zero-based
% calculation.

if nargin < 2
    type = 'SPM';
end

hdr = ea_fslhd(nii, 'x');

switch type
    case {'spm', 'SPM', 1, '1'}  % SPM type, one-based
        affine = hdr.sto_xyz_matrix;
        affine(:,4) = affine(:,4) - sum(affine(:,1:3),2);
    case {0, '0'}  % other types, zero-based
        affine = hdr.sto_xyz_matrix;
end