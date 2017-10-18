find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    echo "($branch) "
  else
    echo ""
  fi
}

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
unescaped_clrorange=$(tput setaf 202)
unescaped_clrpurple=$(tput setaf 5)
unescaped_clrred=$(tput setaf 1)
unescaped_clrwhite=$(tput setaf 7)
unescaped_clryellow=$(tput setaf 3)
unescaped_clrbrightyellow=$(tput setaf 226)

show_clean_repo_prompt()
{
  if [[ "$(find_git_branch)" ]] && [[ -z "$(find_git_dirty)" ]]; then
    echo "${unescaped_fmtdim}${unescaped_clrwhite}"    
  fi
}
show_changed_repo_prompt()
{
  if [[ "$(find_git_branch)" ]] && [[ "$(find_git_dirty)" ]]; then
    echo "${unescaped_clrorange}"    
  fi
}

promptshorten()
{
  export PS1="${fmtreset}${fmtbold}${clryellow}ॐ  ${clrblue}${fmtbold}\W\[\$(show_clean_repo_prompt)\]\[\$(show_changed_repo_prompt)\] \$(find_git_branch)${clrblue}\$ ${fmtreset}"
}
promptrestore()
{
  export PS1="${fmtreset}${fmtbold}${clryellow}ॐ  ${clrblue}${fmtbold}\w\[\$(show_clean_repo_prompt)\]\[\$(show_changed_repo_prompt)\] \$(find_git_branch)${clrblue}\$ ${fmtreset}"
}
promptremove()
{
  export PS1="${fmtreset}${fmtbold}${clryellow}ॐ \[\$(show_clean_repo_prompt)\]\[\$(show_changed_repo_prompt)\] \$(find_git_branch)${clrblue}\$ ${fmtreset}"
}
promptrestore
