build:
	cd 0.12.3.0 && docker build -t messari/monero-core:0.12.3.0 .
	docker tag messari/monero-core:0.12.3.0 messari/monero-core:latest

push:
	docker push messari/monero-core:0.12.3.0
	docker push messari/monero-core:latest
