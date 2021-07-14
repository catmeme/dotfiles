# Aliases
##################################################################

alias tmux='tmux -2'
alias apts='apt-cache search'
alias aptu='apt-get update'
# always going to sudo these
alias aptup='sudo apt-get upgrade'
alias aptud='sudo apt-get dist-upgrade'
alias apti='sudo apt-get install'
alias aptr='sudo apt-get remove'
alias aptp='sudo apt-get purge'
# ez
alias cat='bat'
alias dco='docker-compose'
alias dcd='docker-compose down --remove-orphans'
alias gds='git diff --staged'
alias lssh="grep 'Host ' ~/.ssh/config |cut -f2 -d ' ' && find ~/.ssh/conf.d -exec grep 'Host ' {} \; | cut -f2 -d ' '"
alias pd='pulumi destroy'
alias pp='pulumi'
alias pup='pulumi up'
alias scut='tr -s " " | cut -d " "'



# General
##################################################################

# execute a command across a collection of directories
function collect () {
    local COLLECT_INPUT
    local COLLECT_INCLUDE=""
    local COLLECT_EXCLUDE="AReallyLongAndUniqueMagicStringThatShouldNotBeUsed1234567890qwertyuiopasdfghjklzxcvbnm"
    local COLLECT_QUIET="0"

    while [[ $# -gt 0 ]]; do
        case $1 in
            # options and flags
            "--exclude")                                COLLECT_EXCLUDE="$2";     shift; shift;;  # past argument+value
            "--include")                                COLLECT_INCLUDE="$2";     shift; shift;;
            "--quiet")                                  COLLECT_QUIET="1";        shift;;
            # unknown, save in an array for later
            *)                                          COLLECT_INPUT+=("$1");    shift;;
        esac
    done
    local COLLECT_DIRS=$(find . -not -path '*/\.*' -type d -maxdepth 1 -mindepth 1 -exec basename {} \; | grep -E "${COLLECT_INCLUDE}" | grep -Ev "${COLLECT_EXCLUDE}" | sort)
    if [[ ${COLLECT_QUIET} == "0" ]]; then echo ${COLLECT_DIRS} | parallel "pushd {} && echo '$(tput bold){}$(tput sgr0)' && ${COLLECT_INPUT}"; fi
    if [[ ${COLLECT_QUIET} == "1" ]]; then echo ${COLLECT_DIRS} | parallel "pushd {} && ${COLLECT_INPUT}"; fi
}

function k8s_token () {
    kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')
}

