#!/usr/bin/fish

function rmake
    set -l base
    if string match -q -- "base=*" $argv[-1]
        set base $(echo $argv[-1] | sed -nE 's/base=//p')
    else
        set base $(pwd)
    end

    if ls | grep "Makefile" 2>&1 1>/dev/null
        command make $argv[1..-2]
        set -l ret $status
        cd $base
        return $ret
    end

    if [ "$(pwd)" = "$HOME" ]
        cd $base
        return 1
    end

    cd ../
    rmake $argv[1..-1] base=$base
end

