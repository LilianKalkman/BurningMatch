# <u>Git manual</u>



- Repository on Github.com is called 'origin'
- Local default repository is 'master' 
- Create local branches of repository when working on certain functionality
- Commit to local branch
- Push local-branch to origin 
- Create pullrequest on github
- Merge if no conflict or conflicts resolved



*Create git on Github* : https://github.com/YOUR_GITHUB_USERNAME/GIT_NAME

*Create new git in devevelopment folder* (not needed for Rails app)

```shell
$ git init
$ git add .
$ git commit -m "Initial commit, something descriptive"
$ git remote add origin git@github.com:YOUR_GITHUB_USER/GIT_NAME.git
$ git push -u origin master
```



*Cloning  remote repository*

```shell
$ git clone https://github.com/GITHUB_USERNAME/GIT_NAME.git
```

- Creates a directory named `GIT_NAME`,
- initializes a `.git` directory inside it,
- pulls down all the data for that repository,
- and checks out a working copy of the latest version



*Cloning  remote repository* to specific folder 

```shell
$ git clone https://github.com/GITHUB_USERNAME/GIT_NAME.git myFolder
```



When working in team (but also advisable working on you own project )

*Switch to local branch*

```shell
$ git branch local-branch
$ git checkout local-branch
$ git add .
$ git commit -m "Meaningfull description"
```

Have a dedicated branch for each new feature.

**Find out :  Can branch names have dashes?**



*Once in a while, push local branch to 'origin'*

```shell
$ git push -u origin local-branch
```



On https://github.com/GITHUB_USERNAME/GIT_NAME.git 

* Create pull request from pushes
* Resolve conflicts if any
* Merge pull requests



*Pull updates from remote repository*

```shell
$ git checkout master
$ git pull origin master
$ git checkout local-branch
```

If finished with current local-branch

delete current local-branch, checkout new local branch

```shell
$ git branch master
$ git branch -d local-branch
$ git checkout -b new-local-branch
```

(Last line is short for *$ git branch new-local-branch*, *$ git checkout new-local-branch*)



**Check out:** 

```shell
$ git checkout -b
$ git fetch -all
$ git checkout 'remote-branch'
$ git checkout ' remote-branch' origin/'remote-branch'
$ git reset --hard origin/branch-name
$ git status
```

