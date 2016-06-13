trax=zeros(400);
tray=zeros(400);
traz=zeros(400);

counter=1;

%search the key point
for Per=2:399
    if (L2OUT(Per)>L2OUT(Per-1) && L2OUT(Per)>L2OUT(Per+1)) ||(L2OUT(Per)<L2OUT(Per-1) && L2OUT(Per)<L2OUT(Per+1))
        trax(counter)=L2OUT(Per);
        tray(counter)=BASINOUT(Per);
        traz(counter)=(TotalWater-0.3*trax(counter)-0.3*tray(counter))/0.06;
        counter=counter+1;
    end
end

counter


