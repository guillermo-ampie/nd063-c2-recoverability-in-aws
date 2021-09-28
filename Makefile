network:
	./bin/deploy-network.sh

website:
	./bin/deploy-website.sh


clean:
	-./bin/delete-network.sh
	-./bin/delete-website.sh
