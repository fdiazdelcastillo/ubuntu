docker stop $(docker ps -a -q)
docker system prune --all
docker volume rm $(docker volume ls)
docker network rm -f erpnext-one
docker network rm -f mariadb-network
docker network rm -f raefik-public
rm -r /home/ubuntu/frappe_docker
rm -r ~/gitops/