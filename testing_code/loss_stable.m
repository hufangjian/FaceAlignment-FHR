function ERRs = loss_stable(pt,mod)
w = Width(pt);
id = (w > .01);
pt1 = pt./(w*ones(1,size(pt,2)));
mod1 = mod./(w*ones(1,size(pt,2)));
e = sqrt(sum((pt1-mod1).^2,2)/size(pt1,2)*2);
e2 = sum(e(id));
N2 = sum(id);
dmod = mod(2:end,:)-pt(2:end,:);
dpt = pt(1:end-1,:)-pt(2:end,:);
q = sum(dmod.*dpt,2)./sum(dpt.^2,2);
id1 = (id(2:end) & id(1:end-1));
e1 = sum(q(id1));
N1 = sum(id1);
dmod = (mod(2:end-1,:)-(mod(1:end-2,:)+mod(3:end,:))/2)./(w(2:end-1)*ones(1,size(pt,2)));
e = sqrt(sum(dmod.^2,2)/size(pt,2)*2);
id2 = id(1:end-2) & id(2:end-1) & id(3:end);
e3 = sum(e(id2));
N3 = sum(id2);
dmod1 = mod(2:end-1,:)-mod(1:end-2,:);
dmod2 = mod(3:end,:)-mod(1:end-2,:);
q = sum(dmod1.*dmod2,2)./sum(dmod2.^2,2);
q = min(max(q,0),1);
q = q*ones(1,size(pt,2));
dmod = (mod(2:end-1,:)-(1-q).*mod(1:end-2,:)-q.*mod(3:end,:))./(w(2:end-1)*ones(1,size(pt,2)));
e = sqrt(sum(dmod.^2,2)/size(pt,2)*2);
e4 = sum(e(id2));
ERRs = [e1/N1,e2/N2,e3/N3,e4/N3];