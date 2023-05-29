% Trajectory correction
if raceline(1,j) == 1 | raceline(1,j) == -1;
    if raceline(1,j-1) == -1 | raceline(1,j-1) == 1; % Enlazada RL o Curva R radio variable (o inversa)
        nplim2 = raceline(2,j);
        Tlim2 = [T(1,nplim2) T(2,nplim2)];
        Tlim1 = [T(1,nplim2-1) T(2,nplim2-1)];
        vlim = Tlim2-Tlim1;
        n = nn(j+1)-nn(j);
        i = 0;
        while i <= n;
            T(1,nplim2+i) = T(1,nplim2+i)-vlim(1);
            T(2,nplim2+i) = T(2,nplim2+i)-vlim(2);
            i = i+1;
        end
    end 
end
