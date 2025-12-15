ARG GITLAB_RUNNER_IMAGE_TYPE
ARG GITLAB_RUNNER_IMAGE_TAG
FROM gitlab/${GITLAB_RUNNER_IMAGE_TYPE}:${GITLAB_RUNNER_IMAGE_TAG}

RUN apt-get update && \
	apt-get upgrade && \
	apt-get install -y \
		build-essential \
		curl \
		wget \
		file \
		libxdo-dev \
		libssl-dev \
		libayatana-appindicator3-dev \
		librsvg2-dev \
		nsis llvm lld clang &&\
	curl --proto '=https' --tlsv1.2 https://sh.rustup.rs -sSf | sh -s -- -y && \
	. ~/.bash_profile && \
	rustup target add x86_64-pc-windows-msvc && \
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
	

ENV NVM_DIR=/root/.nvm

RUN	bash -c "source $NVM_DIR/nvm.sh && nvm install 22" && \
	corepack enable pnpm

