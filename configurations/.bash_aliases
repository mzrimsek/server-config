# docker aliases
dki() {
	sudo docker image $@
}

dkc() {
	sudo docker container $@
}
alias dclean="sudo docker system prune"

# k3s aliases
k3sk() {
	sudo k3s kubectl $@
}

k3sra() {
	env-replace $@ | k3sk apply -f -
}

k3srd() {
	env-replace $@ | k3sk delete -f -
}

alias own="sudo chown -R $(id -u)"

f2bc() {
	sudo fail2ban-client $@
}

