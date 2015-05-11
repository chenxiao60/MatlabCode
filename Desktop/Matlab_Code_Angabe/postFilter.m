function Wmwf = postFilter(W,Gamma,d0,Thi_Y)
cfg.nmic=5;
V = 1/(cfg.nmic-1) * trace((eye(cfg.nmic,cfg.nmic)-d0*W')*Thi_Y*inv(Gamma));
S = W'*(Thi_Y-V*Gamma)*W;
Wmwf = (S/(S+(V*inv(d0'*inv(Gamma)*d0))))*...
W;
end