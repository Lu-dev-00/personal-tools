#!/usr/bin/bash
cd "$(dirname "$0")"
repo=$1
export $(cat ./config | xargs)
echo $git_username



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
  gh repo create $1 --public
elif [ "$public" = false ]; then
   gh repo create $1 --private
else
  echo "Invalid input: public must be either true or false"
fi

repo_string="git@github.com:${git_username}/$1.git"
if git ls-remote $repo_string; then
    git add -A
    git commit -m "Fast repo commit"
    git remote add origin $repo_string
    git branch -M main
    git push -u origin main
fi

