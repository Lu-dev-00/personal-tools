#!/usr/bin/bash
configdir="$(dirname "$0")"
repo=$1
git_username="$(git config --get user.name)"

create_repo () {
    if [ -d "./.git" ]; then
        echo "Local repo exists skipping init"
    else
        echo "Creating local repo"
        git init
    fi
    git add -A
    git commit -m "Fast repo commit"
    git remote add origin $repo_string
    git branch -M main
    git push -u origin main
}

fr () {
    # check if the public variable is given as an argument
    if [ -n "$2" ]; then
    # assign the argument to the public variable
    public=$2
    else
    # default to true if no argument is given
    public=true
    fi

    # check if the public variable is true or false
    if [ "$public" = true ]; then
    gh repo create $repo --public
    elif [ "$public" = false ]; then
    gh repo create $repo --private
    else
    echo "Invalid input: public must be either true or false"
    fi


    repo_string="git@github.com:${git_username}/$repo.git"
    if git ls-remote $repo_string; then
    create_repo
    fi
}

if [ -z ${git_username+x} ]; then
	echo "Please set your git user.name"
else
	echo $git_username
	echo $1
	fr
fi

