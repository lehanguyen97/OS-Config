if test -x /usr/bin/dircolors
    if test -r ~/.dircolors 
        eval (dircolors -c ~/.dircolors)
    else
        eval (dircolors -c)
    end
end
