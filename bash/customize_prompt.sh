find_git_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty='*'
  else
    git_dirty=''
  fi

  echo $git_dirty
}

fmtbold="\[$(tput bold)\]"
fmtreset="\[$(tput sgr0)\]"
fmtitalic="\[$(tput sitm) \]"
fmtunderline="\[$(tput smul) \]"
fmtdim="\[$(tput dim)\]"
clrblack="\[$(tput setaf 0)\]"
clrblue="\[$(tput setaf 4)\]"
clrbrightblue="\[$(tput setaf 75)\]"
clrcyan="\[$(tput setaf 6)\]"
clrgreen="\[$(tput setaf 2)\]"
clrlightgreen="\[$(tput setaf 154)\]"
clrorange="\[$(tput setaf 202)\]"
clrpurple="\[$(tput setaf 5)\]"
clrred="\[$(tput setaf 1)\]"
clrwhite="\[$(tput setaf 7)\]"
clryellow="\[$(tput setaf 3)\]"
clrbrightyellow="\[$(tput setaf 226)\]"

unescaped_fmtbold=$(tput bold)
unescaped_fmtreset=$(tput sgr0)
unescaped_fmtitalic=$(tput sitm) 
unescaped_fmtunderline=$(tput smul) 
unescaped_fmtdim=$(tput dim)
unescaped_clrblack=$(tput setaf 0)
unescaped_clrblue=$(tput setaf 4)
unescaped_clrcyan=$(tput setaf 6)
unescaped_clrgreen=$(tput setaf 2)
unescaped_clrlightgreen=$(tput setaf 154)
unescaped_clrorange=$(tput setaf 208)
unescaped_clrpurple=$(tput setaf 5)
unescaped_clrred=$(tput setaf 1)
unescaped_clrwhite=$(tput setaf 7)
unescaped_clryellow=$(tput setaf 3)
unescaped_clrbrightyellow=$(tput setaf 226)

show_clean_repo_prompt()
{
  if [[ "$(__git_ps1)" ]] && [[ -z "$(find_git_dirty)" ]]; then
    echo ""    
  fi
}
show_changed_repo_prompt()
{
  if [[ "$(__git_ps1)" ]] && [[ "$(find_git_dirty)" ]]; then
    echo "${unescaped_clrorange}"    
  fi
}

# ${fmtreset}${fmtbold}${clryellow}ॐ  

promptshorten()
{
  export PS1="\[\$(show_clean_repo_prompt)\]\[\$(show_changed_repo_prompt)\]\$(__git_ps1) ${clrbrightblue}\W ≻ ${fmtreset}"
}
promptrestore()
{
  export PS1="\[\$(show_clean_repo_prompt)\]\[\$(show_changed_repo_prompt)\]\$(__git_ps1) ${clrbrightblue}\w ≻ ${fmtreset}"
}
promptremove()
{
  export PS1="\[\$(show_clean_repo_prompt)\]\[\$(show_changed_repo_prompt)\]\$(__git_ps1)${clrbrightblue} ≻ ${fmtreset}"
}
promptdemo()
{
  export PS1="\[\$(show_clean_repo_prompt)\]\[\$(show_changed_repo_prompt)\]\$(__git_ps1)${clrbrightblue}≻ ${fmtreset}"
}
promptrestore
