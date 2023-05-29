function [] = simu_animation(P,sim,settime)

if sim == 1;
    Px = P(1,:);
    Py = P(2,:);
    trayectory = animatedline('LineWidth',3,'Color','g');
    set(gca,'XLim',[min(Px)-100,max(Px)+100],'YLim',[min(Py)-100,max(Py)+100]);
    title('Running...','color','r')
    view(0,90);
    hold on
    for i=1:length(Px)
        addpoints(trayectory,Px(i),Py(i));
        head = scatter3(Px(i),Py(i),0,'filled',...
            'MarkerFaceColor','g',...
            'MarkerEdgeColor','k');
        drawnow;
        pause(settime);
        delete(head);
    end
    title('Simulation Complete!','color','b')
end



end

