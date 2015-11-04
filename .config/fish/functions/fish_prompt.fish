# fish git prompt
set __fish_git_prompt_showdirtystate 'yes'
set __fish_git_prompt_showstashstate 'yes'
set __fish_git_prompt_showupstream 'yes'
set __fish_git_prompt_color_branch yellow

# Status Chars
set __fish_git_prompt_char_dirtystate '⚡'
set __fish_git_prompt_char_stagedstate '→'
set __fish_git_prompt_char_stashstate '↩'
set __fish_git_prompt_char_upstream_ahead '↑'
set __fish_git_prompt_char_upstream_behind '↓'

function fish_prompt
        set -l white (set_color -o white)
        set -l cyan (set_color -o cyan)
        set -l yellow (set_color -o yellow)
        set -l green (set_color -o green)
        set -l red (set_color -o red)
        set -l blue (set_color -o blue)
        set -l normal (set_color -o normal)
        
        set -l atsign '@'
        set -l prompt ' % '                                                                    

        set -l last_status $status

        set -l statuscolor $cyan
        if test $last_status -ne 0
                set statuscolor $red
        end

        printf '%s%s%s:%s%s%s' $cyan(whoami) $white$atsign $blue(hostname) $green(prompt_pwd) $normal(__fish_git_prompt) $statuscolor$prompt
end