function rule () {
    _hr=$(printf "%*s" $(tput cols)) && echo ${_hr// /${1--}}
}

function ssh_copy_id() {
    local ssh_connection=${1}
    local ssh_key=${2:-~/.ssh/id_rsa.pub}
    if [[ "${ssh_connection}" == "" ]]; then echo "ssh connection string required"; exit 1; fi
    cat ${ssh_key} | ssh ${ssh_connection} "mkdir -p ~/.ssh && chmod 700 ~/.ssh && cat >> ~/.ssh/authorized_keys"
}

function zshp_up () {
    for d in $(find ${HOME}/.oh-my-zsh/custom/plugins/ -maxdepth 1 -type d); do cd $d; git pull; cd -; done
}


# AWS
##################################################################

# Support MFA (for any application that doesn't support role_arn with MFA
function aws_mfa () {
    local AWS_PROFILE=$1
    local ROLE_ARN=$(aws configure get profile.${AWS_PROFILE}.role_arn)

    if [[ -n ${ROLE_ARN} ]]; then
        echo "Using AWS Profile: ${AWS_PROFILE}"
        local AWS_ROLE_USER_ID=$(aws --profile ${AWS_PROFILE} sts get-caller-identity |jq -r '.UserId')
        if [[ -z ${AWS_ROLE_USER_ID} ]]; then return; fi

        local AWS_CREDENTIALS=$(grep -hs ${AWS_ROLE_USER_ID} ~/.aws/cli/cache/*.json)

        export AWS_ACCESS_KEY_ID=$(echo ${AWS_CREDENTIALS} | jq -r '.Credentials.AccessKeyId')
        export AWS_SECRET_ACCESS_KEY=$(echo ${AWS_CREDENTIALS} | jq -r '.Credentials.SecretAccessKey')
        export AWS_SESSION_TOKEN=$(echo ${AWS_CREDENTIALS} | jq -r '.Credentials.SessionToken')
    else
        echo "Profile not found"
    fi
}

# Support MFA (full support, unlike the incomplete Cyberduck feature)
function cyberduck_aws_mfa () {
    local CYBERDUCK_AWS_PROFILE=$1
    local ROLE_ARN=$(aws configure get profile.${CYBERDUCK_AWS_PROFILE}.role_arn)

    if [[ -n ${ROLE_ARN} ]]; then
        echo "Using AWS Profile: ${CYBERDUCK_AWS_PROFILE}"
        local AWS_ROLE_USER_ID=$(aws --profile ${CYBERDUCK_AWS_PROFILE} sts get-caller-identity |jq -r '.UserId')
        if [[ -z ${AWS_ROLE_USER_ID} ]]; then return; fi

        local AWS_CREDENTIALS=$(grep -hs ${AWS_ROLE_USER_ID} ~/.aws/cli/cache/*.json)

        local AWS_ACCESS_KEY_ID=$(echo ${AWS_CREDENTIALS} | jq -r '.Credentials.AccessKeyId')
        local AWS_SECRET_ACCESS_KEY=$(echo ${AWS_CREDENTIALS} | jq -r '.Credentials.SecretAccessKey')
        local AWS_SESSION_TOKEN=$(echo ${AWS_CREDENTIALS} | jq -r '.Credentials.SessionToken')

        aws configure set profile.${CYBERDUCK_AWS_PROFILE}-temp.aws_access_key_id ${AWS_ACCESS_KEY_ID}
        aws configure set profile.${CYBERDUCK_AWS_PROFILE}-temp.aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}
        aws configure set profile.${CYBERDUCK_AWS_PROFILE}-temp.aws_session_token ${AWS_SESSION_TOKEN}
    else
        echo "Profile not found"
    fi
}

# Support MFA
function pulumi () {
    local PULUMI_COMMANDS_AWS_REQUIRED=(destroy import logs preview refresh up update watch)
    local AWS_REQUIRED=$([[ " ${PULUMI_COMMANDS_AWS_REQUIRED[@]} " =~ " ${1} " ]] && echo "true")

    if [[ -n ${AWS_REQUIRED} ]]; then
        local PULUMI_AWS_PROFILE=$(command pulumi config get aws:profile 2> /dev/null)
        local ROLE_ARN=$(aws configure get profile.${PULUMI_AWS_PROFILE}.role_arn)
    fi

    if [[ -n ${ROLE_ARN} ]]; then
        echo "Using AWS Profile: ${PULUMI_AWS_PROFILE}"
        local AWS_ROLE_USER_ID=$(aws --profile ${PULUMI_AWS_PROFILE} sts get-caller-identity |jq -r '.UserId')
        if [[ -z ${AWS_ROLE_USER_ID} ]]; then return; fi

        local AWS_CREDENTIALS=$(grep -hs ${AWS_ROLE_USER_ID} ~/.aws/cli/cache/*.json)

        AWS_ACCESS_KEY_ID=$(echo ${AWS_CREDENTIALS} | jq -r '.Credentials.AccessKeyId') \
        AWS_SECRET_ACCESS_KEY=$(echo ${AWS_CREDENTIALS} | jq -r '.Credentials.SecretAccessKey') \
        AWS_SESSION_TOKEN=$(echo ${AWS_CREDENTIALS} | jq -r '.Credentials.SessionToken') \
        command pulumi ${@}
    else
        command pulumi ${@}
    fi
}


# Code
##################################################################

function delete_branch () {
    branch=$1
    git branch -d $branch
    if [[ "$status" == 0 ]]; then
        echo "Not deleting from origin until issues above are resolved"
        return 1
    else
        git push origin --delete $branch
    fi
}

function list_merged () {
    for branch in `git branch -r --merged | grep -v HEAD`;do echo -e `git show --format="%ai %ar by %an" $branch | head -n 1` \\t$branch; done | sort -r
}

function list_unmerged () {
    for branch in `git branch -r --no-merged | grep -v HEAD`;do echo -e `git show --format="%ai %ar by %an" $branch | head -n 1` \\t$branch; done | sort -r
}

function release () {
    git checkout develop && git pull && git checkout -b release/${1} && git push -u origin release/${1}
}

