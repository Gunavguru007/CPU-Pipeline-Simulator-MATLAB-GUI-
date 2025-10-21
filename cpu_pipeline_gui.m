function cpu_pipeline_gui()
    % Initialize figure
    f = figure('Name','CPU Pipeline Simulator','Position',[100 100 1200 700], ...
               'Color',[0.1 0.1 0.1]);

    % Pipeline stage positions
    stageNames = {'IF','ID','EX','MEM','WB'};
    stageX = linspace(150,1000,5);
    stageY = 500;
    
    % Draw pipeline stages
    for i = 1:5
        rectangle('Position',[stageX(i)-40 stageY-40 80 80],'Curvature',0.2, ...
                  'FaceColor',[0.2 0.2 0.5],'EdgeColor','w','LineWidth',2);
        text(stageX(i),stageY+60,stageNames{i},'Color','w','FontSize',14, ...
             'FontWeight','bold','HorizontalAlignment','center');
    end
    
    % Instruction boxes (max 6 active)
    instrBoxes = gobjects(6,1);
    for i=1:6
        instrBoxes(i) = rectangle('Position',[stageX(1)-40 stageY-40 80 40], ...
                                  'Curvature',0.2,'FaceColor',[0 0.7 0.3], ...
                                  'EdgeColor','w','Visible','off');
        text(stageX(1),stageY,'INST','Color','w','FontSize',10, ...
             'HorizontalAlignment','center','Tag',['instrText' num2str(i)], ...
             'Visible','off');
    end
    
    % Cache Hit/Miss LEDs
    hitLED = rectangle('Position',[100 200 30 30],'Curvature',[1 1], ...
                       'FaceColor','g','EdgeColor','w');
    missLED = rectangle('Position',[150 200 30 30],'Curvature',[1 1], ...
                        'FaceColor','r','EdgeColor','w');
    text(115,170,'Hit','Color','w');
    text(165,170,'Miss','Color','w');
    
    % Branch Predictor arrow
    arrow = annotation('arrow',[0.4 0.4],[0.3 0.4],'Color','y','LineWidth',3);
    bpText = text(420,150,'Branch Predictor: ?','Color','w','FontSize',12);
    
    % IPC Dial Gauge (using MATLAB gauge if available, else custom needle)
    ax = axes('Position',[0.7 0.1 0.2 0.2]);
    hold(ax,'on'); axis(ax,'equal','off');
    viscircles([0 0],1,'Color','w');
    needle = plot(ax,[0 0],[0 0.8],'LineWidth',3,'Color','g');
    ipcText = text(ax,0,-1.3,'IPC: 0.0','Color','w','FontSize',12, ...
                   'HorizontalAlignment','center');
    
    % === Simulation Parameters ===
    nCycles = 20;
    ipcValues = rand(1,nCycles)*2; % random IPC values for demo
    
    % === Run Simulation ===
    for cycle = 1:nCycles
        % Show instructions moving
        activeInstr = mod(cycle,6)+1;
        set(instrBoxes(activeInstr),'Visible','on','Position', ...
            [stageX(1)-40 stageY-40 80 40],'FaceColor',[rand rand rand]);
        set(findobj('Tag',['instrText' num2str(activeInstr)]),'Visible','on', ...
            'String',['I' num2str(cycle)]);
        
        % Move existing instructions
        for j=1:6
            if strcmp(get(instrBoxes(j),'Visible'),'on')
                pos = get(instrBoxes(j),'Position');
                pos(1) = pos(1) + 200; % move right
                set(instrBoxes(j),'Position',pos);
            end
        end
        
        % Random cache hit/miss
        if rand>0.7
            set(hitLED,'FaceColor','k'); set(missLED,'FaceColor','r');
        else
            set(hitLED,'FaceColor','g'); set(missLED,'FaceColor','k');
        end
        
        % Branch predictor update
        if rand>0.5
            set(arrow,'X',[0.4 0.5],'Y',[0.3 0.6],'Color','g');
            set(bpText,'String','Branch Predictor: Taken');
        else
            set(arrow,'X',[0.4 0.3],'Y',[0.3 0.6],'Color','r');
            set(bpText,'String','Branch Predictor: Not Taken');
        end
        
        % IPC gauge needle update
        angle = -90 + ipcValues(cycle)/2*180; % map IPC 0-2 to -90 to 90 deg
        set(needle,'XData',[0 cosd(angle)],'YData',[0 sind(angle)]);
        set(ipcText,'String',sprintf('IPC: %.2f',ipcValues(cycle)));
        
        pause(0.5); % delay for animation
    end
end
