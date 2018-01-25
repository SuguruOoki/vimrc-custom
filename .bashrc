function mkcd() {
    mkdir $1;
    cd $1;
}

function vup() {
    cd ~/workspace/dev-environment/core;
    atom ./;
    vagrant up;
}

function vst() {
    cd ~/workspace/dev-environment/core;
    vagrant status;
}

function vss() {
    cd ~/workspace/dev-environment/core;
    vagrant ssh;
}

function vh() {
    cd ~/workspace/dev-environment/core;
    vagrant halt;
}

function ssh-nedbpass() {
    ssh nesp03;
}

function peco-sshconfig-ssh() {
    local host=$(grep 'Host ' ~/.ssh/config | awk '{print $2}' | peco)
    if [ -n "$host" ]; then
        echo "ssh -F ~/.ssh/config $host"
        ssh -F ~/.ssh/config $host
    fi
}

function peco-find-cd() {
  local FILENAME="$1"
  local MAXDEPTH="${2:-3}"
  local BASE_DIR="${3:-`pwd`}"

  if [ -z "$FILENAME" ] ; then
    echo "Usage: peco-find-cd <FILENAME> [<MAXDEPTH> [<BASE_DIR>]]" >&2
    return 1
  fi

  local DIR=$(find ${BASE_DIR} -maxdepth ${MAXDEPTH} -name ${FILENAME} | peco | head -n 1)

  if [ -n "$DIR" ] ; then
    DIR=${DIR%/*}
    echo "pushd \"$DIR\""
    pushd "$DIR"
  fi
}

function peco-docker-cd() {
  peco-mdfind-cd "Dockerfile"
}

function peco-vagrant-cd() {
  peco-mdfind-cd "Vagrantfile"
}

function peco-git-cd() {
  peco-find-cd '.git'
}

function alias-change() {
  vim ~/.bashrc;
  source ~/.bashrc;
}

function peco-select-history() {
    BUFFER=$(\history 50 | \
                    sort -r -k 2 |\
                    uniq -1 | \
                    sort -r | \
                    awk '$1=$1' | \
                    cut -d" " -f 2- | \
                    peco --query "$LBUFFER")
    CURSOR=$BUFFER
}
bind -x '"\C-h": peco-select-history'

#agで検索した結果から選択し、ファイルを開く
function grep-vim(){
  path=$(grep $* | peco | awk -F: '{printf  $1 " +" $2}'| sed -e 's/\+$//')
  if [ -n "$path" ]; then
    echo "vim $path"
    vim $path
  fi
}


_peco_mdfind() {
  vim "$(mdfind -onlyin . -name $@ | peco)"
}
bind -x '"\C-s": _peco_mdfind'

function nedbpass() {
    ssh oki.suguru@nesp03 "nedbpass ne$1db;echo 'Ozaki04090527@';"
}

function change_to_all_machine_sql() {
    cd ~/workspace/tools/;
    php ~/workspace/tools/allsql.php $1;
}

# コマンド系
alias sshh='peco-sshconfig-ssh'
alias ss='ssh-nedbpass'
alias dockercd="peco-docker-cd"
alias sshh='peco-sshconfig-ssh'
alias vcd="peco-vagrant-cd"
alias findcd="peco-find-cd"
alias gd="peco-git-cd"
alias ph="peco-select-history"
alias nkfg="nkf --guess"
alias ali='alias-change'
alias ll="ls -l"
alias la="ls -a"
alias cdc="cd ~/workspace/dev-environment/core"
alias cdn="cd ~/workspace/dev-environment/nedevtools"
alias ad='cd $HOME/"$(cat ~/actives.txt | peco)"'
alias sou="source"
alias mvim="_peco_mdfind"
alias ctags="`brew --prefix`/bin/ctags"
alias ch="change_to_all_machine_sql"

function aga () {
  atom $(ag $@ --ignore-dir caches_ux | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

function agvim () {
  vim $(ag $@ --ignore-dir caches_ux --ignore tags | peco --query "$LBUFFER" | awk -F : '{print "-c " $2 " " $1}')
}

function apvim () {
  vim $(ag -g $@ --ignore-dir caches_ux --ignore tags | peco --query "$LBUFFER")
}

# アプリオープン系
alias base='open -n -a "Google Chrome.app" --args --app="https://base.next-engine.org/users/"'
alias drive='open -n -a "Google Chrome.app" --args --app="https://drive.google.com/drive/my-drive"'
alias ao="atom ./"
alias chat='open -n -a "Google Chrome.app" --args --app="https://kcw.kddi.ne.jp/#!rid84115420" --start-fullscreen'
alias base='open -n -a "Google Chrome.app" --args --app="https://base.next-engine.org/users/"'
alias red='open -n -a "Google Chrome.app" --args --app="https://neprj.next-engine.com:10080/ld3sl/projects/ne/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=%3D&v%5Bstatus_id%5D%5B%5D=7&v%5Bstatus_id%5D%5B%5D=26&v%5Bstatus_id%5D%5B%5D=17&v%5Bstatus_id%5D%5B%5D=35&v%5Bstatus_id%5D%5B%5D=1&v%5Bstatus_id%5D%5B%5D=2&v%5Bstatus_id%5D%5B%5D=15&v%5Bstatus_id%5D%5B%5D=9&v%5Bstatus_id%5D%5B%5D=16&v%5Bstatus_id%5D%5B%5D=12&f%5B%5D=assigned_to_id&op%5Bassigned_to_id%5D=%3D&v%5Bassigned_to_id%5D%5B%5D=me&f%5B%5D=&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=fixed_version&c%5B%5D=due_date&c%5B%5D=cf_3&c%5B%5D=cf_4&group_by="'
alias red2='open -n -a "Google Chrome.app" --args --app="https://neprj.next-engine.com:10080/ld3sl/projects/ne/issues?utf8=%E2%9C%93&set_filter=1&f%5B%5D=status_id&op%5Bstatus_id%5D=%3D&v%5Bstatus_id%5D%5B%5D=7&v%5Bstatus_id%5D%5B%5D=26&v%5Bstatus_id%5D%5B%5D=17&v%5Bstatus_id%5D%5B%5D=35&v%5Bstatus_id%5D%5B%5D=1&v%5Bstatus_id%5D%5B%5D=2&v%5Bstatus_id%5D%5B%5D=15&v%5Bstatus_id%5D%5B%5D=9&v%5Bstatus_id%5D%5B%5D=16&v%5Bstatus_id%5D%5B%5D=12&f%5B%5D=tracker_id&op%5Btracker_id%5D=%3D&v%5Btracker_id%5D%5B%5D=33&f%5B%5D=&c%5B%5D=tracker&c%5B%5D=status&c%5B%5D=priority&c%5B%5D=subject&c%5B%5D=assigned_to&c%5B%5D=updated_on&c%5B%5D=fixed_version&c%5B%5D=due_date&c%5B%5D=cf_3&c%5B%5D=cf_4&group_by="'
alias trello='open -n -a "Google Chrome.app" --args --app="https://trello.com/b/1MkWgCTk/%E3%82%BF%E3%82%B9%E3%82%AF%E7%AE%A1%E7%90%86"'
alias enote='open -n -a "Google Chrome.app" --args --app="https://www.evernote.com/Home.action?message=forgotPasswordAction.sent&login=true#n=900d5ae2-93c9-491c-8575-eaa08db14039&s=s626&ses=4&sh=2&sds=5&"'
alias base='open -n -a "Google Chrome.app" --args --app="https://base.next-engine.org/users/"'
alias kibana='open -n -a "Google Chrome.app" --args --app="https://mnt.next-engine.com:8443/#/dashboard/NE-Slow-Query?_a=(filters:!((meta:(apply:!t,disabled:!f,index:'mysqlslowquery-*',key:fingerprint,negate:!t,value:commit),query:(match:(fingerprint:(query:commit,type:phrase))))),panels:!((col:1,columns:!(hostname,sql,rows_examined,query_time),id:Latest-Slow-Query,row:8,size_x:12,size_y:8,sort:!('@timestamp',desc),type:search),(col:1,id:Total-Query-Time-Top-10,row:4,size_x:4,size_y:4,type:visualization),(col:5,id:Total-Query-Count-Top-10,row:4,size_x:4,size_y:4,type:visualization),(col:1,id:Slow-Query-Trend,row:1,size_x:12,size_y:3,type:visualization),(col:9,id:Total-Rows_Examined-Time-Top-10,row:4,size_x:4,size_y:4,type:visualization)),query:(query_string:(analyze_wildcard:!t,query:'*')),title:'NE%20Slow%20Query')&_g=(filters:!(),refreshInterval:(display:'5%20minutes',pause:!f,section:2,value:300000),time:(from:now-24h,mode:quick,to:now))"'
alias gmail='open -n -a "Google Chrome.app" --args --app="https://mail.google.com/mail/u/0/#inbox?compose=160e487fbb52a493%2C160e48864cf86c7f"'
alias nw='open -n -a "Google Chrome.app" --args --app="https://neprj.next-engine.com:10080/ld3sl/issues/20252"'


# git系
alias nes="ssh nesp03"
alias gcb='git checkout -b'
alias gf='git fetch --all'
alias gc='git checkout $(git branch | peco)'
alias gme='git commit --amend --no-edit'
alias gul='git pull origin master'
alias gsh='git push origin'
alias gst='git status'
alias gadd='git add .'
alias gf="git fetch --all"
alias glp='git log -p'
alias gp='~/git-padd.sh'

# vim系
alias gvim='grep-vim'
alias cvim='vim ~/.vimrc'
alias sp='open -a "Sequel Pro.app"'
alias mt="tail -f ~/workspace/dev-environment/core/application/log/sys/ne_sys_$(date '+%Y%m%d').log"
