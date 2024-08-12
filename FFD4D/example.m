aviobj = avifile('M:\My Documents\moviename.avi','compression','Cinepak'); %open new movie file
f = getframe(gcf); %capture frame from current figure
    aviobj = addframe(aviobj,f); %add frame to the existing movie file
    aviobj = close(aviobj); %save/close the movie