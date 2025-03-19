# https://stackoverflow.com/questions/52699177/how-to-fix-filename-too-long-error-during-git-clone
& git config --global core.longpaths true

# https://stackoverflow.com/questions/5787937/git-status-shows-files-as-changed-even-though-contents-are-the-same#:~:text=ignore%20them%20by-,git%20config%20core.filemode%20false,-Share
& git config --global core.filemode false